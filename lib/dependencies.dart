import 'package:get_it/get_it.dart';
import 'package:recipe_management/repository/api_repository.dart';
import 'package:recipe_management/repository/app_facade.dart';

final locator = GetIt.instance;

Future<void> initiateDependencies() async {
  locator.registerLazySingleton<IAppFacade>(AppFacade.new);
}