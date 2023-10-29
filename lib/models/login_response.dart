import 'package:fv1/models/user.dart';
import 'package:fv1/models/user_tokens.dart';

class LoginResponseModel {
  final UserModel user;
  final UserTokens tokens;

  LoginResponseModel(this.user, this.tokens);

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      UserModel.fromJson(json['user']),
      UserTokens.fromJson(json['tokens']),
    );
  }
}
