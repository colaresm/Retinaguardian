abstract class LoginEvent {}

class AuthEvent extends LoginEvent {
  final String email;
  final String password;

  AuthEvent(this.email, this.password);
}
