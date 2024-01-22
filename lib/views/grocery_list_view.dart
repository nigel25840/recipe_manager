import 'package:flutter/material.dart';
import 'package:recipe_management/model/recipe_model.dart';
import 'package:recipe_management/utils/app_constants.dart';
import 'package:recipe_management/views/widgets/menu_drawer_view.dart';
import 'package:recipe_management/views/widgets/grocery_item_tile.dart';

class GroceryListView extends StatelessWidget {
  const GroceryListView({super.key, required this.recipe});
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MenuDrawer(),
      appBar: AppBar(
        title: Text(AppConstants.kGroceryTitle),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConstants.kGroceryMessage, // Add your text above the ListView
              style: AppConstants.kTextStyleMessage,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Divider(height: 1, color: Colors.transparent),
            ), // Add some spacing between text and ListView
            _groceryListView(context, recipe: recipe),
          ],
        ),
      ),
    );
  }

  Widget _groceryListView(BuildContext context, {required Recipe recipe}) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (context, index) {
          return GroceryItemTile(ingredient: recipe.ingredients[index]);
        },
        separatorBuilder: (context, index) => AppConstants.kGroceryListDivider,
        itemCount: recipe.ingredients.length,
      ),
    );
  }
}

