import 'package:retinaguard/domain/entities/classification_response.dart';
import 'package:retinaguard/domain/repositories/list_classification_repository.dart';

class ListClassificationsUseCase {
  final ListClassificationsRepository repository;
  ListClassificationsUseCase(this.repository);
  Future<List<ClassificationResponse>> execute(String patientId) async {
    return await repository.getClassifications(patientId);
  }
}