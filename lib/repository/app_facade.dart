import 'package:conduit_codable/conduit_codable.dart';
import 'package:dartz/dartz.dart';

abstract class IAppFacade {
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List? ingredients});
}

class AppFacade implements IAppFacade {
  @override
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List? ingredients}){
    return null;
  }
}