import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:movie_search/redux/state.dart';
import 'package:movie_search/redux/title_details/title_details_actions.dart';
import 'package:movie_search/redux/title_list/title_list_actions.dart';
import 'package:redux/redux.dart';

abstract class TitleListViewModel {
  bool get searchActive;

  String get searchQuery;

  void Function(String) get updateQuery;

  void Function() get performQuery;

  void Function() get clearQuery;

  void Function() get openSearch;

  void Function() get closeSearch;
}

class TitleListLoading extends TitleListViewModel {
  @override
  final bool searchActive;
  @override
  final String searchQuery;
  @override
  final void Function(String) updateQuery;
  @override
  final void Function() performQuery;
  @override
  final void Function() clearQuery;
  @override
  final void Function() openSearch;
  @override
  final void Function() closeSearch;

  TitleListLoading._(
    this.searchActive,
    this.searchQuery,
    this.updateQuery,
    this.performQuery,
    this.clearQuery,
    this.openSearch,
    this.closeSearch,
  );

  factory TitleListLoading.create(Store<AppState> store) {
    var titleListState = store.state.titleListState;
    return TitleListLoading._(
      titleListState.searchActive,
      titleListState.searchQuery,
      (query) => store.dispatch(UpdateQueryAction(query)),
      () => store.dispatch(PerformQueryAction()),
      () => store.dispatch(ClearSearchAction()),
      () => store.dispatch(OpenSearchAction()),
      () => store.dispatch(CloseSearchAction()),
    );
  }
}

class TitleListLoaded extends TitleListViewModel {
  final List<TitleItem> titleList;
  @override
  final bool searchActive;
  @override
  final String searchQuery;
  @override
  final void Function(String) updateQuery;
  @override
  final void Function() performQuery;
  @override
  final void Function() clearQuery;
  @override
  final void Function() openSearch;
  @override
  final void Function() closeSearch;

  TitleListLoaded._(
    this.titleList,
    this.searchActive,
    this.searchQuery,
    this.updateQuery,
    this.performQuery,
    this.clearQuery,
    this.openSearch,
    this.closeSearch,
  );

  factory TitleListLoaded.create(Store<AppState> store) {
    var titleListState = store.state.titleListState;

    return TitleListLoaded._(
      List.unmodifiable(titleListState.titleList.map(
          (e) => TitleItem(e.id, e.title, e.year, e.type, e.image, () {
                store.dispatch(NavigateToAction.push('/movieDetails'));
                store.dispatch(OpenTitleDetailsAction(e.id));
              }))),
      titleListState.searchActive,
      titleListState.searchQuery,
      (query) => store.dispatch(UpdateQueryAction(query)),
      () => store.dispatch(PerformQueryAction()),
      () => store.dispatch(ClearSearchAction()),
      () => store.dispatch(OpenSearchAction()),
      () => store.dispatch(CloseSearchAction()),
    );
  }
}

class TitleItem {
  final String id;
  final String title;
  final String? year;
  final String? type;
  final String image;
  final Function titleClickedCommand;

  const TitleItem(
    this.id,
    this.title,
    this.year,
    this.type,
    this.image,
    this.titleClickedCommand,
  );
}
