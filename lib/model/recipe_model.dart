import 'package:conduit_codable/conduit_codable.dart';

class Recipe extends Coding {
  String? title;
  int? id;
  List<Ingredient>? missedIngredients;
  List<Ingredient>? usedIngredients = [];
  List<Ingredient> ingredients = [];
  String? image;
  String? summary;

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

class Ingredient extends Coding {
  int? id;
  String? aisle;
  String? image;
  String? name;
  double? amount;
  bool onHand = false;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    id = object.decode('id');
    aisle = object.decode('aisle');
    image = object.decode('image');
    name = object.decode('name');
    amount = object.decode('amount');
    onHand = false;
  }

  @override
  void encode(KeyedArchive object) {}
}
