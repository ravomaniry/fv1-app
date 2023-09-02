import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching_summary.dart';

abstract class AbstractDataService {
  Future<void> sync();

  Future<List<ProgressModel>> loadProgresses();

  Future<List<TeachingSummaryModel>> loadNewTeachings() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return [
      TeachingSummaryModel(1, 'Teaching 1', 'Subtitle 1'),
      TeachingSummaryModel(2, 'Teaching 2', 'Subtitle 2'),
    ];
  }

  Future<ProgressModel> startTeaching(int id);

  Future<String> getAudioUrl(int id) async {
    return 'http://fv1.com/$id.wav';
  }
}
