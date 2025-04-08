import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/features/home/data/data_source/scan_data_source.dart';
import 'package:qr_scanner/features/home/data/repository/scan_repo_impl.dart';
import 'package:qr_scanner/features/home/domain/use_cases/scan_usecase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'qrcode_event.dart';
part 'qrcode_state.dart';

class QrcodeBloc extends Bloc<QrcodeEvent, QrcodeState> {
  QrcodeBloc() : super(QrcodeInitial()) {
    on<QrcodeEvent>((event, emit) {});
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
    on<GetScanResultEvent>((event, emit) {
      getScanResult();
    });
  }
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final scanUseCase =
      ScanUseCases(ScanRepoImplementation(ScanDataSourceImpl()));

  Future<void> requestCameraPermission() async {
    scanUseCase.requestCameraPermission();
  }

  QRViewController? controller;
  bool flashOn = false;
  bool isScanning = true;
  bool alreadyHaverequest = false;

  void toggleFlash() async {
    scanUseCase.toggleFlash();
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    scanUseCase.onQRViewCreated(controller);
  }

  Future<void> getQRFromGallery() async {
    scanUseCase.getQRFromGallery();
  }

  List qrdata = [];
  Future<void> insertAndFetch(String code) async {
    var result = await scanUseCase.insertAndFetch(code);
    result.fold((l) => print('object'), (r) => print(r));
  }

  List scan_result = [];
  getScanResult() async {
    emit(LoadingScanResultState());
    try {
      final supabase = Supabase.instance.client;

      final fetchResponse = await supabase.from('qr_code').select('qr_co');
      final data = fetchResponse;
      for (final row in data) {
        scan_result.add(row['qr_co']);
        print(row['qr_co']);
      }
      print(scan_result);
      emit(SuccesScanResultState(scan_result));
    } catch (e) {
      emit(ErrorScanResultState(e.toString()));
    }
  }
}
