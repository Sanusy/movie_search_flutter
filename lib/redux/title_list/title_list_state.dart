import 'package:movie_search/data/title_list.dart';

class TitleListState {
  final bool isLoading;
  final List<TitleData> titleList;
  final bool searchActive;
  final String searchQuery;

  TitleListState({
    required this.isLoading,
    required this.titleList,
    required this.searchActive,
    required this.searchQuery,
  });

  TitleListState.initial()
      : isLoading = false,
        titleList = List.unmodifiable([]),
        searchActive = false,
        searchQuery = '';

  TitleListState copy(
      {bool? isLoading,
      List<TitleData>? titleList,
      bool? searchActive,
      String? searchQuery}) {
    return TitleListState(
      titleList: titleList ?? this.titleList,
      isLoading: isLoading ?? this.isLoading,
      searchActive: searchActive ?? this.searchActive,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}
