import 'dart:io';

import 'package:http/http.dart';
import 'package:http/retry.dart';

class CustomHttpClient extends BaseClient {
  final _inner = RetryClient(Client());

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final resp = await _inner.send(request);
    if (resp.statusCode >= 400) {
      final msg = await resp.stream.bytesToString();
      throw HttpException('Status ${resp.statusCode}; details: $msg');
    }
    return resp;
  }
}
