import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:movie_search/redux/reducer.dart';
import 'package:movie_search/redux/state.dart';
import 'package:movie_search/redux/title_details/title_details_middleware.dart';
import 'package:movie_search/redux/title_list/title_list_middleware.dart';
import 'package:movie_search/ui/title_details/title_details.dart';
import 'package:movie_search/ui/title_list/title_list.dart';
import 'package:redux/redux.dart';

void main() {
  runApp(const MovieSearchApp());
}

class MovieSearchApp extends StatelessWidget {
  const MovieSearchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: Store<AppState>(appReducer,
          initialState: AppState.initial(),
          middleware: [
            const NavigationMiddleware<AppState>(),
            TitleListMiddleware(),
            TitleDetailsMiddleware(),
          ]),
      child: MaterialApp(
          title: 'MovieSearch',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          navigatorKey: NavigatorHolder.navigatorKey,
          onGenerateRoute: (settings) {
            if (settings.name == '/') {
              return MaterialPageRoute(builder: (context) => TitleListScreen());
            } else if (settings.name == '/movieDetails') {
              return MaterialPageRoute(
                  builder: (context) => const TitleDetailsScreen());
            }
          }),
    );
  }
}
