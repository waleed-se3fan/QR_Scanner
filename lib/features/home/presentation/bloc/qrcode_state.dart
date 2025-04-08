part of 'qrcode_bloc.dart';

@immutable
sealed class QrcodeState {}

final class QrcodeInitial extends QrcodeState {}

final class LoadingScanResultState extends QrcodeState {}

final class SuccesScanResultState extends QrcodeState {
  final List scanResult;
  SuccesScanResultState(this.scanResult);
}

final class ErrorScanResultState extends QrcodeState {
  final String error;
  ErrorScanResultState(this.error);
}
