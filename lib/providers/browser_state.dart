import 'package:flutter/widgets.dart';
import 'package:fv1/mocks/test_teaching.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/models/teaching.dart';

class BrowserState extends ChangeNotifier {
  List<TeachingModel>? _localTeachings;
  List<TeachingModel>? get localTeachings => _localTeachings;

  TeachingModel? _activeTeaching;
  TeachingModel? get activeTeaching => _activeTeaching;

  Map<String, dynamic> _formValue = {};

  BrowserState() {
    _loadInitialData();
  }

  void _loadInitialData() async {
    await Future.delayed(const Duration(seconds: 1));
    _localTeachings = [
      testTeaching,
      TeachingModel(
        2,
        'Teaching 2',
        testTeaching.subtitle,
        testTeaching.chapters,
      ),
    ];
    notifyListeners();
  }

  void loadTeaching(int id) async {
    _activeTeaching = null;
    await Future.delayed(const Duration(seconds: 1));
    _activeTeaching = TeachingModel(
      id,
      'Test teaching $id',
      testTeaching.subtitle,
      testTeaching.chapters,
    );
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

  void submitQuiz() {}

  // The index is from the url so it must be checked
  ChapterModel? getActiveChapter(int index) {
    return _activeTeaching == null || _activeTeaching!.chapters.length <= index
        ? null
        : _activeTeaching!.chapters[index];
  }
}
