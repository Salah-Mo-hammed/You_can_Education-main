import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/auth/domain/entities/user_entity.dart';
import 'package:grad_project_ver_1/features/auth/domain/repo/auth_repo.dart';

class RegisterUsecase {
  AuthRepo repo;
  RegisterUsecase({required this.repo});
  Future<Either<Failure, UserEntity>> call(String email, String password,String role) {
    return repo.registerUser(email, password,role);
  }
}
