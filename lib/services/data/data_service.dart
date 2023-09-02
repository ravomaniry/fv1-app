import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching.dart';

abstract class AbstractDataService {
  Future<List<ProgressModel>> loadProgresses();
  Future<List<TeachingModel>> loadNewTeachings() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      TeachingModel(1, 'Teaching 1', 'Subtitle 1', []),
      TeachingModel(2, 'Teaching 2', 'Subtitle 2', []),
    ];
  }
}
