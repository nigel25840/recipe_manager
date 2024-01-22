import 'package:get_it/get_it.dart';
import 'package:recipe_management/repository/app_facade.dart';

/// The "locator" instance of GetIt manages dependencies for the Recipe Management app.
/// "initiateDependencies" registers a lazy singleton for dependency injection by using its
/// interface type.
///
/// The "locator" instance of GetIt allows easy integration of mock dependencies.
/// During testing, mock implementations of dependencies can be registered
/// in place of actual implementations using "GetIt.instance<Type>()". This enables effective
/// mocking of services and repositories for isolated unit testing.

final locator = GetIt.instance;

Future<void> initiateDependencies() async {
  locator.registerLazySingleton<IAppFacade>(AppFacade.new);
}