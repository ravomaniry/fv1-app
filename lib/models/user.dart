import 'package:fv1/models/serializable.dart';

class UserModel implements Serializable {
  final int id;
  final String username;

  UserModel(this.id, this.username);

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(data['id'], data['username']);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
    };
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode;

  @override
  bool operator ==(Object other) {
    return other is UserModel && other.id == id && other.username == username;
  }

  @override
  String toString() {
    return 'UserModel<${toJson()}>';
  }
}
