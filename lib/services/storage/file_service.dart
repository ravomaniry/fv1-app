import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class FileService {
  String? _root;
  final _logger = Logger('FileService');

  Future<String> _buildPath(String key) async {
    if (_root == null) {
      await _waitForRoot();
      _root = (await getApplicationDocumentsDirectory()).path;
    }
    return path.join(_root!, key);
  }

  Future<void> createDir(key) async {
    final path = await _buildPath(key);
    await Directory(path).create(recursive: true);
  }

  Future<String> readText(String key) async {
    final fullP = await _buildPath(key);
    final file = File(fullP);
    return await file.readAsString();
  }

  Future<T> readJson<T>(String key, T Function(dynamic v) map) async {
    final str = await readText(key);
    return map(jsonDecode(str));
  }

  Future writeJson(String key, Map<dynamic, dynamic> value) async {
    await _writeText(key, jsonEncode(value));
    _logger.info('Json written $key');
  }

  Future<void> deleteFile(String key) async {
    await File(await _buildPath(key)).delete();
  }

  Future _writeText(String key, String content) async {
    final p = await _buildPath(key);
    final file = File(p);
    await file.writeAsString(content);
  }

  /// Returns file names
  Future<List<String>> list(String key) async {
    final list = <String>[];
    final completer = Completer<List<String>>();
    final p = await _buildPath(key);
    Directory(p).list().listen(
          (item) => list.add(path.basename(item.path)),
          onDone: () => completer.complete(list),
          onError: (err) => completer.completeError(err),
          cancelOnError: true,
        );
    return completer.future;
  }

  Future<void> _waitForRoot() async {
    try {
      await getApplicationDocumentsDirectory();
    } catch (e) {
      _logger.info('getApplicationDocumentsDirectory not ready ', e);
      await Future.delayed(const Duration(milliseconds: 100));
      _waitForRoot();
    }
  }
}
