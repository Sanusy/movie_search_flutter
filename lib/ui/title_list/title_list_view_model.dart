import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:movie_search/redux/state.dart';
import 'package:movie_search/redux/title_details/title_details_actions.dart';
import 'package:redux/redux.dart';

abstract class TitleListViewModel {}

class TitleListLoading extends TitleListViewModel {}

class TitleListLoaded extends TitleListViewModel {
  final List<TitleItem> titleList;

  TitleListLoaded._(this.titleList);

  factory TitleListLoaded.create(Store<AppState> store) {
    var titleListState = store.state.titleListState;
    return TitleListLoaded._(List.unmodifiable(titleListState.titleList
        .map((e) => TitleItem(e.id, e.title, e.year, e.image, () {
              store.dispatch(NavigateToAction.push('/movieDetails'));
              store.dispatch(OpenTitleDetailsAction(e.id));
            }))));
  }
}

class TitleItem {
  final String id;
  final String title;
  final String year;
  final String image;
  final Function titleClickedCommand;

  const TitleItem(
    this.id,
    this.title,
    this.year,
    this.image,
    this.titleClickedCommand,
  );
}
