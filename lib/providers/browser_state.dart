import 'package:flutter/widgets.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching_summary.dart';
import 'package:fv1/services/data/data_service.dart';

class BrowserState extends ChangeNotifier {
  final AbstractDataService _dataService;

  List<ProgressModel>? _localProgresses;
  List<ProgressModel>? get localProgresses => _localProgresses;

  ProgressModel? _activeProgress;
  ProgressModel? get activeProgress => _activeProgress;

  Map<String, dynamic> _formValue = {};

  List<TeachingSummaryModel>? _teachingsList;
  List<TeachingSummaryModel>? get teachingsList => _teachingsList;

  BrowserState(this._dataService) {
    _loadInitialData();
  }

  void _loadInitialData() async {
    await _dataService.sync();
    _localProgresses = await _dataService.loadProgresses();
    notifyListeners();
  }

  Future<void> startTeaching(int id) async {
    _activeProgress = null;
    // display loader on explorer screen
    _teachingsList = null;
    notifyListeners();
    _localProgresses = _localProgresses ?? [];
    if (_localProgresses!.where((e) => e.teaching.id == id).isEmpty) {
      final newProgress = await _dataService.startTeaching(id);
      _localProgresses!.add(newProgress);
    }
  }

  void loadLocalTeaching(int id) async {
    _activeProgress = null;
    await Future.delayed(const Duration(milliseconds: 250));
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

  Future<void> loadTeachingsList() async {
    _teachingsList = null;
    _teachingsList = await _dataService.loadNewTeachings();
    notifyListeners();
  }
}
