import 'package:retinaguard/data/datasources/auth_remote_data_source.dart';
import 'package:retinaguard/domain/entities/user.dart';
import 'package:retinaguard/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }
}