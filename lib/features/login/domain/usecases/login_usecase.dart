import 'package:dartz/dartz.dart';
import 'package:qr_scanner/core/error/failure.dart';
import 'package:qr_scanner/features/login/domain/repositories/login_repo.dart';

class LoginUseCase {
  final LoginRepository loginRepository;
  LoginUseCase(this.loginRepository);
  Future<Either<Failure, void>> call(email, password) async {
    return await loginRepository.login(email, password);
  }
}
