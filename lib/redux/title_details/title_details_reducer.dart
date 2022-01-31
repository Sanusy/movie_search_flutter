import 'package:movie_search/redux/title_details/title_details_actions.dart';
import 'package:movie_search/redux/title_details/title_details_state.dart';
import 'package:redux/redux.dart';

Reducer<TitleDetailsState> titleDetailsReducer =
    combineReducers<TitleDetailsState>([
  TypedReducer(_openTitleDetails),
  TypedReducer(_titleDetailsLoaded),
]);

TitleDetailsState _openTitleDetails(
        TitleDetailsState state, OpenTitleDetailsAction action) =>
    state.copy(
      isLoading: true,
      titleId: action.titleId,
    );

TitleDetailsState _titleDetailsLoaded(
        TitleDetailsState state, TitleDetailsLoadedAction action) =>
    state.copy(
      isLoading: false,
      titleDetails: action.titleDetails,
    );
