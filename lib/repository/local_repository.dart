import 'dart:convert';
import 'package:conduit_codable/conduit_codable.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipe_management/model/ingredient_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This class is used to fetch, add, & delete data that is persisted locally on the device
/// It is only accessible through the AppFacade. For the purpose of this demo, shared preferences
/// is being used. In a real world app, a more robust persistence like Hive should be used

class LocalRepository {
  static const String key = 'pantry_data_key';

  static Future<List<Ingredient>> fetchIngredients() async {
    List<Ingredient> allIngredients = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Set<String> allKeys = await preferences.getKeys();

    for(String key in allKeys) {
      String? jsonIngredient = await preferences.getString(key);
      if(jsonIngredient != null) {
        Ingredient? ingredient = deserializeIngredient(jsonIngredient);
        if(ingredient != null) {
          allIngredients.add(ingredient);
        }
      }
    }
    return allIngredients;
  }

  static Ingredient? deserializeIngredient(String jsonString) {
    print(jsonString);
    final decodedJson = json.decode(jsonString);
    final archive = KeyedArchive.unarchive(decodedJson);
    final Ingredient ingredient = Ingredient()..decode(archive);
    return ingredient;
  }

  static Future<void> addIngredient({required Ingredient ingredient}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final archive = KeyedArchive.archive(ingredient);
    final String serializedIngredient = json.encode(archive);

    if(ingredient.name != null) {
      preferences.setString(ingredient.name!, serializedIngredient);
    }
  }

  static Future<void> removeIngredient({required String ingredientName}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Set<String> allKeys = await preferences.getKeys();
    if (allKeys.isNotEmpty) {
      for(String key in allKeys){
        if(key == ingredientName) {
          preferences.remove(key);
          break;
        }
      }
    }
  }
}
