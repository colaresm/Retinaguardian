import 'package:retinaguard/data/models/create_doctor_model.dart';

abstract class DoctorEvent {}

class CreateDoctorEvent extends DoctorEvent {
  final CreateDoctorModel createDoctorModel;
  CreateDoctorEvent({required this.createDoctorModel});
}

class DoctorInitialEvent extends DoctorEvent {}
