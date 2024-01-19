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
}
