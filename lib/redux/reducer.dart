import 'package:movie_search/redux/state.dart';
import 'package:movie_search/redux/title_details/title_details_reducer.dart';
import 'package:movie_search/redux/title_list/title_list_reducer.dart';

AppState appReducer(AppState state, action) => AppState(
      titleListReducer(state.titleListState, action),
      titleDetailsReducer(state.titleDetailsState, action),
    );
