import 'package:movie_search/data/title_list.dart';

class TitleListState {
  final bool isLoading;
  final List<TitleData> titleList;

  TitleListState({
    required this.isLoading,
    required this.titleList,
  });

  TitleListState.initial()
      : isLoading = false,
        titleList = List.unmodifiable([]);

  TitleListState copy({bool? isLoading, List<TitleData>? titleList}) {
    return TitleListState(
      titleList: titleList ?? this.titleList,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
