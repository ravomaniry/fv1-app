import 'package:flutter/foundation.dart';
import 'package:fv1/models/chapter_score.dart';
import 'package:fv1/models/teaching.dart';

class ProgressModel {
  final TeachingModel teaching;
  final List<ChapterScore> scores;
  double _completionPercentage = 0;
  double get completionPercentage => _completionPercentage;

  ProgressModel({
    required this.teaching,
    required this.scores,
  }) {
    _calculateCompletionPercentage();
  }

  factory ProgressModel.fromJson(Map<dynamic, dynamic> json) {
    final List<Map<dynamic, dynamic>> scores = json['scores'];
    return ProgressModel(
      teaching: TeachingModel.fromJson(json['teaching']),
      scores:
          scores.map((e) => ChapterScore.fromJson(e)).toList(growable: false),
    );
  }

  bool isChapterDone(int index) {
    return scores.length > index &&
        scores[index].correctAnswersPercentage >= 0.75;
  }

  void _calculateCompletionPercentage() {
    int completed = 0;
    for (int i = 0; i < teaching.chapters.length; i++) {
      if (isChapterDone(i)) {
        completed++;
      }
    }
    _completionPercentage = completed / teaching.chapters.length;
  }

  int getNextChapterIndex() {
    for (int i = 0; i < scores.length; i++) {
      if (!isChapterDone(i)) {
        return i;
      }
    }
    return scores.length < teaching.chapters.length ? scores.length : 0;
  }

  Map<dynamic, dynamic> toJson() {
    return {
      'teaching': teaching.toJson(),
      'scores': scores.map((e) => e.toJson()),
    };
  }

  @override
  int get hashCode => teaching.hashCode ^ scores.hashCode;

  @override
  bool operator ==(Object other) =>
      other is ProgressModel &&
      teaching == other.teaching &&
      listEquals(scores, other.scores);

  @override
  String toString() => 'ProgressModel${toJson().toString()}';
}
