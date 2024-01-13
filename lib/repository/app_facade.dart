import 'package:conduit_codable/conduit_codable.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_management/exceptions/exceptions.dart';
import 'package:recipe_management/repository/api_repository.dart';

import '../model/recipe_model.dart';

abstract class IAppFacade {
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List? ingredients});
}

class AppFacade implements IAppFacade {
  ApiRepository apiRecipeRepo = ApiRepository<Recipe>(Recipe.new);

  @override
  // fetches all recipes, both remote and local
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List? ingredients}) async {
    // check local storage for saved recipes with matching ingredients

    // then perform an API call to fetch remote recipes matching the ingredients
    Either<Exception, List<Coding>> eitherResponse = await apiRecipeRepo.fetchAll();
    return await eitherResponse.fold(
        (Exception ex) async {
          return left(ServerFailure(code: 400, message: 'The request failed'));
        },
        (List<Coding> success) {
          return right([]);
        }
    );

    // merge the two data sets


    return null;
  }
}