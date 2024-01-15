import 'package:flutter/material.dart';
import 'package:recipe_management/model/recipe_model.dart';
import 'package:recipe_management/views/menu_view.dart';

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
      body: Center(
        child: Text(recipe.title ?? 'No title'),
      ),
    );
  }
}
