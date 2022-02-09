import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_search/redux/state.dart';
import 'package:movie_search/redux/title_list/title_list_actions.dart';
import 'package:movie_search/redux/title_list/title_list_state.dart';
import 'package:movie_search/ui/title_list/title_list_view_model.dart';
import 'package:redux/redux.dart';

class TitleListScreen extends StatelessWidget {
  TitleListScreen({Key? key}) : super(key: key);

  final _searchTextInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
        onInit: (store) {
          store.dispatch(LoadSelectedCategoryAction(Top250Series()));
        },
        converter: (Store<AppState> store) {
          var titleListState = store.state.titleListState;
          return titleListState.isLoading
              ? TitleListLoading.create(store)
              : TitleListLoaded.create(store);
        },
        builder: (BuildContext context, TitleListViewModel viewModel) =>
            Scaffold(
                appBar: _buildAppBar(viewModel.appBar),
                body: Column(
                  children: [
                    _buildFilters(viewModel.category),
                    _buildTitleList(context, viewModel),
                  ],
                )));
  }

  Widget _buildFilters(TitleListCategoryViewModel filtersViewModel) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        separatorBuilder: (buildContext, index) => const SizedBox(
          width: 4,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) =>
            _buildChip(filtersViewModel.filters[index]),
        itemCount: filtersViewModel.filters.length,
        padding: const EdgeInsets.symmetric(horizontal: 4),
      ),
    );
  }

  Widget _buildChip(Filter filter) {
    return InputChip(
      label: Text(filter.name),
      selected: filter.isSelected,
      isEnabled: !filter.isSelected,
      onPressed: filter.onClick,
    );
  }

  Widget _buildTitleList(BuildContext context, TitleListViewModel viewModel) {
    if (viewModel is TitleListLoading) {
      return const Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      var titleListViewModel = viewModel as TitleListLoaded;
      return Expanded(
        child: ListView.builder(
          itemCount: titleListViewModel.titleList.length,
          itemBuilder: (context, itemIndex) =>
              _buildMovieItem(context, titleListViewModel.titleList[itemIndex]),
        ),
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
                    if (title.year != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(title.year!),
                      ),
                    if (title.type != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(title.type!),
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

  PreferredSizeWidget _buildAppBar(TitleListAppBar appBar) {

    if(appBar.searchQuery.isEmpty) {
      _searchTextInputController.clear();
    }

    var leading = appBar.searchActive
        ? IconButton(
            onPressed: appBar.closeSearch,
            icon: const Icon(Icons.arrow_back_outlined))
        : null;

    var title = appBar.searchActive
        ? TextField(
            cursorColor: Colors.white,
            style: const TextStyle(
              color: Colors.white,
            ),
            textInputAction: TextInputAction.search,
            onChanged: appBar.updateQuery,
            onSubmitted: (_) => appBar.performQuery(),
            controller: _searchTextInputController,
            decoration: const InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.white38,
                )),
          )
        : const Text('MovieSearch');

    var action = appBar.searchActive && appBar.searchQuery.isNotEmpty
        ? IconButton(
            onPressed: appBar.clearQuery, icon: const Icon(Icons.close))
        : !appBar.searchActive
            ? IconButton(
                onPressed: appBar.openSearch, icon: const Icon(Icons.search))
            : null;

    return AppBar(
      leading: leading,
      title: title,
      actions: action != null ? [action] : null,
    );
  }
}
