import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/auth/domain/repo/auth_repo.dart';

class LogOutUsecase {
  AuthRepo repo;
  LogOutUsecase({required this.repo});
  Future<Either<Failure, Unit>> call() {
    return repo.logOutUser();
  }
}
