import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/core/error/failure.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ScanDataSource {
  Future<void> requestCameraPermission();
  Future<void> onQRViewCreated(controller);
  Future<void> toggleFlash();
  Future<void> getQRFromGallery();
  Future insertAndFetch(String scanData);
}

class ScanDataSourceImpl extends ScanDataSource {
  QRViewController? controller;
  @override
  Future<void> getQRFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      print(imageFile.path);
    }
  }

  static List qrdata = [];
  @override
  Future insertAndFetch(String scanData) async {
    final supabase = Supabase.instance.client;
    print('////////// Start insertAndFetch //////////');

    try {
      final insertResponse =
          await supabase.from('qr_code').insert({'qr_co': scanData}).select();

      if (insertResponse.isEmpty) {
        print('No data was inserted.');
      }

      print('Inserted data: $insertResponse');

      final fetchResponse = await supabase.from('qr_code').select('qr_co');
      final data = fetchResponse;
      for (final row in data) {
        qrdata.add(row['qr_co']);
        print(row['qr_co']);
      }
      print(qrdata);
      return qrdata;
    } catch (error) {
      print('Error during insert or fetch: $error');
      return 'Error during insert or fetch: $error';
    }
  }

  @override
  Future<void> onQRViewCreated(controller) async {
    this.controller = controller;

    String scan;
    controller.scannedDataStream.listen((scanData) {
      scan = scanData.code!;

      print("QR : ${scanData.code}");
      if (scanData.code != null) {
        print(
            '-----------------------------------------------------------------------');
        insertAndFetch(scanData.code.toString());

        controller.pauseCamera();
      } else {
        print(
            '+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++');
        print(scanData.code!.toString());
      }
    });
  }

  @override
  Future<void> requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    if (status.isGranted) {
      print("Camera permission granted");
    } else {
      print(" Camera permission denied");
    }
  }

  @override
  Future<void> toggleFlash() async {
    if (controller != null) {
      await controller!.toggleFlash();
    }
  }
}
