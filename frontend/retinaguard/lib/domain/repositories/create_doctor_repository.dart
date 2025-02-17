import 'package:retinaguard/data/models/create_doctor_model.dart';
import 'package:retinaguard/data/models/create_doctor_response_model.dart';

abstract class CreateDoctorRepository {
  Future<EmptyResponseModel> createDoctor(CreateDoctorModel createDoctorModel);
}