part of 'qrcode_bloc.dart';

@immutable
sealed class QrcodeEvent {}

class RequestPermissionEvent extends QrcodeEvent {}

class QRViewCreatedEvent extends QrcodeEvent {
  final QRViewController controller;

  QRViewCreatedEvent(this.controller);
}

class ToggleFlashEvent extends QrcodeEvent {}

class GetQRFromGalleryEvent extends QrcodeEvent {}

class GetScanResultEvent extends QrcodeEvent {}
