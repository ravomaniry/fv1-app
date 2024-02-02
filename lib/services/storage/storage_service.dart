import 'package:fv1/models/user.dart';
import 'package:fv1/models/user_tokens.dart';

abstract class StorageService {
  Future<void> init();

  Future<UserTokens?> getTokens();

  void saveTokens(UserTokens tokens);

  UserModel? getUser();

  void saveUser(UserModel user);

  void deleteToken();

  void deleteUser();
}
