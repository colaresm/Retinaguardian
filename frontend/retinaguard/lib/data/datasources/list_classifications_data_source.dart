import 'dart:convert';
import 'package:retinaguard/core/token_storage.dart';
import 'package:retinaguard/data/models/classification_response_model.dart';
import 'package:retinaguard/data/models/error_response.dart';
import 'package:http/http.dart' as http;

abstract class ListClassificationsDataSource {
  Future<List<ClassificationResponseModel>> getClassificationsByPatient(
      String patientId);
}

class ListClassificationsDataSourceImpl
    implements ListClassificationsDataSource {
  @override
  Future<List<ClassificationResponseModel>> getClassificationsByPatient(
      String patientId) async {
    var url = Uri.http(
        'localhost:8034', '/api/classifications', {'patient_id': patientId});
    final token = await TokenStorage.getAccessToken();
    final response = await http.get(url,
        headers: {"Content-Type": "application/json", "Authorization": token!});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> jsonList = jsonResponse["data"];

      return jsonList
          .map((json) => ClassificationResponseModel.fromJson(json))
          .toList();
    } else {
      throw ErrorModel.fromJson(jsonDecode(response.body)).message;
    }
  }
}
