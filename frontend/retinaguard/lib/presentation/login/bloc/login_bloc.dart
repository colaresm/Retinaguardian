import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retinaguard/domain/use_cases/login_use_case.dart';
import 'package:retinaguard/presentation/login/bloc/events/login_event.dart';

import 'states/login_state.dart';


class LoginBloc extends Bloc<AuthEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc(this.loginUseCase) : super(LoginInitial()) {
    on<AuthEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await loginUseCase.execute(event.email, event.password);
        emit(LoginSuccess(user.accessToken));
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    });
  }
}
