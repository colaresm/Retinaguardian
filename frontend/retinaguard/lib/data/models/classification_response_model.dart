import 'package:retinaguard/domain/entities/classification_response.dart';

class ClassificationResponseModel extends ClassificationResponse {
  ClassificationResponseModel({
    required super.prediction,
    required super.performedDate,
    required super.retinography,
  });

  factory ClassificationResponseModel.fromJson(Map<String, dynamic> json) {
    return ClassificationResponseModel(
      prediction: json['prediction'],
      performedDate: json['performed_date'],
      retinography: json['retinography'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'prediction': prediction,
      'performed_date': performedDate,
      'retinography': retinography,
    };
  }
}
