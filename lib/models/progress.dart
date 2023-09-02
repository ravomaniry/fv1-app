import 'package:fv1/models/teaching.dart';

class ChapterScore {
  final int correctAnswersPercentage;

  ChapterScore({required this.correctAnswersPercentage});
}

class ProgressModel {
  final TeachingModel teaching;
  final List<ChapterScore> scores;
  double completionPercentage;

  bool isChapterDone(int index) {
    return scores.length > index &&
        scores[index].correctAnswersPercentage >= 0.75;
  }

  ProgressModel({
    required this.teaching,
    required this.scores,
    this.completionPercentage = 0,
  });
}
