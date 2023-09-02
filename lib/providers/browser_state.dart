import 'package:flutter/widgets.dart';
import 'package:fv1/mocks/test_teaching.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching.dart';

class BrowserState extends ChangeNotifier {
  List<ProgressModel>? _localProgresses;
  List<ProgressModel>? get localProgresses => _localProgresses;

  ProgressModel? _activeProgress;
  ProgressModel? get activeProgress => _activeProgress;

  Map<String, dynamic> _formValue = {};

  BrowserState() {
    _loadInitialData();
  }

  void _loadInitialData() async {
    await Future.delayed(const Duration(milliseconds: 400));
    _localProgresses = [
      ProgressModel(teaching: testTeaching, scores: []),
      ProgressModel(
        teaching: TeachingModel(
          2,
          'Teaching 2',
          testTeaching.subtitle,
          testTeaching.chapters,
        ),
        scores: [
          ChapterScore(correctAnswersPercentage: 2),
        ],
        completionPercentage: 0.5,
      ),
    ];
    notifyListeners();
  }

  void loadTeaching(int id) async {
    _activeProgress = null;
    await Future.delayed(const Duration(milliseconds: 400));
    _activeProgress = _localProgresses!.where((t) => t.teaching.id == id).first;
    notifyListeners();
  }

  void resetFormValue() {
    _formValue = {};
  }

  void onFormValueChanged(String key, dynamic value) {
    _formValue[key] = value;
    notifyListeners();
  }

  dynamic getFormValue(String key) {
    return _formValue[key];
  }

  void submitQuiz(Map<String, dynamic> value) {
    _formValue = {};
  }

  // The index is from the url so it must be checked
  ChapterModel? getActiveChapter(int index) {
    return _activeProgress == null ||
            _activeProgress!.teaching.chapters.length <= index
        ? null
        : _activeProgress!.teaching.chapters[index];
  }
}
