import 'package:fv1/models/serializable.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

DateTime _readExpirationDate(String accessToken) {
  return JwtDecoder.getExpirationDate(accessToken);
}

class UserTokens implements Serializable {
  String accessToken;
  final String refreshToken;
  DateTime _expirationDate;

  UserTokens(this.refreshToken, this.accessToken)
      : _expirationDate = _readExpirationDate(accessToken);

  factory UserTokens.fromJson(Map<String, dynamic> json) {
    return UserTokens(json['refreshToken'], json['accessToken']);
  }

  void updateAccessToken(String token) {
    accessToken = token;
    _expirationDate = _readExpirationDate(accessToken);
  }

  bool get isAccessTokenExpired => DateTime.now().isAfter(_expirationDate);

  @override
  toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }

  @override
  int get hashCode => accessToken.hashCode ^ refreshToken.hashCode;

  @override
  bool operator ==(Object other) {
    return other is UserTokens &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken;
  }
}
