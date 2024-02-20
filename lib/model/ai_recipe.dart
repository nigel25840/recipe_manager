import 'package:conduit_codable/conduit_codable.dart';

import 'ingredient_model.dart';

class AIRecipe extends Coding {

  String? title;
  String? countryOfOrigin;
  List<Ingredient>? ingredients;
  List<Instruction>? instructions;
  List<NutritionalInformation>? nutritionalInformation;

  @override
  void decode(KeyedArchive object) {
    // TODO: implement decode
    super.decode(object);
  }

  @override
  void encode(KeyedArchive object) {}
}

class Instruction extends Coding {
  @override
  void decode(KeyedArchive object) {
    // TODO: implement decode
    super.decode(object);
  }

  @override
  void encode(KeyedArchive object) {}
}

class NutritionalInformation extends Coding {
  @override
  void decode(KeyedArchive object) {
    // TODO: implement decode
    super.decode(object);
  }

  @override
  void encode(KeyedArchive object) {}
}

