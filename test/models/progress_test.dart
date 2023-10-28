import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:fv1/models/chapter.dart';
import 'package:fv1/models/chapter_score.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/quiz_question.dart';
import 'package:fv1/models/section.dart';
import 'package:fv1/models/teaching.dart';

void main() {
  test('ProgressModel compare', () {
    final chapter = ChapterModel(
      'CT1',
      [SectionModel('S1', 'SC1', '1.audio')],
      [
        QuizQuestionModel('1', 'Q1', ['1', '2'], 'R1')
      ],
    );
    final chapter1 = ChapterModel(
      'CT1',
      [SectionModel('S1', 'SC1', '1.audio')],
      [
        QuizQuestionModel('1', 'Q1', ['1', '2'], 'R1')
      ],
    );
    final teaching = TeachingModel(1, 'T1', 'ST1', [chapter]);
    final teaching1 = TeachingModel(1, 'T1', 'ST1', [chapter1]);
    final p1 = ProgressModel(
      id: 10,
      teaching: teaching,
      clientTimestamp: 1000,
      scores: [ChapterScore(correctAnswersPercentage: 0.5)],
    );
    final p2 = ProgressModel(
      id: 10,
      teaching: teaching1,
      clientTimestamp: 1000,
      scores: [ChapterScore(correctAnswersPercentage: 0.5)],
    );
    expect(p1.teaching, p2.teaching);
    expect(p1.scores, p2.scores);
    expect(p1, p2);
    expect(jsonEncode(p2), jsonEncode(p1));
  });
}
