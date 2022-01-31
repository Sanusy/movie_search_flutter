import 'package:movie_search/redux/title_details/title_details_state.dart';
import 'package:movie_search/redux/title_list/title_list_state.dart';

class AppState {
  final TitleListState titleListState;
  final TitleDetailsState titleDetailsState;

  AppState(this.titleListState, this.titleDetailsState);

  AppState.initial()
      : titleListState = TitleListState.initial(),
        titleDetailsState = TitleDetailsState.initial();
}
