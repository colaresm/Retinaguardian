
import 'package:get_it/get_it.dart';
import 'package:retinaguard/data/datasources/auth_remote_data_source.dart';
import 'package:retinaguard/domain/repositories/impl/auth_repository_impl.dart';
import 'package:retinaguard/presentation/login/bloc/login_bloc.dart';

import 'login_use_case.dart';

final getDependency = GetIt.instance;

void dependencyInjection() {
  getDependency.registerLazySingleton(() => AuthRemoteDataSourceImpl());
  getDependency.registerLazySingleton(() => AuthRepositoryImpl(getDependency<AuthRemoteDataSourceImpl>()));
  getDependency.registerLazySingleton(() => LoginUseCase(getDependency<AuthRepositoryImpl>()));
  getDependency.registerFactory(() => LoginBloc(getDependency<LoginUseCase>(),));
}