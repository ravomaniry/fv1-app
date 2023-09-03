import 'package:fv1/models/chapter_score.dart';
import 'package:fv1/models/progress.dart';
import 'package:fv1/models/quiz_question.dart';
import 'package:fv1/models/wrong_answer.dart';

List<WrongAnswer> calculateWrongAnswers(
  List<QuizQuestionModel> questions,
  Map<String, dynamic> value,
) {
  final wrongAnswers = <WrongAnswer>[];
  for (final q in questions) {
    final given = value[q.key];
    if (given != q.response) {
      wrongAnswers.add(WrongAnswer(q.question, given, q.response));
    }
  }
  return wrongAnswers;
}

ProgressModel updateProgress(
  ProgressModel progress,
  int chapterIndex,
  List<WrongAnswer> wrongAnswers,
) {
  final questionsCount =
      progress.teaching.chapters[chapterIndex].questions.length;
  final score = ChapterScore(
    correctAnswersPercentage: _roundedPercentage(
        questionsCount - wrongAnswers.length, questionsCount),
  );
  final nextScores = progress.scores.toList(growable: true);
  while (nextScores.length <= chapterIndex) {
    nextScores.add(ChapterScore.zero());
  }
  nextScores[chapterIndex] = score;
  return ProgressModel(teaching: progress.teaching, scores: nextScores);
}

double _roundedPercentage(int n, int total) {
  return (100 * n / total).round() / 100;
}
