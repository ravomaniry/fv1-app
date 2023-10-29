import 'dart:convert';

String createAccessToken(DateTime expireOn) {
  return 'header.${base64.encode(utf8.encode(jsonEncode({
        'exp': expireOn.millisecondsSinceEpoch ~/ 1000
      })))}.footer';
}
