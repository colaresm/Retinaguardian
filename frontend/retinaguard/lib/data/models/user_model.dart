import 'package:retinaguard/domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.accessToken, required super.userId});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        accessToken: json['data']['access_token'],
        userId: json['data']['user_id']);
  }
}
