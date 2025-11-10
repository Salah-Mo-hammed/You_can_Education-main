import 'package:grad_project_ver_1/features/auth/domain/entities/user_entity.dart';

abstract class AuthState {
  final String? userId;
  final String? message;
  const AuthState({this.message, this.userId});
}

class AuthStateInitial extends AuthState {
  const AuthStateInitial();
}

class Authenticated extends AuthState {
  final UserEntity authUser;
  const Authenticated({required this.authUser});
}

class UnAuthenticated extends AuthState {
  const UnAuthenticated();
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();
}

class AuthStateException extends AuthState {
  final String? exceptionMessage;
  const AuthStateException({required this.exceptionMessage})
    : super(message: exceptionMessage);
}

class AuthStatusChecked extends AuthState {
  final bool isLoggedIn;
  const AuthStatusChecked({required this.isLoggedIn});
}
class AuthStateSuccessReset extends AuthState {
  final String doneMessage;
  const AuthStateSuccessReset({required this.doneMessage});
}