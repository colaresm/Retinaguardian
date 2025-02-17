import 'package:retinaguard/data/datasources/create_doctor_data_source.dart';
import 'package:retinaguard/data/models/create_doctor_model.dart';
import 'package:retinaguard/data/models/create_doctor_response_model.dart';
import 'package:retinaguard/domain/repositories/create_doctor_repository.dart';

class CreateDoctorRepositoryImpl implements CreateDoctorRepository {
  final CreateDoctorDataSource createDoctorDataSource;

  CreateDoctorRepositoryImpl(this.createDoctorDataSource);

  @override
  Future<EmptyResponseModel> createDoctor(CreateDoctorModel createDoctorModel) async {
    return await createDoctorDataSource.create(createDoctorModel);
  }
  
  
}