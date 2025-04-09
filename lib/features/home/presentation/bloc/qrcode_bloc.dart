// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/features/home/data/data_source/scan_data_source.dart';
import 'package:qr_scanner/features/home/data/repository/scan_repo_impl.dart';
import 'package:qr_scanner/features/home/domain/use_cases/scan_usecase.dart';

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

  getScanResult() async {
    emit(LoadingScanResultState());

    final result = await scanUseCase.getFromSubBase();
    result.fold((failure) {
      emit(ErrorScanResultState(failure.message));
    }, (data) {
      emit(SuccesScanResultState(data));
    });
  }
}
