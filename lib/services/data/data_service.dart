import 'package:flutter/foundation.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching_summary.dart';
import 'package:fv1/services/api_client/api_client.dart';
import 'package:fv1/services/data/api_data_service.dart';
import 'package:fv1/services/data/native_data_service.dart';

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

  Future<void> saveProgress(ProgressModel progress);
}

AbstractDataService createDataService(ApiClient apiClient) {
  return kIsWeb ? ApiBasedDataService(apiClient) : NativeDataService(apiClient);
}
