class TitleData {
  final String id;
  final String title;
  final String? year;
  final String image;
  final String? type;

  const TitleData({
    required this.id,
    required this.title,
    required this.year,
    required this.image,
    required this.type,
  });

  factory TitleData.fromJson(Map<String, dynamic> json) {
    var rawDescription = json['description'] as String?;
    var regEx = RegExp("[()]");
    var splittedDescription = rawDescription?.split(regEx);
    splittedDescription?.removeWhere((e) => e == '' || e == ' ');

    var year = json['year'] ?? splittedDescription?[0] ?? '';

    String? type;

    if (splittedDescription != null) {
      type = splittedDescription.contains('TV Series')
          ? 'TV Series'
          : splittedDescription.contains('Movie')
              ? 'Movie'
              : splittedDescription.contains('Short')
                  ? 'Short'
                  : null;
    }

    return TitleData(
        id: json['id'],
        title: json['title'],
        year: year,
        image: json['image'],
        type: type);
  }
}
