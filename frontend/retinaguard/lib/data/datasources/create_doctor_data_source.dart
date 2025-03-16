import 'dart:convert';

import 'package:retinaguard/data/models/create_doctor_model.dart';
import 'package:retinaguard/data/models/create_doctor_response_model.dart';
import 'package:retinaguard/data/models/error_response.dart';
import 'package:http/http.dart' as http;

abstract class CreateDoctorDataSource {
  Future<EmptyResponseModel> create(CreateDoctorModel createDoctorModel);
}

class CreateDoctorDataSourceImpl implements CreateDoctorDataSource {
  @override
  Future<EmptyResponseModel> create(CreateDoctorModel createDoctorModel) async {
    var url = Uri.http('localhost:8034', '/api/doctor');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(createDoctorModel.toJson()),
    );

    if (response.statusCode == 201) {
      return EmptyResponseModel();
    } else {
      throw ErrorModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes)))
          .message;
    }
  }
}
