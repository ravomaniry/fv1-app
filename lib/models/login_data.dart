import 'package:fv1/models/serializable.dart';

class LoginData implements Serializable {
  final String username;
  final String password;

  LoginData(this.username, this.password);

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(json['username'], json['password']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;

  @override
  bool operator ==(Object other) {
    return other is LoginData &&
        other.username == username &&
        other.password == password;
  }
}
