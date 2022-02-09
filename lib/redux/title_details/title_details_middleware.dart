import 'package:movie_search/data/service/title_service.dart';
import 'package:movie_search/redux/state.dart';
import 'package:movie_search/redux/title_details/title_details_actions.dart';
import 'package:redux/redux.dart';

class TitleDetailsMiddleware extends MiddlewareClass<AppState> {
  final ITitleService _titleService;

  TitleDetailsMiddleware(this._titleService);

  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);
    if (action is FetchTitleDetailsAction) {
      var titleId = store.state.titleDetailsState.titleId!;
      var titleDetails = await _titleService.getTitleDetails(titleId);
      store.dispatch(TitleDetailsLoadedAction(titleDetails));
    }
  }
}
