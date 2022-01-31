import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_search/data/title_details.dart';
import 'package:movie_search/redux/state.dart';
import 'package:movie_search/redux/title_details/title_details_actions.dart';
import 'package:movie_search/ui/title_details/title_details_viewmodel.dart';
import 'package:redux/redux.dart';

class TitleDetailsScreen extends StatelessWidget {
  const TitleDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector(
      onInit: (Store<AppState> store) => store.dispatch(FetchTitleDetailsAction()),
      converter: (Store<AppState> store) {
        var titleDetailsState = store.state.titleDetailsState;

        return titleDetailsState.isLoading
            ? TitleDetailsLoading()
            : TitleDetailsLoaded.create(store);
      },
      builder: (BuildContext context, TitleDetailsViewModel viewModel) =>
          Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: _buildAppBar(context, viewModel),
              ),
            ];
          },
          body: _buildTitledDetailsBody(context, viewModel)
        ),
      ),
    );
  }

  //   return StoreConnector(
  //     converter: (Store<AppState> store) {
  //       var titleDetailsState = store.state.titleDetailsState;
  //
  //       return titleDetailsState.isLoading
  //           ? TitleDetailsLoading()
  //           : TitleDetailsLoaded.create(store);
  //     },
  //     builder: (BuildContext context, TitleDetailsViewModel viewModel) =>
  //     viewModel is TitleDetailsLoading ?
  //         Scaffold(
  //             appBar: AppBar(
  //               title: const Text('MovieSearch'),
  //             ),
  //             body: const Center(
  //               child: Text('Title details'),
  //             )) : buildMovieDetails(context, viewModel as TitleDetailsLoaded),
  //   );
  // }

  Widget _buildAppBar(BuildContext context, TitleDetailsViewModel viewModel) {
    var titleDetailsLoaded = viewModel is TitleDetailsLoaded;

    var toolBarTitle = titleDetailsLoaded ? viewModel.title : 'MovieSearch';

    var background = titleDetailsLoaded
        ? Image.network(
            viewModel.image,
            fit: BoxFit.cover,
          )
        : null;

    return FlexibleSpaceBar(
        centerTitle: true,
        title: Text(toolBarTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            )),
        background: background);
  }

  Widget _buildTitledDetailsBody(BuildContext context, TitleDetailsViewModel viewModel) {

    if (viewModel is TitleDetailsLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    var titleDetails = viewModel as TitleDetailsLoaded;
    return buildMovieDetails(context, titleDetails);
  }

  Widget buildMovieDetails(
      BuildContext context, TitleDetailsLoaded titleDetails) {
    print(titleDetails.id);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Duration:\t ${titleDetails.duration}'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('Year:\t ${titleDetails.year}'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(titleDetails.plot),
            ),
            ListView.separated(
              padding: const EdgeInsets.only(top: 8),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: titleDetails.actors.length,
              itemBuilder: (context, index) =>
                  _buildActorItem(context, titleDetails.actors[index]),
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(
                  height: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActorItem(BuildContext context, ActorItem actor) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          foregroundImage: NetworkImage(actor.image),
          backgroundColor: Colors.grey,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(actor.name),
                Text('as ${actor.asCharacter}'),
              ],
            ),
          ),
        )
      ],
    );
  }
}
