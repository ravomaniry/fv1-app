import 'package:flutter/widgets.dart';
import 'package:fv1/mocks/test_teaching.dart';
import 'package:fv1/models/teaching.dart';

class BrowserState extends ChangeNotifier {
  List<TeachingModel>? _localTeachings;
  List<TeachingModel>? get localTeachings => _localTeachings;

  TeachingModel? _activeTeaching;
  TeachingModel? get activeTeaching => _activeTeaching;

  BrowserState() {
    _loadInitialData();
  }

  _loadInitialData() async {
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

  loadTeaching(int id) async {
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
}
