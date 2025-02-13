abstract class LoginEvent {}

class AuthEvent extends LoginEvent {
  final String email;
  final String password;

  AuthEvent({required this.email,required this.password});
}

class AuthInitialEvent extends LoginEvent {}
