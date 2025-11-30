
abstract class AuthEvent {}

class AuthLogInEvent extends AuthEvent {
  final String email;
  final String password;
  AuthLogInEvent({required this.email, required this.password});
}

class AuthLogOutEvent extends AuthEvent {}

class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String role;
  AuthRegisterEvent({ required this.email, required this.password,required this.role,});
}

class AuthResetPassEvent extends AuthEvent {
  final String email;

  AuthResetPassEvent({required this.email});
}

class GetAuthStatusEvent extends AuthEvent {}
