import 'package:flutter/material.dart';
import 'package:fv1/mocks/test_teaching.dart';
import 'package:fv1/models/teaching.dart';

class AppState extends ChangeNotifier {
  List<TeachingModel>? _localTeachings;
  List<TeachingModel>? get localTeachings => _localTeachings;

  AppState() {
    _loadInitialData();
  }

  _loadInitialData() async {
    await Future.delayed(const Duration(seconds: 1));
    _localTeachings = [testTeaching];
    notifyListeners();
  }
}
