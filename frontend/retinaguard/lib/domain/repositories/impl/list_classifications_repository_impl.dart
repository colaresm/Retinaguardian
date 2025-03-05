import 'package:retinaguard/data/datasources/list_classifications_data_source.dart';
import 'package:retinaguard/domain/entities/classification_response.dart';
import 'package:retinaguard/domain/repositories/list_classification_repository.dart';

class ListClassificationsRepositoryImpl implements ListClassificationsRepository{
  final ListClassificationsDataSource listClassificationsDataSource;

  ListClassificationsRepositoryImpl(this.listClassificationsDataSource);
  @override
  Future<List<ClassificationResponse>> getClassifications(
      String patientId) async {
    return await listClassificationsDataSource
        .getClassificationsByPatient(patientId);
  }
}
