import 'package:flutter/material.dart';
import 'package:recipe_management/globals.dart';
import 'package:recipe_management/model/ingredient_model.dart';
import 'package:recipe_management/repository/app_facade.dart';
import 'package:get_it/get_it.dart';

class PantryProvider extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  List<Ingredient> inStockIngredients = [];
  IAppFacade appFacade = GetIt.instance<IAppFacade>();

  Future<void> initializeProvider() async {
    // set view state
    setViewState(ViewState.busy);
    // query local storage using AppFacade
    inStockIngredients = await appFacade.fetchIngredients();
    inStockIngredients.sort((a, b) => a.name!.compareTo(b.name!));
    // finish up by setting view state again
    setViewState(ViewState.idle);
  }

  Future<void> addItem({required String item}) async {
    // even though this is a local query, use ViewState to allow for possible future use of remote storage
    setViewState(ViewState.busy);

    // create a new ingredient model
    Ingredient ingredient = Ingredient()
      ..onHand = true
      ..amount = 0.0
      ..name = item;

    // update the local storage
    // inStockIngredients.add(ingredient);
    appFacade.addIngredient(ingredient: ingredient);

    // ensure there are no duplicates
    Set<Ingredient> tempSet = inStockIngredients.toSet();
    inStockIngredients = tempSet.toList();

    // sort the list
    inStockIngredients.sort((a, b) => a.name!.compareTo(b.name!));

    // update the view by setting view state to idle
    setViewState(ViewState.idle);
  }

  Future<void> deleteItem({required String item}) async {
    // delete the item from local storage
    if(inStockIngredients.contains(item)) {
      inStockIngredients.remove(item);
    }
    setViewState(ViewState.idle);
  }

  void setViewState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  ViewState get state => _state;
}