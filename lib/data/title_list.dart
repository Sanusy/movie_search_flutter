class TitleData {
  final String id;
  final String title;
  final String year;
  final String image;

  const TitleData({
    required this.id,
    required this.title,
    required this.year,
    required this.image,
  });

  factory TitleData.fromJson(Map<String, dynamic> json) {
    return TitleData(
        id: json['id'],
        title: json['title'],
        year: json['year'],
        image: json['image']);
  }
}
