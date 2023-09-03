import 'dart:convert';

import 'package:fv1/models/progress.dart';
import 'package:http/http.dart' as http;

class AppHttpClient {
  final _baseUrl = '192.168.0.128:3000';

  Future<List<ProgressModel>> getProgresses() async {
    final uri = Uri.http(_baseUrl, 'api/progresses.json');
    final resp = await http.get(uri);
    return _decodeList(resp.body, (body) => ProgressModel.fromJson(body));
  }

  List<T> _decodeList<T>(String body, T Function(dynamic body) parser) {
    return List<T>.from(jsonDecode(body).map(parser));
  }
}
