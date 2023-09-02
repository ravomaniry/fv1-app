import 'package:fv1/mocks/test_teaching.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching.dart';
import 'package:fv1/services/data/data_service.dart';

class NativeDataService extends AbstractDataService {
  @override
  Future<List<ProgressModel>> loadProgresses() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
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
  }
}
