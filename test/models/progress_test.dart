import 'package:flutter_test/flutter_test.dart';
import 'package:fv1/models/chapter_score.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/teaching.dart';

void main() {
  test('ProgressModel compare', () {
    final teaching = TeachingModel(1, 'T1', 'ST1', []);
    final p1 = ProgressModel(
      teaching: teaching,
      scores: [ChapterScore(correctAnswersPercentage: 0.5)],
    );
    final p2 = ProgressModel(
      teaching: teaching,
      scores: [ChapterScore(correctAnswersPercentage: 0.5)],
    );
    expect(p1.teaching, p2.teaching);
    expect(p1.scores, p2.scores);
    expect(p1, p2);
  });
}
