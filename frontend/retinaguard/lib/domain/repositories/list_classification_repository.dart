import 'package:retinaguard/domain/entities/classification_response.dart';

abstract class ListClassificationsRepository {
  Future<List<ClassificationResponse>> getClassifications(String patientId);
}
