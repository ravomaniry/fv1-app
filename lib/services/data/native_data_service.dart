import 'package:fv1/models/progress.dart';
import 'package:fv1/services/data/data_service.dart';
import 'package:fv1/services/data/http_client.dart';

class NativeDataService extends AbstractDataService {
  final AppHttpClient _httpClient;

  NativeDataService(this._httpClient) : super(_httpClient);

  @override
  Future<void> sync() async {
    // Save the local progress to remote
  }

  @override
  Future<List<ProgressModel>> loadProgresses() {
    // native client should read the local progress
    return _httpClient.getProgresses();
  }

  @override
  Future<ProgressModel> startTeaching(int id) async {
    return _httpClient.startTeaching(id);
  }

  @override
  Future<String> getAudioUrl(int id) => _httpClient.getAudioUrl(id);
}
