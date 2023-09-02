import 'package:fv1/models/chapter.dart';

class TeachingModel {
  final int id;
  final String title;
  final String subtitle;
  final List<ChapterModel> chapters;

  TeachingModel(this.id, this.title, this.subtitle, this.chapters);
}
