import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';

int _readExpirationDate(String accessToken) {
  return JwtDecoder.decode(accessToken)['exp'];
}

class UserTokens {
  String accessToken;
  final String refreshToken;
  int expirationOn;

  UserTokens(this.refreshToken, this.accessToken)
      : expirationOn = _readExpirationDate(accessToken);

  factory UserTokens.fromJson(Map<String, dynamic> json) {
    return UserTokens(json['refreshToken'], json['accessToken']);
  }

  void updateAccessToken(String token) {
    accessToken = token;
    expirationOn = _readExpirationDate(accessToken);
  }

  toJson() {
    return jsonEncode({
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    });
  }
}
