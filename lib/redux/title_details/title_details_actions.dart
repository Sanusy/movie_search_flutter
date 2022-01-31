import 'package:movie_search/data/title_details.dart';

class OpenTitleDetailsAction {
  final String titleId;

  OpenTitleDetailsAction(this.titleId);
}

class FetchTitleDetailsAction {}

class TitleDetailsLoadedAction {
  final TitleDetails titleDetails;

  TitleDetailsLoadedAction(this.titleDetails);
}