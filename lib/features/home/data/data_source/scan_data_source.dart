import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
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
  Future insertToSubase(String scanData);
  Future getFromSubBase();
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
      insertToSubase('http://example.com/qr_code.png');
      print(imageFile.path);
    }
  }

  @override
  Future insertToSubase(String scanData) async {
    final supabase = Supabase.instance.client;
    print('////////// Start insertAndFetch //////////');

    try {
      final insertResponse =
          await supabase.from('qr_code').insert({'qr_co': scanData}).select();

      if (insertResponse.isEmpty) {
        print('No data was inserted.');
      }

      print('Inserted data: $insertResponse');
    } catch (error) {
      print('Error during insert or fetch: $error');
      return 'Error during insert or fetch: $error';
    }
  }

  static List qrdata = [];

  void addDataToHive(String value) async {
    try {
      var box = await Hive.openBox('qrResults');
      box.add(value);
      print('Data added: $value');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<String>> getDataFromHive() async {
    try {
      var box = await Hive.openBox('qrResults');

      List<String> allValues = box.values.cast<String>().toList();
      // print('Stored List: $allValues');
      return allValues;
    } catch (e) {
      print('Error: ${e.toString()}');
      return [];
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
        addDataToHive(scanData.code.toString());
        insertToSubase(scanData.code.toString());

        controller.pauseCamera();
      } else {
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

  @override
  Future getFromSubBase() async {
    try {
      qrdata.clear();
      final supabase = Supabase.instance.client;
      final fetchResponse = await supabase.from('qr_code').select('qr_co');
      final data = fetchResponse;
      for (final row in data) {
        qrdata.add(row['qr_co']);
        print(row['qr_co']);
      }
      print(qrdata);
      return qrdata;
    } catch (e) {
      qrdata = await getDataFromHive();

      return qrdata;
    }
  }
}
