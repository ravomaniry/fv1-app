import 'package:flutter/widgets.dart';
import 'package:fv1/models/teaching.dart';
import 'package:fv1/services/data/data_service.dart';

class ExplorerState extends ChangeNotifier {
  final AbstractDataService _dataService;

  List<TeachingModel>? _teachings;
  List<TeachingModel>? get teachings => _teachings;

  ExplorerState(this._dataService);

  Future<void> loadList() async {
    _teachings = null;
    _teachings = await _dataService.loadNewTeachings();
    notifyListeners();
  }
}
