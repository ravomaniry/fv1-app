import 'package:fv1/models/progress.dart';
import 'package:fv1/services/api_client/api_client.dart';
import 'package:fv1/services/data/data_service.dart';

class NativeDataService extends AbstractDataService {
  final ApiClient _apiClient;

  NativeDataService(this._apiClient) : super(_apiClient);

  @override
  Future<void> sync() async {
    // Save the local progress to remote
  }

  @override
  Future<List<ProgressModel>> loadProgresses() {
    // native client should read the local progress
    return _apiClient.getProgresses();
  }

  @override
  Future<ProgressModel> startTeaching(int id) async {
    return _apiClient.startTeaching(id);
  }

  @override
  Future<String> getAudioUrl(String id) => _apiClient.getAudioUrl(id);
}
