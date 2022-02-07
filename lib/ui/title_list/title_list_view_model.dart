import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:movie_search/redux/state.dart';
import 'package:movie_search/redux/title_details/title_details_actions.dart';
import 'package:movie_search/redux/title_list/title_list_actions.dart';
import 'package:movie_search/redux/title_list/title_list_state.dart';
import 'package:redux/redux.dart';

abstract class TitleListViewModel {
  TitleListAppBar get appBar;

  TitleListFiltersViewModel get filters;
}

class TitleListLoading extends TitleListViewModel {
  @override
  final TitleListFiltersViewModel filters;

  @override
  final TitleListAppBar appBar;

  TitleListLoading._(
    this.filters,
    this.appBar,
  );

  factory TitleListLoading.create(Store<AppState> store) {
    return TitleListLoading._(
        TitleListFiltersViewModel.create(store), TitleListAppBar.create(store));
  }
}

class TitleListLoaded extends TitleListViewModel {
  final List<TitleItem> titleList;

  @override
  final TitleListAppBar appBar;

  @override
  final TitleListFiltersViewModel filters;

  TitleListLoaded._(
    this.titleList,
    this.appBar,
    this.filters,
  );

  factory TitleListLoaded.create(Store<AppState> store) {
    var titleListState = store.state.titleListState;

    return TitleListLoaded._(
      List.unmodifiable(titleListState.titleList
          .map((e) => TitleItem(e.id, e.title, e.year, e.type, e.image, () {
                store.dispatch(NavigateToAction.push('/movieDetails'));
                store.dispatch(OpenTitleDetailsAction(e.id));
              }))),
      TitleListAppBar.create(store),
      TitleListFiltersViewModel.create(store),
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

class TitleListAppBar {
  final bool searchActive;
  final String searchQuery;
  final void Function(String) updateQuery;
  final void Function() performQuery;
  final void Function() clearQuery;
  final void Function() openSearch;
  final void Function() closeSearch;

  TitleListAppBar._(
    this.searchActive,
    this.searchQuery,
    this.updateQuery,
    this.performQuery,
    this.clearQuery,
    this.openSearch,
    this.closeSearch,
  );

  factory TitleListAppBar.create(Store<AppState> store) {
    var titleListState = store.state.titleListState;
    return TitleListAppBar._(
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

class TitleListFiltersViewModel {
  final List<Filter> filters;

  TitleListFiltersViewModel._(this.filters);

  factory TitleListFiltersViewModel.create(Store<AppState> store) {
    var selectedFilter = store.state.titleListState.activeFilter;
    return TitleListFiltersViewModel._(List.unmodifiable([
      Filter(
          name: 'Top 250 Movies',
          isSelected: selectedFilter is Top250Movies,
          onClick: () => store.dispatch(SelectFilterAction(Top250Movies()))),
      Filter(
          name: 'Top 250 Series',
          isSelected: selectedFilter is Top250Series,
          onClick: () => store.dispatch(SelectFilterAction(Top250Series()))),
      Filter(
          name: 'Most Popular Movies',
          isSelected: selectedFilter is MostPopularMovies,
          onClick: () => store.dispatch(SelectFilterAction(MostPopularMovies()))),
      Filter(
          name: 'Most Popular Series',
          isSelected: selectedFilter is MostPopularTVs,
          onClick: () => store.dispatch(SelectFilterAction(MostPopularTVs()))),
      Filter(
          name: 'Coming Soon',
          isSelected: selectedFilter is ComingSoon,
          onClick: () => store.dispatch(SelectFilterAction(ComingSoon()))),
      Filter(
          name: 'In Theaters',
          isSelected: selectedFilter is InTheaters,
          onClick: () => store.dispatch(SelectFilterAction(InTheaters()))),
    ]));
  }
}

class Filter {
  final String name;
  final bool isSelected;
  final void Function() onClick;

  Filter({
    required this.name,
    required this.isSelected,
    required this.onClick,
  });
}