import 'package:flutter/material.dart';
import 'package:recipe_management/globals.dart';

class IngredientsProvider extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  List<String> inStockIngredients = [];

  Future<void> initializeProvider() async {
    // initialize local storage

    // query local storage using AppFacade
  }

  Future<void> addItem({required String item}) async {
    // even though this is a local query, use ViewState to allow for possible future use of remote storage

    // add the item to the list

    // update local storage

    setViewState(ViewState.idle);
  }

  Future<void> deleteItem({required String item}) async {
    // delete the item from local storage

    setViewState(ViewState.idle);
  }

  void setViewState(ViewState viewState) {
    _state = viewState;
    notifyListeners();
  }

  ViewState get state => _state;
}