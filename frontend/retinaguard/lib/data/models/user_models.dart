

import 'package:retinaguard/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.accessToken});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(accessToken: json['access_token']);
  }
}
