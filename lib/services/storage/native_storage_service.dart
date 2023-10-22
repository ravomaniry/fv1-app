import 'dart:convert';

import 'package:fv1/models/user_tokens.dart';
import 'package:fv1/services/storage/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NativeStorageService extends StorageService {
  final _refreshTokenKey = 'refresh_token';
  late SharedPreferences _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<UserTokens?> getTokens() async {
    final raw = _prefs.getString(_refreshTokenKey);
    if (raw != null) {
      return UserTokens.fromJson(jsonDecode(raw));
    }
    return null;
  }

  @override
  void saveTokens(UserTokens tokens) {
    _prefs.setString(_refreshTokenKey, tokens.toJson());
  }
}
