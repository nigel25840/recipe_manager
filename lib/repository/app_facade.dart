import 'package:conduit_codable/conduit_codable.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_management/exceptions/exceptions.dart';
import 'package:recipe_management/model/ingredient_model.dart';
import 'package:recipe_management/repository/api_repository.dart';
import 'package:recipe_management/repository/local_repository.dart';

import '../model/recipe_model.dart';

abstract class IAppFacade {
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List? ingredients});
  Future<List<String>> fetchIngredients();
  Future<void> addIngredient({required Ingredient ingredient});
}

class AppFacade implements IAppFacade {
  late ApiRepository apiRepository;

  @override
  // fetches all recipes, both remote and local
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List? ingredients}) async {
    apiRepository = ApiRepository<Recipe>(Recipe.new);

    // then perform an API call to fetch remote recipes matching the ingredients
    Either<Exception, List<Coding>> eitherResponse = await apiRepository.fetchAll();
    return await eitherResponse.fold(
        (exception) async {
          return left(ServerFailure(code: 400, message: 'The request failed'));
        },
        (success) {
          List<T> typedList = success.map<T>((coding) => coding as T).toList();
          return right(typedList);
        }
    );
  }

  @override
  Future<List<String>> fetchIngredients() async {
    return LocalRepository.fetchIngredients();
  }

  Future<void> addIngredient({required Ingredient ingredient}) async {
    await LocalRepository.addIngredient(ingredient: ingredient);
  }

  Future<void> removeIngredient({required int itemId}) async {
    await LocalRepository.removeIngredient(ingredientId: itemId);
  }
}