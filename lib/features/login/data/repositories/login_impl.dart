import 'package:dartz/dartz.dart';
import 'package:qr_scanner/core/error/failure.dart';
import 'package:qr_scanner/features/login/data/datasource/remote_data_source.dart';
import 'package:qr_scanner/features/login/domain/repositories/login_repo.dart';

class LoginRepositoryIml extends LoginRepository {
  final LoginRemoteDataSource loginRemoteDataSource;
  LoginRepositoryIml(this.loginRemoteDataSource);

  @override
  Future<Either<Failure, void>> login(String email, String password) async {
    try {
      await loginRemoteDataSource.login(email, password);
      return const Right('Login successful');
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
