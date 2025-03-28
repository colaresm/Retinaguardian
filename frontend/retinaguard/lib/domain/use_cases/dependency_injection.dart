import 'package:get_it/get_it.dart';
import 'package:retinaguard/data/datasources/auth_remote_data_source.dart';
import 'package:retinaguard/data/datasources/create_doctor_data_source.dart';
import 'package:retinaguard/data/datasources/list_classifications_data_source.dart';
import 'package:retinaguard/domain/repositories/impl/auth_repository_impl.dart';
import 'package:retinaguard/domain/repositories/impl/create_doctor_repostiroy.dart';
import 'package:retinaguard/domain/repositories/impl/list_classifications_repository_impl.dart';
import 'package:retinaguard/domain/use_cases/list_classifications_use_case.dart';
import 'package:retinaguard/presentation/create_doctor/bloc/create_doctor_bloc.dart';
import 'package:retinaguard/presentation/list_classifications/bloc/list_classifications_bloc.dart';
import 'package:retinaguard/presentation/login/bloc/login_bloc.dart';

import 'create_doctor_use_case.dart';
import 'login_use_case.dart';

final getDependency = GetIt.instance;

void dependencyInjection() {
  getDependency.registerLazySingleton(() => AuthRemoteDataSourceImpl());
  getDependency.registerLazySingleton(
      () => AuthRepositoryImpl(getDependency<AuthRemoteDataSourceImpl>()));
  getDependency.registerLazySingleton(
      () => LoginUseCase(getDependency<AuthRepositoryImpl>()));
  getDependency.registerFactory(() => LoginBloc(
        getDependency<LoginUseCase>(),
      ));

  getDependency.registerLazySingleton(() => CreateDoctorDataSourceImpl());
  getDependency.registerLazySingleton(() =>
      CreateDoctorRepositoryImpl(getDependency<CreateDoctorDataSourceImpl>()));
  getDependency.registerLazySingleton(
      () => CreateDoctorUseCase(getDependency<CreateDoctorRepositoryImpl>()));
  getDependency.registerFactory(() => CreateDoctorBloc(
        getDependency<CreateDoctorUseCase>(),
      ));

  getDependency.registerLazySingleton(() => ListClassificationsDataSourceImpl());
  getDependency.registerLazySingleton(() =>
      ListClassificationsRepositoryImpl(getDependency<ListClassificationsDataSourceImpl>()));
  getDependency.registerLazySingleton(
      () => ListClassificationsUseCase(getDependency<ListClassificationsRepositoryImpl>()));
  getDependency.registerFactory(() => ListClassificationsBloc(
        getDependency<ListClassificationsUseCase>(),
      ));
}
