import 'package:conduit_codable/conduit_codable.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_management/exceptions/exceptions.dart';
import 'package:recipe_management/model/ai_recipe.dart';
import 'package:recipe_management/model/ingredient_model.dart';
import 'package:recipe_management/repository/ai_repository.dart';
import 'package:recipe_management/repository/api_repository.dart';
import 'package:recipe_management/repository/local_repository.dart';
import 'package:recipe_management/model/recipe_model.dart';
import 'package:recipe_management/utils/app_constants.dart';

abstract class IAppFacade {
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List<String>? ingredients});
  Future<List<Ingredient>> fetchIngredients();
  Future<void> addIngredient({required Ingredient ingredient});
  Future<void> deleteIngredient({required String ingredientName});
  Future<List<AIRecipe>> getCustomRecipe({required String aiPrompt});
}

class AppFacade implements IAppFacade {
  late ApiRepository apiRepository;
  late AIRepository aiRepository;

  @override
  Future<List<AIRecipe>> getCustomRecipe({required String aiPrompt}) async {
    aiRepository = ChatGPTRepository();
    final String prompt = 'Create a JSON structure for a unique recipe. The recipe should have a title, '
        'a list of ingredients, instructions (each as a dictionary with an instruction number represented '
        'as an integer and the instruction itself as a string), and the country of origin. Each ingredient '
        'should be represented as a dictionary with an amount (integer or null if not). The recipes should '
        'include venison, chocolate, blueberries, vanilla ice cream, and chiles. Include nutritional '
        'information in the form of a dictionary. The nutritional info should be for the completed recipe '
        'and based on serving size. It should contain vitamins, calories, sodium, carbohydrates, etc';

    List<AIRecipe> recipes = await aiRepository.fetchRecipe(aiPrompt: [prompt]);
    return recipes;
  }

  @override
  // fetches all recipes from spoonacular API
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List<String>? ingredients}) async {
    apiRepository = ApiRepository<Recipe>(Recipe.new);

    // then perform an API call to fetch remote recipes matching the ingredients
    Either<Exception, List<Coding>> eitherResponse = await apiRepository.fetchAll(searchTerms: ingredients);
    return await eitherResponse.fold(
        (exception) async {
          return left(ServerFailure(code: 400, message: AppConstants.kServerError));
        },
        (success) {
          List<T> typedList = success.map<T>((coding) => coding as T).toList();
          return right(typedList);
        }
    );
  }

  @override
  Future<List<Ingredient>> fetchIngredients() async {
    return await LocalRepository.fetchIngredients();
  }

  @override
  Future<void> addIngredient({required Ingredient ingredient}) async {
    await LocalRepository.addIngredient(ingredient: ingredient);
  }

  @override
  Future<void> deleteIngredient({required String ingredientName}) async {
    LocalRepository.removeIngredient(ingredientName: ingredientName);
  }
}