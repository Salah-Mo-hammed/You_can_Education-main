import 'package:dartz/dartz.dart';
import 'package:grad_project_ver_1/core/errors/failure.dart';
import 'package:grad_project_ver_1/features/auth/data/models/user_model.dart';
import 'package:grad_project_ver_1/features/auth/data/source/remote/auth_data_source.dart';
import 'package:grad_project_ver_1/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  AuthDataSource authDataSource;
  AuthRepoImpl({required this.authDataSource});
  @override
  Future<Either<Failure, UserModel>> logInUser(String email, String password) {
    return authDataSource.logInUser(email, password);
  }

  @override
  Future<Either<Failure, Unit>> logOutUser() {
    return authDataSource.logOutUser();
  }

  @override
  Future<Either<Failure, UserModel>> registerUser(
    String email,
    String password,
    String role,
  ) {
    return authDataSource.registerUser(email, password,role);
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(String email) {
    return authDataSource.resetPassword(email);
  }

  @override
  Future<bool> isLoggedIn() {
    return authDataSource.isLoggedIn();
  }
}
