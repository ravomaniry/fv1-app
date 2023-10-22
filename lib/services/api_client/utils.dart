import 'dart:convert';

import 'package:http/http.dart';

Future<T> parseJsonResponse<T>(
  Future<Response> futureResp,
  T Function(Map<String, dynamic>) parser,
) async {
  final resp = await futureResp;
  return parser(jsonDecode(resp.body));
}

Future<List<T>> parseJsonListResponse<T>(
  Future<Response> futureResp,
  T Function(Map<String, dynamic>) parser,
) async {
  final resp = await futureResp;
  final decoded = jsonDecode(resp.body);
  return decoded is Iterable && decoded.isNotEmpty
      ? List<T>.from(decoded.map((d) => parser(d)))
      : [];
}
