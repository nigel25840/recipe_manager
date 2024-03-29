import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_management/globals.dart';
import 'package:recipe_management/model/ingredient_model.dart';
import 'package:recipe_management/utils/app_constants.dart';
import 'package:recipe_management/view_model/pantry_provider.dart';
import 'package:recipe_management/view_model/recipe_provider.dart';
import 'package:recipe_management/views/main_recipes_view.dart';
import 'package:recipe_management/views/widgets/menu_drawer_view.dart';

class PantryView extends StatelessWidget {
  PantryView({Key? key}) : super(key: key);

  final TextEditingController _itemEntryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PantryProvider>(
      builder: (_, provider, __) {
        return Scaffold(
            endDrawer: MenuDrawer(),
            floatingActionButton: FloatingActionButton(
              key: AppConstants.keySearchRecipesButton,
              onPressed: () {
                // provider.doRecipeSearch();
                List<String> selections =
                    provider.selectedIngredients.map((ingredient) => ingredient.name ?? '').toList();

                // TODO: this should be replaced with an alert dialog informing the user to select some ingredients
                if(selections.isEmpty) return;

                Provider.of<RecipeProvider>(context, listen: false).getAllRecipes(ingredients: selections);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainRecipesView()),
                );
              },
              child: Icon(Icons.search),
              backgroundColor: Colors.green,
            ),
            appBar: AppBar(
              title: Text(AppConstants.kPantryTitle),
              backgroundColor: Colors.green,
            ),
            body: provider.state == ViewState.idle
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    key: AppConstants.keyAddIngredientText,
                                    controller: _itemEntryController,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.all(16.0),
                                      hintText: 'Enter new ingredient',
                                      filled: true,
                                      fillColor: Colors.grey[200],
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          color: Colors.blue,
                                          width: 2.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                key: AppConstants.keyAddButton,
                                onPressed: () {
                                  if(_itemEntryController.text.isEmpty) return;
                                  provider.addItem(item: _itemEntryController.text);
                                  provider.fetchIngredients();
                                  _itemEntryController.clear();
                                },
                                child: Text('Add'),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Expanded(
                            child: ingredientsList(provider: provider),
                          ),
                        ],
                      ),
                    ),
                  )
                : CircularProgressIndicator());
      },
    );
  }

  Widget ingredientsList({required PantryProvider provider}) {
    return ListView.builder(
      itemCount: provider.inStockIngredients.length,
      itemBuilder: (context, index) {
        Ingredient ingredient = provider.inStockIngredients[index];
        bool isSelected = provider.selectedIngredients.contains(ingredient);

        return Dismissible(
          key: Key(ingredient.name!), // Use a unique key for each item
          onDismissed: (direction) {
            // Remove the item from the data source
            provider.deleteItem(item: ingredient.name!);
            // Show a snack bar or perform any other action
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${ingredient.name} dismissed'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // TODO: handle the undo request
                  },
                ),
              ),
            );
          },
          background: Container(
            color: Colors.red, // Background color when swiping
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: ListTile(
            title: Text(
              ingredient.name ?? '',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            leading: Checkbox(
              key: ValueKey('${AppConstants.keyIngredientCheckbox}$index'),
              value: isSelected,
              onChanged: (value) {
                provider.toggleSelection(ingredient);
              },
            ),
          ),
        );
      },
    );
  }
}
