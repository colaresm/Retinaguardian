
abstract class ListClassificationsEvent {}

class GetClassificationsEvent extends ListClassificationsEvent {
  final String patientId;

  GetClassificationsEvent({required this.patientId});
}
class ListClassificationsInitialEvent extends ListClassificationsEvent {}