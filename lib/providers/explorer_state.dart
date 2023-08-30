import 'package:flutter/widgets.dart';
import 'package:fv1/models/teaching.dart';

class ExplorerState extends ChangeNotifier {
  List<TeachingModel>? _teachings;
  List<TeachingModel>? get teachings => _teachings;

  Future<void> loadList() async {
    _teachings = null;
    await Future.delayed(const Duration(seconds: 1));
    _teachings = [
      TeachingModel('Teaching 1', 'Subtitle 1', []),
      TeachingModel('Teaching 2', 'Subtitle 2', []),
    ];
    notifyListeners();
  }
}
