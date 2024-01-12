import 'package:conduit_codable/conduit_codable.dart';

class Recipe extends Coding {
  String? title;
  String? id;
  List<Ingredient>? extendedIngredients;
  String? image;
  String? summary;

  @override
  void encode(KeyedArchive object) {
    // TODO: implement encode
  }
}

class Ingredient extends Coding {
  int? id;
  String? aisle;
  String? imageUrl;
  String? name;
  double? amount;

  @override
  void encode(KeyedArchive object) {
    // TODO: implement encode
  }
}