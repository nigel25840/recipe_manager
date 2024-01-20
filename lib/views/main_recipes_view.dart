import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_management/globals.dart';
import 'package:recipe_management/model/recipe_model.dart';
import 'package:recipe_management/utils/app_constants.dart';
import 'package:recipe_management/view_model/recipe_provider.dart';
import 'package:recipe_management/views/grocery_list_view.dart';
import 'package:recipe_management/views/widgets/menu_drawer_view.dart';
import 'package:recipe_management/views/widgets/recipe_tile.dart';

class MainRecipesView extends StatelessWidget {
  late final String title;
  MainRecipesView({String? title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MenuDrawer(),
      appBar: AppBar(
        title: Text(AppConstants.kAppTitle),
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
    );
  }

  Widget recipeList({required RecipeProvider provider}) {
    return provider.allRecipes.isNotEmpty
        ? ListView.separated(
            key: AppConstants.keyRecipeListView,
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
            itemCount: provider.allRecipes.length,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            key: AppConstants.keyNoRecipesView,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppConstants.kWelcomeMessage,
                  style: AppConstants.kTextStyleMessage,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  AppConstants.kNoRecipesMessage,
                  style: AppConstants.kTextStyleMessage,
                ),
              ),
            ],
          );
  }
}
