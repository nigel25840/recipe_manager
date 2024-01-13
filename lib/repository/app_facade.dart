import 'package:conduit_codable/conduit_codable.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_management/exceptions/exceptions.dart';
import 'package:recipe_management/repository/api_repository.dart';

import '../model/recipe_model.dart';

abstract class IAppFacade {
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List? ingredients});
}

class AppFacade implements IAppFacade {
  late ApiRepository repository;

  @override
  // fetches all recipes, both remote and local
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List? ingredients}) async {
    repository = ApiRepository<Recipe>(Recipe.new);
    // check local storage for saved recipes with matching ingredients

    // then perform an API call to fetch remote recipes matching the ingredients
    Either<Exception, List<Coding>> eitherResponse = await repository.fetchAll();
    return await eitherResponse.fold(
        (exception) async {
          return left(ServerFailure(code: 400, message: 'The request failed'));
        },
        (success) {
          return right(success);
        }
    );

    // merge the two data sets
  }
}