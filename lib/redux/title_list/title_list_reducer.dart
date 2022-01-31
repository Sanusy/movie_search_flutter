import 'package:movie_search/redux/title_list/title_list_actions.dart';
import 'package:movie_search/redux/title_list/title_list_state.dart';
import 'package:redux/redux.dart';

Reducer<TitleListState> titleListReducer = combineReducers<TitleListState>([
  TypedReducer(_loadTitleList),
  TypedReducer(_titleListLoaded),
]);

TitleListState _loadTitleList(TitleListState state, LoadTitleListAction action) =>
    state.copy(
      isLoading: true,
      titleList: List.unmodifiable([]),
    );

TitleListState _titleListLoaded(TitleListState state, TitleListLoadedAction action) =>
    state.copy(
      isLoading: false,
      titleList: action.titleList,
    );
