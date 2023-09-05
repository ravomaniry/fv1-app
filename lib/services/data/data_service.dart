import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching_summary.dart';
import 'package:fv1/services/data/http_client.dart';

abstract class AbstractDataService {
  final AppHttpClient _httpClient;

  AbstractDataService(this._httpClient);

  Future<void> sync();

  Future<List<ProgressModel>> loadProgresses();

  Future<List<TeachingSummaryModel>> loadNewTeachings() async {
    return _httpClient.loadNewTeachings();
  }

  Future<ProgressModel> startTeaching(int id);

  Future<String> getAudioUrl(int id);

  Future<void> saveProgress(ProgressModel progress) async {}
}
