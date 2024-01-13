import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:recipe_management/globals.dart';
import 'package:recipe_management/repository/app_facade.dart';

import '../model/recipe_model.dart';

/// this provider class is used to provide recipes

class RecipeProvider extends ChangeNotifier {
  List<Recipe> allRecipes = [];
  IAppFacade appFacade = GetIt.instance<IAppFacade>();
  ViewState _state = ViewState.idle;
  late void Function(String)? _onError;

  RecipeProvider({void Function(String)? errorCallback}){
    _onError = errorCallback;
  }

  Future<void> initializeProvider() async {

  }

  Future<void> setRecipes({required List<Recipe> recipes}) async {

  }

  Future<void> getAllRecipes({List<String>? ingredients}) async {
    setViewState(ViewState.busy);
    final response = await appFacade.fetchRecipes();
    response?.fold((failure){
      _onError?.call('Server failure, please check back');
    }

    );
  }

  void setViewState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  ViewState get state => state;
}