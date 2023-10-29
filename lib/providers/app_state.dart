import 'package:flutter/material.dart';
import 'package:fv1/models/login_data.dart';
import 'package:fv1/models/register_data.dart';
import 'package:fv1/models/texts.dart';
import 'package:fv1/models/user.dart';
import 'package:fv1/services/api_client/auth_service.dart';
import 'package:fv1/services/storage/storage_service.dart';

class AppState extends ChangeNotifier {
  final AuthService _authService;

  final texts = mgTexts;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  dynamic _error;
  dynamic get error => _error;

  UserModel? _user;

  UserModel? get user => _user;

  AppState(StorageService storageService, this._authService)
      : _user = storageService.getUser();

  void login(LoginData data) {
    _wrapApiCall(() async {
      _user = await _authService.login(data);
    });
  }

  void register(RegisterData data) {
    _wrapApiCall(() async {
      _user = await _authService.register(data);
    });
  }

  void registerAsGuest() {
    _wrapApiCall(() async {
      _user = await _authService.registerGuest();
    });
  }

  void _wrapApiCall(Future<void> Function() call) async {
    _isBusy = false;
    _error = null;
    notifyListeners();
    try {
      await call();
    } catch (e) {
      _error = e;
    }
    _isBusy = false;
    notifyListeners();
  }
}
