import 'package:flutter/foundation.dart';
import 'package:fv1/models/quiz_question.dart';
import 'package:fv1/models/section.dart';

class ChapterModel {
  final String title;
  final List<SectionModel> sections;
  final List<QuizQuestionModel> questions;

  ChapterModel(this.title, this.sections, this.questions);

  factory ChapterModel.fromJson(Map<dynamic, dynamic> json) {
    final List<Map<dynamic, dynamic>> questions = json['questions'];
    final List<Map<dynamic, dynamic>> sections = json['sections'];
    return ChapterModel(
      json['title'],
      sections.map((e) => SectionModel.fromJson(e)).toList(growable: false),
      questions
          .map((e) => QuizQuestionModel.fromJson(e))
          .toList(growable: false),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'sections': sections.map((e) => e.toJson()).toList(),
      'questions': questions.map((e) => e.toJson()).toList(),
    };
  }

  @override
  int get hashCode => title.hashCode ^ sections.hashCode ^ questions.hashCode;

  @override
  bool operator ==(Object other) =>
      other is ChapterModel &&
      title == other.title &&
      listEquals(sections, other.sections) &&
      listEquals(questions, other.questions);

  @override
  String toString() => 'ChapterModel${toJson().toString()}';
}
