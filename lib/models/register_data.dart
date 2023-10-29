import 'package:fv1/models/login_data.dart';

class RegisterData extends LoginData {
  RegisterData(super.username, super.password);

  factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(json['username'], json['password']);
  }
}
