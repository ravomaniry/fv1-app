import 'package:fv1/models/progress.dart';
import 'package:fv1/services/api_client/api_client.dart';
import 'package:fv1/services/data/api_data_service.dart';
import 'package:fv1/services/storage/file_service.dart';
import 'package:logging/logging.dart';

class NativeDataService extends ApiBasedDataService {
  final _logger = Logger('NativeDataService');
  final _progressDir = 'progress';
  final _fileService = FileService();
  final ApiClient _apiClient;

  NativeDataService(this._apiClient) : super(_apiClient) {
    _fileService.createDir(_progressDir);
  }

  @override
  Future<void> sync() async {
    await _syncLocalToRemote();
    await _syncRemoteToLocal();
  }

  Future<void> _syncLocalToRemote() async {
    final localProgresses = await _getCachedProgresses();
    for (final progress in localProgresses) {
      try {
        await _apiClient.syncProgress(progress);
        _logger.info('Synced Progress to remote ${progress.id}');
        await _fileService.deleteFile(_buildProgressKey(progress));
        _logger.info('Local copy deleted ${progress.id}');
      } catch (e) {
        _logger.warning('Failed to sync progress. '
            'This error is ignored because the progress is stored in the device.  $e');
      }
    }
  }

  Future<void> _syncRemoteToLocal() async {
    try {
      final progresses = await _apiClient.getProgresses();
      for (final progress in progresses) {
        await _saveProgressToDisk(progress);
      }
    } catch (e) {
      _logger.warning('Failed to fetch progress from API. '
          'This error is ignored and the local cache will be served to the user.  $e');
    }
  }

  @override
  Future<List<ProgressModel>> loadProgresses() async {
    return await _getCachedProgresses();
  }

  Future<List<ProgressModel>> _getCachedProgresses() async {
    final fileNames = await _fileService.list(_progressDir);
    final List<ProgressModel> progresses = [];
    for (final fileName in fileNames) {
      final progress = await _fileService.readJson(
        '$_progressDir/$fileName',
        (v) => ProgressModel.fromJson(v),
      );
      progresses.add(progress);
    }
    return progresses;
  }

  @override
  Future<void> saveProgress(ProgressModel progress) async {
    await _saveProgressToDisk(progress);
    try {
      await super.saveProgress(progress);
    } catch (e) {
      _logger.warning('Failed to save progress to remote $e');
    }
  }

  Future<void> _saveProgressToDisk(ProgressModel progress) async {
    final path = _buildProgressKey(progress);
    await _fileService.writeJson(path, progress.toJson());
    _logger.info('Progress saved locally $path');
  }

  String _buildProgressKey(ProgressModel progress) =>
      '$_progressDir/${progress.id}.json';
}
