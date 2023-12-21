import 'package:flutter/material.dart';
import 'package:fv1/models/login_data.dart';
import 'package:fv1/models/register_data.dart';
import 'package:fv1/models/texts.dart';
import 'package:fv1/models/user.dart';
import 'package:fv1/services/api_client/auth_service.dart';
import 'package:fv1/services/storage/storage_service.dart';

class AppState extends ChangeNotifier {
  final AuthService _authService;
  final StorageService _storageService;
  final texts = mgTexts;

  bool get isBusy => _isBusy;
  bool _isBusy = false;

  dynamic get error => _error;
  dynamic _error;

  UserModel? get user => _user;
  UserModel? _user;

  bool get isHelpViewed => _isHelpViewed;
  bool _isHelpViewed;

  AppState(this._storageService, this._authService)
      : _user = _storageService.getUser(),
        _isHelpViewed = _storageService.isHelpViewed();

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

  void logOut() async {
    _authService.logOut();
    _user = null;
    // Avoid UI glitch
    await Future.delayed(const Duration(milliseconds: 400));
    notifyListeners();
  }

  void _wrapApiCall(Future<void> Function() call) async {
    _isBusy = true;
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

  void setIsHelpViewed() {
    _isHelpViewed = true;
    _storageService.setIsHelpViewed();
  }
}
