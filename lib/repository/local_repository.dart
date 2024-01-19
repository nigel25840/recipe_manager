import 'dart:convert';
import 'package:conduit_codable/conduit_codable.dart';
import 'package:recipe_management/model/ingredient_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepository {
  static const String key = 'pantry_data_key';

  static Future<List<String>> fetchIngredients() {
    return Future.value([]);
  }

  static Future<void> addIngredient({required Ingredient ingredient}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final archive = KeyedArchive.archive(ingredient);
    final serializedIngredient = json.encode(archive);
    print(serializedIngredient);
  }

  static Future<void> removeIngredient({required int ingredientId}) async {

  }
}
