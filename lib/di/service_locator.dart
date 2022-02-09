
import 'package:get_it/get_it.dart';
import 'package:movie_search/data/service/title_service.dart';

final serviceLocator = GetIt.I;

void initDependencies() {
  serviceLocator.registerSingleton<ITitleService>(TitleService());
}