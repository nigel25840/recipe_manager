import 'package:conduit_codable/conduit_codable.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_management/exceptions/exceptions.dart';
import 'package:recipe_management/repository/api_repository.dart';
import 'package:recipe_management/repository/local_repository.dart';

import '../model/recipe_model.dart';

abstract class IAppFacade {
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List? ingredients});
  Future<List<String>> fetchIngredients();
}

class AppFacade implements IAppFacade {
  late ApiRepository apiRepository;
  LocalRepository localRepository = LocalRepository();

  @override
  // fetches all recipes, both remote and local
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List? ingredients}) async {
    apiRepository = ApiRepository<Recipe>(Recipe.new);
    // check local storage for saved recipes with matching ingredients

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
    return localRepository.fetchIngredients();
  }

  Future<void> addIngredient({required String itemId, required String ingredient}) async {
    localRepository.addItem(itemId: itemId, item: ingredient);
  }

  Future<void> removeIngredient({required String itemId}) async {
    localRepository.removeItem(itemId: itemId);
  }
}