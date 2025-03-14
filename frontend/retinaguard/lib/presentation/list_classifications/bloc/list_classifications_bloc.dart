import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:retinaguard/domain/use_cases/list_classifications_use_case.dart';
import 'package:retinaguard/presentation/list_classifications/bloc/events/list_classifications_event.dart';

import 'states/list_classifications_state.dart';

class ListClassificationsBloc
    extends Bloc<ListClassificationsEvent, ListClassificationsState> {
  final ListClassificationsUseCase _listClassificationsUseCase;

  ListClassificationsBloc(this._listClassificationsUseCase)
      : super(ListClassificationsInitial()) {
    on<GetClassificationsEvent>((event, emit) async {
      emit(ListClassificationsLoading());
      try {
        final response =
            await _listClassificationsUseCase.execute(event.patientId);

        emit(
          ListClassificationsSuccess(
            classifications: response,
          ),
        );
      } catch (e) {
        emit(ListClassificationsError(e.toString()));
      }
    });
    on<ListClassificationsInitialEvent>((event, emit) async {
      emit(ListClassificationsLoading());
    });
  }
}
