import 'package:retinaguard/data/models/create_doctor_model.dart';
import 'package:retinaguard/data/models/create_doctor_response_model.dart';
import 'package:retinaguard/domain/repositories/create_doctor_repository.dart';

class CreateDoctorUseCase {
  final CreateDoctorRepository createDoctorRepository;

  CreateDoctorUseCase(this.createDoctorRepository);

  Future<EmptyResponseModel> execute(CreateDoctorModel createDoctorModel) async {
    return await createDoctorRepository.createDoctor(createDoctorModel);
  }
}