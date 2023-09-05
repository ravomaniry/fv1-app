import 'dart:convert';

import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching_summary.dart';
import 'package:http/http.dart' as http;

class AppHttpClient {
  final _baseUrl = '192.168.0.128:3000';

  Future<List<ProgressModel>> getProgresses() async {
    final resp = await _get('api/progresses.json');
    return _decodeList(resp, (body) => ProgressModel.fromJson(body));
  }

  Future<ProgressModel> startTeaching(int id) async {
    final resp = await _get('api/start-teaching.json');
    return ProgressModel.fromJson(jsonDecode(resp));
  }

  Future<String> getAudioUrl(int id) async {
    return '$_baseUrl/audios/$id.mp3';
  }

  Future<List<TeachingSummaryModel>> loadNewTeachings() async {
    final resp = await _get('api/new-teachings.json');
    return _decodeList(resp, (body) => TeachingSummaryModel.fromJson(body));
  }

  Future<String> _get(String endpoint) async {
    final uri = Uri.http(_baseUrl, endpoint);
    final resp = await http.get(uri);
    return resp.body;
  }

  List<T> _decodeList<T>(String body, T Function(dynamic body) parser) {
    return List<T>.from(jsonDecode(body).map(parser));
  }
}
