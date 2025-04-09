import 'package:dartz/dartz.dart';
import 'package:qr_scanner/core/error/failure.dart';
import 'package:qr_scanner/features/home/data/data_source/scan_data_source.dart';
import 'package:qr_scanner/features/home/domain/repositories/scan_repositories.dart';

class ScanRepoImplementation extends ScanRepository {
  final ScanDataSource scanDataSource;
  ScanRepoImplementation(this.scanDataSource);
  @override
  Future<void> getQRFromGallery() async {
    scanDataSource.getQRFromGallery();
  }

  @override
  Future<Either<Failure, List>> insertToSubBase(String scanData) async {
    try {
      await scanDataSource.insertToSubase(scanData);
      return Right(ScanDataSourceImpl.qrdata);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<void> onQRViewCreated(controller) async {
    await scanDataSource.onQRViewCreated(controller);
  }

  @override
  Future<void> requestCameraPermission() async {
    await scanDataSource.requestCameraPermission();
  }

  @override
  Future<void> toggleFlash() async {
    await scanDataSource.toggleFlash();
  }

  @override
  Future<Either<Failure, List>> getFromSubBase() async {
    try {
      await scanDataSource.getFromSubBase();
      return Right(ScanDataSourceImpl.qrdata);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
