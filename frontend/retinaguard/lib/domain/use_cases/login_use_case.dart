import 'package:retinaguard/domain/entities/user.dart';
import 'package:retinaguard/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> execute(String email, String password) async {
    return await repository.login(email, password);
  }
}