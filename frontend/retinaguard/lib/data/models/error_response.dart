import 'package:retinaguard/domain/entities/error.dart';

class ErrorModel extends ErrorResponse {
  ErrorModel({required super.message});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(message: json['error']);
  }
}
