import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'qrcode_event.dart';
part 'qrcode_state.dart';

class QrcodeBloc extends Bloc<QrcodeEvent, QrcodeState> {
  QrcodeBloc() : super(QrcodeInitial()) {
    on<QrcodeEvent>((event, emit) {
      requestCameraPermission();
    });
    on<RequestPermissionEvent>((event, emit) {
      requestCameraPermission();
    });
    on<QRViewCreatedEvent>((event, emit) {
      onQRViewCreated(event.controller);
    });
    on<ToggleFlashEvent>((event, emit) {
      toggleFlash();
    });
    on<GetQRFromGalleryEvent>((event, emit) {
      getQRFromGallery();
    });
  }
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

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

  QRViewController? controller;
  bool flashOn = false;
  bool isScanning = true;
  bool alreadyHaverequest = false;

  void toggleFlash() async {
    if (controller != null) {
      await controller!.toggleFlash();
    }
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      print("QR Code: ${scanData.code}");
      if (scanData.code != null) {
        print(scanData.code!.toString());
        controller.pauseCamera();
      }
    });
  }

  Future<void> getQRFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      File imageFile = File(pickedImage.path);
      print(imageFile.path);
    }
  }

  Future<void> insertAndFetch(String code) async {
    final supabase = Supabase.instance.client;
    print('////////// Start insertAndFetch //////////');

    try {
      final insertResponse =
          await supabase.from('qr_code').insert({'qr_co': code}).select();

      if (insertResponse.isEmpty) {
        print('No data was inserted.');
        return;
      }

      print('Inserted data: $insertResponse');

      final fetchResponse =
          await supabase.from('qr_code').select().eq('qr_co', '000000000');

      if (fetchResponse.isEmpty) {
        print('No data found for qr_code: 000000000');
      } else {
        print('Fetched data: $fetchResponse');
      }
    } catch (error) {
      print('Error during insert or fetch: $error');
    }

    print('////////// End insertAndFetch //////////');
  }
}
