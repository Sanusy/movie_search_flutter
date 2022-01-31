import 'package:movie_search/redux/state.dart';
import 'package:redux/redux.dart';

abstract class TitleDetailsViewModel {}

class TitleDetailsLoading extends TitleDetailsViewModel {}

class TitleDetailsLoaded extends TitleDetailsViewModel {
  final String id;
  final String title;
  final String year;
  final String image;
  final String plot;
  final String duration;
  final String directors;
  final List<ActorItem> actors;

  TitleDetailsLoaded._(this.id, this.title, this.year, this.image, this.plot,
      this.duration, this.directors, this.actors);

  factory TitleDetailsLoaded.create(Store<AppState> store) {
    var titleDetails = store.state.titleDetailsState.titleDetails;
    if (titleDetails != null) {
      return TitleDetailsLoaded._(
        titleDetails.id,
        titleDetails.title,
        titleDetails.year,
        titleDetails.image,
        titleDetails.plot,
        titleDetails.duration,
        titleDetails.directors,
        List.unmodifiable(titleDetails.actors
            .map((e) => ActorItem(e.id, e.image, e.name, e.asCharacter))),
      );
    } else {
      throw NullThrownError();
    }
  }
}

class ActorItem {
  final String id;
  final String image;
  final String name;
  final String asCharacter;

  ActorItem(this.id, this.image, this.name, this.asCharacter);
}
