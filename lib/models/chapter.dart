import 'package:fv1/models/quiz_question.dart';
import 'package:fv1/models/section.dart';

class ChapterModel {
  final String title;
  final List<SectionModel> sections;
  final List<QuizQuestionModel> questions;

  ChapterModel(this.title, this.sections, this.questions);
}
