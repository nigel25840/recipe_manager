import 'package:conduit_codable/conduit_codable.dart';

import 'ingredient_model.dart';

class Recipe extends Coding {
  String? title;
  int? id;
  List<Ingredient>? missedIngredients;
  List<Ingredient>? usedIngredients = [];
  List<Ingredient> ingredients = [];
  String? image;
  String? summary;
  bool saved = false;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    title = object.decode('title');
    id = object.decode('id');
    image = object.decode('image');
    missedIngredients = object.decode('missedIngredients');
    usedIngredients = object.decode('usedIngredients');

    // after setting usedIngredients:onHand to true, combine all into one list
    usedIngredients?.map((recipe) => recipe.onHand = true);
    ingredients.addAll(missedIngredients ?? []);
    ingredients.addAll(usedIngredients ?? []);
  }

  @override
  void encode(KeyedArchive object) {}
}


