class Recipe {
  String? title;
  String? id;
  List<Ingredient>? extendedIngredients;
  String? image;
  String? summary;
}

class Ingredient {
  int? id;
  String? aisle;
  String? imageUrl;
  String? name;
  double? amount;
}