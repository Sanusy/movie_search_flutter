import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_search/data/title_list.dart';
import 'package:movie_search/redux/state.dart';
import 'package:movie_search/redux/title_list/title_list_actions.dart';
import 'package:redux/redux.dart';

class TitleListMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);
    if (action is LoadTitleListAction) {
      var response = await http.get(
          Uri.parse('https://imdb-api.com/en/API/Top250Movies/k_956nmhwo'));

      if (response.statusCode == 200) {
        var rawMovieList = jsonDecode(response.body)['items'] as List;
        var titleList =
            rawMovieList.map((tagJson) => TitleData.fromJson(tagJson)).toList();
        store.dispatch(TitleListLoadedAction(titleList));
      }
    }
  }
}
