import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:recipe_management/model/ingredient_model.dart';
import 'package:recipe_management/model/recipe_model.dart';
import 'package:recipe_management/repository/app_facade.dart';
import 'package:recipe_management/utils/app_constants.dart';
import 'package:recipe_management/view_model/pantry_provider.dart';
import 'package:recipe_management/views/grocery_list_view.dart';
import 'package:recipe_management/views/pantry_view.dart';
import 'package:recipe_management/views/widgets/grocery_item_tile.dart';

import 'shared_mocks.dart';

void main() async {
  setUp(() {
    // Register the MockAppFacade only if it's not registered
    if (!GetIt.instance.isRegistered<IAppFacade>()) {
      GetIt.instance.registerLazySingleton<IAppFacade>(() => MockAppFacade.new());
    }
  });

  tearDown(() {
    GetIt.instance.unregister<IAppFacade>();
  });

  Ingredient ingredient1 = Ingredient()
    ..name = 'ingredient1'
    ..amount = 1.0
    ..onHand = false
    ..aisle = 'aisle1';
  Ingredient ingredient2 = Ingredient().copyWith(name: 'ingredient2');
  List<Ingredient> ingredients = [ingredient1, ingredient2];

  Recipe recipe = Recipe()
    ..ingredients = ingredients
    ..title='Recipe1'
    ..id=1
    ..likes=10;

  Widget widgetInTest() {
    return MaterialApp(
      home: GroceryListView(recipe: recipe),
    );
  }

  testWidgets('Tests grocery list view', (tester) async {
    await tester.pumpWidget(widgetInTest());
    await tester.pumpAndSettle();
    Finder tileFinder = find.byType(GroceryItemTile);
    expect(tileFinder, findsWidgets);
  });
}