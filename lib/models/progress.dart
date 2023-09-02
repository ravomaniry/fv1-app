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

  int getNextChapterIndex() {
    for (int i = 0; i < scores.length; i++) {
      if (!isChapterDone(i)) {
        return i;
      }
    }
    return scores.length < teaching.chapters.length ? scores.length : 0;
  }

  ProgressModel({
    required this.teaching,
    required this.scores,
    this.completionPercentage = 0,
  });
}
