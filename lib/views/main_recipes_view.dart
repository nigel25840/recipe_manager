import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_management/globals.dart';
import 'package:recipe_management/model/recipe_model.dart';
import 'package:recipe_management/utils/app_constants.dart';
import 'package:recipe_management/viewmodel/recipe_provider.dart';
import 'package:recipe_management/views/grocery_list_view.dart';
import 'package:recipe_management/views/menu_view.dart';
import 'package:recipe_management/views/widgets/recipe_tile.dart';

class MainRecipesView extends StatelessWidget {
  late final String title;
  MainRecipesView({String? title});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecipeProvider(
        errorCallback: (String message) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(message),
          ));
        },
      )..initializeProvider(),
      child: Scaffold(
        endDrawer: MenuDrawer(),
        appBar: AppBar(
          title: Text('Recipe Manager'),
          backgroundColor: Colors.green,
        ),
        body: Container(
          child: Consumer<RecipeProvider>(
            builder: (_, RecipeProvider provider, __) {
              return provider.state == ViewState.idle
                  ? recipeList(provider: provider)
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Widget recipeList({required RecipeProvider provider}) {
    // return RecipeTile(recipe: provider.allRecipes[0]);
    return ListView.separated(
        itemBuilder: (context, index) {
          Recipe recipe = provider.allRecipes[index];
          return GestureDetector(
            child: RecipeTile(recipe: recipe),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroceryListView(recipe: recipe),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) => AppConstants.kDefaultDivider,
        itemCount: provider.allRecipes.length);
  }
}
