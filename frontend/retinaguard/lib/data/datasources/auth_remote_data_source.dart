import 'dart:convert';

import 'package:retinaguard/data/models/user_models.dart';
import 'package:http/http.dart' as http;

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserModel> login(String email, String password) async {
    var url = Uri.https('example.com', 'whatsit/create');
    final response =
        await http.post(url, body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erro ao fazer login');
    }
  }
}
