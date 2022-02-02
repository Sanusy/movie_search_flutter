import 'package:movie_search/data/title_list.dart';

class LoadTitleListAction {}

class TitleListLoadedAction {
  final List<TitleData> titleList;

  TitleListLoadedAction(
    this.titleList,
  );
}

class TitleClickedAction {
  final String titleId;

  TitleClickedAction(this.titleId);
}

class UpdateQueryAction {
  final String query;

  UpdateQueryAction(this.query);
}

class PerformQueryAction {}
class ClearSearchAction {}
class OpenSearchAction {}
class CloseSearchAction {}