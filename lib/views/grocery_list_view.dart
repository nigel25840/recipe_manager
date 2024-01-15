import 'package:flutter/material.dart';
import 'package:recipe_management/model/recipe_model.dart';
import 'package:recipe_management/utils/app_constants.dart';
import 'package:recipe_management/views/menu_view.dart';
import 'package:recipe_management/views/widgets/ingredient_tile.dart';

class GroceryListView extends StatelessWidget {
  const GroceryListView({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: MenuDrawer(),
        appBar: AppBar(
          title: Text('Recipe Manager'),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _groceryListView(context, recipe: recipe),
        ));
  }

  Widget _groceryListView(BuildContext context, {required Recipe recipe}) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return IngredientTile(ingredient: recipe.ingredients[index]);
      },
      separatorBuilder: (context, index) => AppConstants.kDefaultDivider,
      itemCount: recipe.ingredients.length,
    );
  }
}
