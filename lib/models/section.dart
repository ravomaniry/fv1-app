import 'package:flutter/foundation.dart';

class SectionModel {
  final String subtitle;
  final String content;
  final String audioId;

  SectionModel(this.subtitle, this.content, this.audioId);

  factory SectionModel.fromJson(Map<dynamic, dynamic> json) {
    return SectionModel(
      json['subtitle'],
      json['content'],
      json['audioId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'subtitle': subtitle,
      'content': content,
      'audioId': audioId,
    };
  }

  @override
  int get hashCode => subtitle.hashCode ^ content.hashCode ^ audioId.hashCode;

  @override
  bool operator ==(Object other) =>
      other is SectionModel && mapEquals(toJson(), other.toJson());

  @override
  String toString() => 'SectionModel${toJson().toString()}';
}
