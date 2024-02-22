import 'package:conduit_codable/conduit_codable.dart';

import 'ai_Ingredient.dart';

class AIRecipe extends Coding {

  String? title;
  String? countryOfOrigin;
  List<AiIngredient?>? ingredients;
  List<Instruction?>? instructions;

  @override
  void decode(KeyedArchive object) {
    title = object.decode('title');
    countryOfOrigin = object.decode('country_of_origin');
    ingredients = object.decodeObjects('ingredients', AiIngredient.new);
    instructions = object.decodeObjects('instructions', Instruction.new);
    super.decode(object);
  }

  @override
  void encode(KeyedArchive object) {}
}

class Instruction extends Coding {
  int? step;
  String? instruction;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    step = object.decode('step');
    instruction = object.decode('instruction');
  }

  @override
  void encode(KeyedArchive object) {}
}

class NutritionalInformation extends Coding {
  int? calories;
  String? carbs;

  @override
  void decode(KeyedArchive object) {
    calories = object.decode('calories');
    carbs = object.decode('carbohydrates');
    super.decode(object);
  }

  @override
  void encode(KeyedArchive object) {}
}

