import 'package:movie_search/data/title_list.dart';

class TitleListState {
  final bool isLoading;
  final List<TitleData> titleList;
  final bool searchActive;
  final String searchQuery;
  final TitleListFilter activeFilter;

  TitleListState({
    required this.isLoading,
    required this.titleList,
    required this.searchActive,
    required this.searchQuery,
    required this.activeFilter,
  });

  TitleListState.initial()
      : isLoading = false,
        titleList = List.unmodifiable([]),
        searchActive = false,
        searchQuery = '',
        activeFilter = Top250Movies();

  TitleListState copy({
    bool? isLoading,
    List<TitleData>? titleList,
    bool? searchActive,
    String? searchQuery,
    TitleListFilter? activeFilter,
  }) {
    return TitleListState(
      titleList: titleList ?? this.titleList,
      isLoading: isLoading ?? this.isLoading,
      searchActive: searchActive ?? this.searchActive,
      searchQuery: searchQuery ?? this.searchQuery,
      activeFilter: activeFilter ?? this.activeFilter,
    );
  }
}

abstract class TitleListFilter {
  String get searchFilter;
}

class None extends TitleListFilter {
  @override
  String get searchFilter => '';
}

class Top250Movies extends TitleListFilter {
  @override
  String get searchFilter => 'Top250Movies';
}

class Top250Series extends TitleListFilter {
  @override
  String get searchFilter => 'Top250TVs';
}

class MostPopularMovies extends TitleListFilter {
  @override
  String get searchFilter => 'MostPopularMovies';
}

class MostPopularTVs extends TitleListFilter {
  @override
  String get searchFilter => 'MostPopularTVs';
}

class ComingSoon extends TitleListFilter {
  @override
  String get searchFilter => 'ComingSoon';
}

class InTheaters extends TitleListFilter {
  @override
  String get searchFilter => 'InTheaters';
}
