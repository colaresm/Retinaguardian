import 'package:retinaguard/domain/entities/classification_response.dart';

abstract class ListClassificationsState {}

class ListClassificationsInitial extends ListClassificationsState {}

class ListClassificationsLoading extends ListClassificationsState {}

class ListClassificationsSuccess extends ListClassificationsState {
  final List<ClassificationResponse> classifications;

  ListClassificationsSuccess({required this.classifications});
}

class ListClassificationsError extends ListClassificationsState {
  final String message;

  ListClassificationsError(this.message);
}
