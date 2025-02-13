import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retinaguard/domain/use_cases/login_use_case.dart';
import 'package:retinaguard/presentation/login/bloc/events/login_event.dart';
import 'package:retinaguard/presentation/login/bloc/states/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase _loginUseCase;

  LoginBloc(this._loginUseCase) : super(LoginInitial()) {
    on<AuthEvent>((event, emit) async {
      emit(LoginLoading());
      try {
        final user = await _loginUseCase.execute(event.email, event.password);
        emit(LoginSuccess(user.accessToken));
      } catch (e) {
        emit(LoginError(e.toString()));
      }
    });
    on<AuthInitialEvent>((event, emit) async {
      emit(LoginLoading());
    });
  }
}
