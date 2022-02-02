import 'package:movie_search/redux/title_list/title_list_actions.dart';
import 'package:movie_search/redux/title_list/title_list_state.dart';
import 'package:redux/redux.dart';

Reducer<TitleListState> titleListReducer = combineReducers<TitleListState>([
  TypedReducer(_loadTitleList),
  TypedReducer(_titleListLoaded),
  TypedReducer(_updateQuery),
  TypedReducer(_performQuery),
  TypedReducer(_clearSearch),
  TypedReducer(_closeSearch),
  TypedReducer(_openSearch),
]);

TitleListState _loadTitleList(
        TitleListState state, LoadTitleListAction action) =>
    state.copy(
      isLoading: true,
      titleList: List.unmodifiable([]),
    );

TitleListState _titleListLoaded(
        TitleListState state, TitleListLoadedAction action) =>
    state.copy(
      isLoading: false,
      titleList: action.titleList,
    );

TitleListState _updateQuery(TitleListState state, UpdateQueryAction action) =>
    state.copy(searchQuery: action.query);

TitleListState _performQuery(TitleListState state, PerformQueryAction action) =>
    state.copy(
      isLoading: true,
      titleList: List.unmodifiable([]),
    );

TitleListState _clearSearch(TitleListState state, ClearSearchAction action) =>
    state.copy(searchQuery: '');

TitleListState _closeSearch(TitleListState state, CloseSearchAction action) =>
    state.copy(searchActive: false);

TitleListState _openSearch(TitleListState state, OpenSearchAction action) =>
    state.copy(searchActive: true);
