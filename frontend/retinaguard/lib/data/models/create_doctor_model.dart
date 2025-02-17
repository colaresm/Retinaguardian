import 'package:retinaguard/data/models/create_user_model.dart';
import 'package:retinaguard/domain/entities/create_doctor.dart';

class CreateDoctorModel extends CreateDoctor {
  CreateDoctorModel({
    required super.name,
    required super.crm,
    required super.birthday,
    required super.user,
  });

  factory CreateDoctorModel.fromJson(Map<String, dynamic> json) {
    return CreateDoctorModel(
      name: json['name'],
      crm: json['crm'],
      birthday: json['birthday'],
      user: CreateUserModel.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'crm': crm,
      'birthday': birthday,
      'user': user.toJson(),
    };
  }
}
