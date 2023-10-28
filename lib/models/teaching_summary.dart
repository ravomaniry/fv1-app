class TeachingSummaryModel {
  final int id;
  final String title;
  final String subtitle;

  TeachingSummaryModel(this.id, this.title, this.subtitle);

  factory TeachingSummaryModel.fromJson(Map<String, dynamic> json) {
    return TeachingSummaryModel(json['id'], json['title'], json['subtitle']);
  }
}
