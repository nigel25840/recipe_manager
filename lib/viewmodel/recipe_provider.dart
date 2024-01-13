import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_management/globals.dart';
import 'package:recipe_management/repository/app_facade.dart';

import '../model/recipe_model.dart';

/// this provider class is used to provide recipes

class RecipeProvider extends ChangeNotifier {
  List<Recipe> allRecipes = [];
  IAppFacade appFacade = GetIt.instance<IAppFacade>();
  ViewState state = ViewState.idle;

  Future<void> initializeProvider() async {
    
  }
}