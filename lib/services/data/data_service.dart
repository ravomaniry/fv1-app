import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching_summary.dart';
import 'package:fv1/services/api_client/api_client.dart';

abstract class AbstractDataService {
  final ApiClient _apiClient;

  AbstractDataService(this._apiClient);

  Future<void> sync();

  Future<List<ProgressModel>> loadProgresses();

  Future<List<TeachingSummaryModel>> loadNewTeachings() async {
    return _apiClient.loadNewTeachings();
  }

  Future<ProgressModel> startTeaching(int id);

  Future<String> getAudioUrl(String id);

  Future<void> saveProgress(ProgressModel progress) async {}
}
