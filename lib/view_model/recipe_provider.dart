import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_management/globals.dart';
import 'package:recipe_management/model/ai_recipe.dart';
import 'package:recipe_management/repository/app_facade.dart';
import 'package:recipe_management/utils/app_constants.dart';

import '../model/recipe_model.dart';

/// this provider class is used to provide recipes
/// RecipeProvider as a provider or viewmodel for the MainRecipesView view.
/// Provides lists of recipes to send to the UI, returned from the API

class RecipeProvider extends ChangeNotifier {
  List<Recipe> allRecipes = [];
  List<AIRecipe> aiRecipes = [];
  IAppFacade appFacade = GetIt.instance<IAppFacade>();
  ViewState _state = ViewState.idle;
  late void Function(String)? _onError;

  RecipeProvider({void Function(String)? errorCallback}) {
    _onError = errorCallback;
  }

  Future<void> initializeProvider() async {
    setViewState(ViewState.busy);
    await getAllRecipes(ingredients: []);
    setViewState(ViewState.idle);
  }

  Future<void> setRecipes({required List<Recipe> recipes}) async {}

  Future<void> getCustomRecipe({required String prompt}) async {
    aiRecipes = await appFacade.getCustomRecipe(aiPrompt: '');
  }

  Future<void> getAllRecipes({List<String>? ingredients}) async {
    setViewState(ViewState.busy);
    final response = await appFacade.fetchRecipes<Recipe>(ingredients: ingredients);
    response?.fold((failure) {
      _onError?.call(AppConstants.kServerError);
    }, (success) => allRecipes = success);
    setViewState(ViewState.idle);
  }

  void setViewState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  ViewState get state => _state;
}
