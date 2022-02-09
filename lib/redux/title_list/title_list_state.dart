import 'package:movie_search/data/title_list.dart';

class TitleListState {
  final bool isLoading;
  final List<TitleData> titleList;
  final bool searchActive;
  final String searchQuery;
  final TitleListCategory activeCategory;

  TitleListState({
    required this.isLoading,
    required this.titleList,
    required this.searchActive,
    required this.searchQuery,
    required this.activeCategory,
  });

  TitleListState.initial()
      : isLoading = false,
        titleList = List.unmodifiable([]),
        searchActive = false,
        searchQuery = '',
        activeCategory = None();

  TitleListState copy({
    bool? isLoading,
    List<TitleData>? titleList,
    bool? searchActive,
    String? searchQuery,
    TitleListCategory? activeFilter,
  }) {
    return TitleListState(
      titleList: titleList ?? this.titleList,
      isLoading: isLoading ?? this.isLoading,
      searchActive: searchActive ?? this.searchActive,
      searchQuery: searchQuery ?? this.searchQuery,
      activeCategory: activeFilter ?? this.activeCategory,
    );
  }
}

abstract class TitleListCategory {
  String get searchFilter;
}

class None extends TitleListCategory {
  @override
  String get searchFilter => '';
}

class Top250Movies extends TitleListCategory {
  @override
  String get searchFilter => 'Top250Movies';
}

class Top250Series extends TitleListCategory {
  @override
  String get searchFilter => 'Top250TVs';
}

class MostPopularMovies extends TitleListCategory {
  @override
  String get searchFilter => 'MostPopularMovies';
}

class MostPopularTVs extends TitleListCategory {
  @override
  String get searchFilter => 'MostPopularTVs';
}

class ComingSoon extends TitleListCategory {
  @override
  String get searchFilter => 'ComingSoon';
}

class InTheaters extends TitleListCategory {
  @override
  String get searchFilter => 'InTheaters';
}
