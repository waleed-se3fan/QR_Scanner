import 'package:dartz/dartz.dart';
import 'package:qr_scanner/core/error/failure.dart';
import 'package:qr_scanner/features/home/domain/repositories/scan_repositories.dart';

class ScanUseCases {
  final ScanRepository scanRepository;
  ScanUseCases(this.scanRepository);
  Future<void> requestCameraPermission() async {
    return await scanRepository.requestCameraPermission();
  }

  Future<void> onQRViewCreated(controller) async {
    return await scanRepository.onQRViewCreated(controller);
  }

  Future<void> toggleFlash() async {
    return await scanRepository.toggleFlash();
  }

  Future<void> getQRFromGallery() async {
    return await scanRepository.getQRFromGallery();
  }

  Future<Either<Failure, List>> insertAndFetch(String scanData) async {
    return await scanRepository.insertAndFetch(scanData);
  }
}
