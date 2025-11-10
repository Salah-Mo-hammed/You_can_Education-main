import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> logInUser(String email, String password);
  Future<Either<Failure, UserEntity>> registerUser(
    String email,
    String password,
    String role,
  );
  Future<Either<Failure, Unit>> logOutUser();
  Future<Either<Failure, Unit>> resetPassword(String email);
  Future<bool> isLoggedIn();
}
