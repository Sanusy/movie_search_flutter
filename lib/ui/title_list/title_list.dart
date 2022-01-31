import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_search/redux/state.dart';
import 'package:movie_search/redux/title_list/title_list_actions.dart';
import 'package:movie_search/ui/title_list/title_list_view_model.dart';
import 'package:redux/redux.dart';

class TitleListScreen extends StatelessWidget {
  const TitleListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        onInit: (store) {
          store.dispatch(LoadTitleListAction());
        },
        converter: (Store<AppState> store) {
          var titleListState = store.state.titleListState;
          return titleListState.isLoading
              ? TitleListLoading()
              : TitleListLoaded.create(store);
        },
        builder: (BuildContext context, TitleListViewModel viewModel) =>
            Scaffold(
                appBar: AppBar(
                  title: const Text('MovieList'),
                ),
                body: _buildTitleList(context, viewModel)));
  }

  Widget _buildTitleList(BuildContext context, TitleListViewModel viewModel) {
    if (viewModel is TitleListLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      var titleListviewModel = viewModel as TitleListLoaded;
      return ListView.builder(
        itemCount: titleListviewModel.titleList.length,
        itemBuilder: (context, itemIndex) =>
            _buildMovieItem(context, titleListviewModel.titleList[itemIndex]),
      );
    }
  }

  Widget _buildMovieItem(BuildContext context, TitleItem title) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: InkWell(
        onTap: () => title.titleClickedCommand(),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              title.image,
              width: 54,
              height: 96,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title.title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(title.year),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void navigateToTitleDetails(BuildContext context, String titleId) {
    Navigator.of(context).pushNamed('/movieDetails/$titleId');
  }
}
