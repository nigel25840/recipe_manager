import 'package:conduit_codable/conduit_codable.dart';
import 'package:dartz/dartz.dart';

abstract class IAppFacade {
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List? ingredients});
}

class AppFacade implements IAppFacade {
  @override
  // fetches all recipes, both remote and local
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List? ingredients}){
    return null;
  }
}