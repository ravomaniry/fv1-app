import 'package:flutter/foundation.dart';
import 'package:fv1/models/chapter.dart';

class TeachingModel {
  final int id;
  final String title;
  final String subtitle;
  final List<ChapterModel> chapters;

  TeachingModel(this.id, this.title, this.subtitle, this.chapters);

  factory TeachingModel.fromJson(Map<String, dynamic> json) {
    return TeachingModel(
      json['id'],
      json['title'],
      json['subtitle'],
      List<ChapterModel>.from(
        json['chapters'].map((e) => ChapterModel.fromJson(e)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'chapters': chapters.map((e) => e.toJson()).toList(growable: false),
    };
  }

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ subtitle.hashCode ^ chapters.hashCode;

  @override
  bool operator ==(Object other) =>
      other is TeachingModel &&
      id == other.id &&
      title == other.title &&
      subtitle == other.subtitle &&
      listEquals(chapters, other.chapters);
}
