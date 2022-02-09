import 'package:movie_search/data/title_details.dart';
import 'package:movie_search/data/title_list.dart';
import 'package:movie_search/redux/title_list/title_list_state.dart';

import '../../main.dart';

abstract class ITitleService {
  Future<TitleListByQueryDto> getTitleListByQuery(String query);

  Future<TitleListByCategoryDto> getTitleListByCategory(
      TitleListCategory category);

  Future<TitleDetails> getTitleDetails(String titleId);
}

class TitleService implements ITitleService {
  @override
  Future<TitleDetails> getTitleDetails(String titleId) async {
    var response = await dio.get('/Title/k_956nmhwo/$titleId');
    return TitleDetails.fromJson(response.data);
  }

  @override
  Future<TitleListByCategoryDto> getTitleListByCategory(
      TitleListCategory category) async {
    var response = await dio.get('/Top250Movies/k_956nmhwo');
    return TitleListByCategoryDto.fromJson(response.data);
  }

  @override
  Future<TitleListByQueryDto> getTitleListByQuery(String query) async {
    var response = await dio.get('/SearchTitle/k_956nmhwo/$query');
    return TitleListByQueryDto.fromJson(response.data);
  }
}
