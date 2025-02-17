import 'package:retinaguard/domain/entities/create_user.dart';

class CreateUserModel extends CreateUser {
  CreateUserModel({
    required super.email,
    required super.password,
  });

  factory CreateUserModel.fromJson(Map<String, dynamic> json) {
    return CreateUserModel(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
