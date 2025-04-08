import 'package:dartz/dartz.dart';
import 'package:qr_scanner/core/error/failure.dart';

abstract class ScanRepository {
  Future<void> requestCameraPermission();
  Future<void> onQRViewCreated(controller);
  Future<void> toggleFlash();
  Future<void> getQRFromGallery();
  Future<Either<Failure, List>> insertAndFetch(String scanData);
}
