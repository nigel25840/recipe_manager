import 'package:conduit_codable/conduit_codable.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_management/model/ingredient_model.dart';
import 'package:recipe_management/repository/app_facade.dart';

class MockAppFacade<T extends Coding> extends Mock implements IAppFacade {
  @override
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List<String>? ingredients}) async {
    return Future.value(right([]));
  }

  @override
  Future<List<Ingredient>> fetchIngredients() async {
    Ingredient ingredient1 = Ingredient()
      ..name = 'ingredient1'
      ..amount = 1.0
      ..onHand = false
      ..aisle = 'aisle1';
    Ingredient ingredient2 = Ingredient()
      ..name = 'ingredient2'
      ..amount = 1.0
      ..onHand = true
      ..aisle = 'aisle2';
    return [ingredient1, ingredient2];
  }
}
