import 'package:fv1/models/progress.dart';
import 'package:fv1/services/api_client/api_client.dart';
import 'package:fv1/services/data/data_service.dart';
import 'package:logging/logging.dart';

class ApiBasedDataService extends AbstractDataService {
  final ApiClient _apiClient;
  final _logger = Logger('ApiBasedDataService');

  ApiBasedDataService(this._apiClient) : super(_apiClient);

  @override
  Future<void> sync() async {
    // Remote clients do not sync
  }

  @override
  Future<List<ProgressModel>> loadProgresses() {
    return _apiClient.getProgresses();
  }

  @override
  Future<ProgressModel> startTeaching(int id) async {
    return _apiClient.startTeaching(id);
  }

  @override
  Future<String> getAudioUrl(String id) => _apiClient.getAudioUrl(id);

  @override
  Future<void> saveProgress(ProgressModel progress) async {
    await _apiClient.saveProgress(progress);
    _logger.info('Progress saved to remote ${progress.id}');
  }
}
