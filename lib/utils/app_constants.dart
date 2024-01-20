import 'dart:ui';
import 'package:flutter/material.dart';

class AppConstants {
  // UI strings
  static const String kAppTitle = 'Recipe Manager';
  static const String kGroceryMessage = 'Items highlighted in green are in stock';
  static const String kNoRecipesMessage = 'You currently have no recipes. Using the menu button in the upper right, go to the pantry view and add some ingredients, then perform a search';
  static const String kPantryTitle = 'My Pantry';
  static const String kServerError = 'Server failure, please check back';
  static const String kWelcomeMessage = 'Welcome to the recipe lookup app';

  // text styles
  static const TextStyle kTextStyleDefault = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle kTextStyleTitle = TextStyle(
    fontSize: 23,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle kTextStyleMessage = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.normal,
  );

  // UI styles
  static const kDefaultDivider = Divider(
    height: 10,
    color: Colors.blue,
  );
  static const kGroceryListDivider = Divider(
    height: 10,
    color: Colors.black26,
  );

  // UI keys
  static const Key keyAddIngredientText = Key('9aee93df-7677-48a4-95bb-0dd012372efd');
  static const Key keyRecipeListView = Key('ad87edb9-1c2c-47aa-83b9-51d14154d45a');
  static const Key keyNoRecipesView = Key('37e60294-69f7-4e8e-a6a6-f3094782d1a4');
  static const Key keyAddButton = Key('bd44bc1a-3d66-4d92-aca7-7c1e533f2025');
  static const Key keySearchRecipesButton = Key('eb5debe9-687e-46fd-93c6-2cc8adeed17e');
}
