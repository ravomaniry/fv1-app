import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching_summary.dart';
import 'package:fv1/services/api_client/api_routes.dart';
import 'package:fv1/services/api_client/auth_service.dart';
import 'package:fv1/services/api_client/http_client.dart';
import 'package:fv1/services/api_client/request_dtos.dart';
import 'package:fv1/services/api_client/response_dtos.dart';

class ApiClient {
  final CustomHttpClient _client;
  final ApiRoutes _routes;

  ApiClient(AuthService authService, this._routes, this._client);

  Future<List<ProgressModel>> getProgresses() async {
    return await GetProgressDto().parse(_client.get(_routes.progress));
  }

  Future<ProgressModel> startTeaching(int id) async {
    return await StartTeachingDto()
        .parse(_client.postJson(_routes.startTeaching, {'teachingId': id}));
  }

  Future<String> getAudioUrl(String id) async {
    return await GetAudioUrlDto().parse(_client.get(_routes.audioUrl(id)));
  }

  Future<List<TeachingSummaryModel>> loadNewTeachings() async {
    return await GetNewTeachingsDto().parse(_client.get(_routes.teachingNew));
  }

  Future<void> saveProgress(ProgressModel progress) async {
    await _client.putJson(
      _routes.saveProgress(progress.id),
      SaveProgressReqDto(progress).data,
    );
  }

  Future<void> syncProgress(ProgressModel progress) async {
    await _client.putJson(
      _routes.syncProgress(progress.id),
      SaveProgressReqDto(progress).data,
    );
  }
}
