import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_management/views/main_recipes_view.dart';

class RouteDefinitions {
  static const String kRouteRecipes = 'main_recipes_view';
  static const String kRouteIngredients = 'ingredients_view';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  MaterialPageRoute route;
  switch (settings.name) {
    case RouteDefinitions.kRouteRecipes:
      return MaterialPageRoute(builder: (_) => MainRecipesView());
    // case RouteDefinitions.kRouteIngredients:
    //   return MaterialPageRoute(builder: (_) => )
  }
}