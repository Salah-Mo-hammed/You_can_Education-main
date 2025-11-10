import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/auth/domain/repo/auth_repo.dart';

class ForgetPassUsecase {
  AuthRepo repo;
  ForgetPassUsecase({required this.repo});
  Future<Either<Failure, Unit>> call(String email) {
    return repo.resetPassword(email);
  }
}
