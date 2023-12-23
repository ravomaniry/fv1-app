import 'dart:convert';

import 'package:fv1/models/user.dart';
import 'package:fv1/models/user_tokens.dart';
import 'package:fv1/services/storage/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NativeStorageService extends StorageService {
  final _refreshTokenKey = 'refresh_token';
  final _userKey = 'user';
  final _isHelpVisitedKey = 'isHelpVisitedKey';
  late SharedPreferences _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<UserTokens?> getTokens() async {
    return _get(_refreshTokenKey, (d) => UserTokens.fromJson(d));
  }

  @override
  void saveTokens(UserTokens tokens) {
    _prefs.setString(_refreshTokenKey, jsonEncode(tokens));
  }

  @override
  UserModel? getUser() {
    return _get(_userKey, (map) => UserModel.fromJson(map));
  }

  @override
  void saveUser(UserModel user) {
    _prefs.setString(_userKey, jsonEncode(user));
  }

  T? _get<T>(String key, T Function(Map<String, dynamic> map) create) {
    final raw = _prefs.getString(key);
    return raw == null ? null : create(jsonDecode(raw));
  }

  @override
  void deleteToken() {
    _prefs.remove(_refreshTokenKey);
  }

  @override
  void deleteUser() {
    _prefs.remove(_userKey);
  }

  @override
  bool isHelpViewed() {
    return _prefs.getBool(_isHelpVisitedKey) ?? false;
  }

  @override
  void setIsHelpViewed() {
    _prefs.setBool(_isHelpVisitedKey, true);
  }
}
