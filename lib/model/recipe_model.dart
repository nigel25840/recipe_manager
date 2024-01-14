import 'package:conduit_codable/conduit_codable.dart';

import 'ingredient_model.dart';

class Recipe extends Coding {
  String? title;
  int? id;
  List<Ingredient?>? missedIngredients;
  List<Ingredient?>? usedIngredients = [];
  List<Ingredient> ingredients = [];
  String? image;
  String? summary;
  int? likes;
  bool saved = false;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    title = object.decode('title');
    id = object.decode('id');
    image = object.decode('image');
    likes = object.decode('likes');
    missedIngredients = object.decodeObjects('missedIngredients', Ingredient.new);
    usedIngredients = object.decodeObjects('usedIngredients', Ingredient.new);

    // Update usedIngredients:onHand to true
    usedIngredients?.forEach((ingredient) => ingredient?.onHand = true);

    // After setting usedIngredients:onHand to true, combine all into one list
    ingredients.addAll(missedIngredients?.whereType<Ingredient>() ?? []);
    ingredients.addAll(usedIngredients?.whereType<Ingredient>() ?? []);
  }



  @override
  void encode(KeyedArchive object) {}
}


