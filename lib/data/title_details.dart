class TitleDetails {
  final String id;
  final String title;
  final String year;
  final String image;
  final String plot;
  final String duration;
  final String directors;
  final List<Actor> actors;

  const TitleDetails({
    required this.id,
    required this.title,
    required this.year,
    required this.image,
    required this.plot,
    required this.duration,
    required this.directors,
    required this.actors,
  });

  factory TitleDetails.fromJson(Map<String, dynamic> json) {
    var list = json['actorList'] as List;
    List<Actor> actors = list.map((i) => Actor.fromJson(i)).toList();

    return TitleDetails(
        id: json['id'],
        title: json['title'],
        year: json['year'],
        image: json['image'],
        plot: json['plot'],
        duration: json['runtimeStr'],
        directors: json['directors'],
        actors: actors);
  }
}

class Actor {
  final String id;
  final String image;
  final String name;
  final String asCharacter;

  const Actor({
    required this.id,
    required this.image,
    required this.name,
    required this.asCharacter,
  });

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        id: json['id'],
        image: json['image'],
        name: json['name'],
        asCharacter: json['asCharacter'],
      );
}
