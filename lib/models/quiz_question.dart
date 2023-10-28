import 'package:flutter/foundation.dart';
import 'package:fv1/models/serializable.dart';

class QuizQuestionModel implements Serializable {
  final String key;
  final String question;
  final List<String> options;
  final String response;

  QuizQuestionModel(this.key, this.question, this.options, this.response);

  factory QuizQuestionModel.fromJson(Map<dynamic, dynamic> json) {
    return QuizQuestionModel(
      json['key'],
      json['question'],
      List<String>.from(json['options']),
      json['response'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'question': question,
      'options': options,
      'response': response,
    };
  }

  @override
  int get hashCode =>
      key.hashCode ^ question.hashCode ^ options.hashCode ^ response.hashCode;

  @override
  bool operator ==(Object other) =>
      other is QuizQuestionModel &&
      other.key == key &&
      other.question == question &&
      other.response == response &&
      listEquals(other.options, options);

  @override
  String toString() => 'QuizQuestionModel${toJson().toString()}';
}
