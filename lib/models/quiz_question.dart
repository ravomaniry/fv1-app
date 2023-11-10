import 'package:flutter/foundation.dart';
import 'package:fv1/models/serializable.dart';

class QuizQuestionModel implements Serializable {
  final String key;
  final String question;
  final List<String> options;
  final int responseIndex;

  QuizQuestionModel(this.key, this.question, this.options, this.responseIndex);

  factory QuizQuestionModel.fromJson(Map<dynamic, dynamic> json) {
    return QuizQuestionModel(
      json['key'],
      json['question'],
      List<String>.from(json['options']),
      json['responseIndex'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'question': question,
      'options': options,
      'responseIndex': responseIndex,
    };
  }

  @override
  int get hashCode =>
      key.hashCode ^
      question.hashCode ^
      options.hashCode ^
      responseIndex.hashCode;

  @override
  bool operator ==(Object other) =>
      other is QuizQuestionModel &&
      other.key == key &&
      other.question == question &&
      other.responseIndex == responseIndex &&
      listEquals(other.options, options);

  @override
  String toString() => 'QuizQuestionModel${toJson().toString()}';
}
