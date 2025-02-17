import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retinaguard/domain/use_cases/create_doctor_use_case.dart';
import 'package:retinaguard/presentation/create_doctor/bloc/events/create_doctor_event.dart';
import 'package:retinaguard/presentation/create_doctor/bloc/states/create_doctor_state.dart';

class CreateDoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final CreateDoctorUseCase _createDoctorUseCase;

  CreateDoctorBloc(this._createDoctorUseCase) : super(DoctorInitialState()) {
    on<CreateDoctorEvent>((event, emit) async {
      emit(DoctorLoadingState());
      try {
        await _createDoctorUseCase.execute(event.createDoctorModel);
        emit(DoctorSuccessState());
      } catch (e) {
        emit(DoctorErrorState(e.toString()));
      }
    });
    on<DoctorInitialEvent>((event, emit) async {
      emit(DoctorInitialState());
    });
  }
}
