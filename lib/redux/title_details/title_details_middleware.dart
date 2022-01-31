import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_search/data/title_details.dart';
import 'package:movie_search/redux/state.dart';
import 'package:movie_search/redux/title_details/title_details_actions.dart';
import 'package:redux/redux.dart';

class TitleDetailsMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    next(action);
    if (action is FetchTitleDetailsAction) {
      var titleId = store.state.titleDetailsState.titleId;
      var response = await http.get(
          Uri.parse('https://imdb-api.com/en/API/Title/k_956nmhwo/$titleId'));

      if (response.statusCode == 200) {
        var rawTitleDetails = jsonDecode(response.body);
        var titleDetails = TitleDetails.fromJson(rawTitleDetails);

        store.dispatch(TitleDetailsLoadedAction(titleDetails));
      }
    }
  }
}
