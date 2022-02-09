import 'package:movie_search/data/service/title_service.dart';
import 'package:movie_search/redux/state.dart';
import 'package:movie_search/redux/title_list/title_list_actions.dart';
import 'package:redux/redux.dart';

class TitleListMiddleware extends MiddlewareClass<AppState> {
  final ITitleService _titleService;

  TitleListMiddleware(this._titleService);

  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);
    if (action is PerformQueryAction) {
      var titleList = await _titleService
          .getTitleListByQuery(store.state.titleListState.searchQuery);

      store.dispatch(TitleListLoadedAction(titleList.results));
    } else if (action is LoadSelectedCategoryAction) {
      var titleList = await _titleService
          .getTitleListByCategory(store.state.titleListState.activeCategory);

      store.dispatch(TitleListLoadedAction(titleList.items));
    }
  }
}
