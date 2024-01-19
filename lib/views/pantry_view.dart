import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_management/globals.dart';
import 'package:recipe_management/model/ingredient_model.dart';
import 'package:recipe_management/utils/app_constants.dart';
import 'package:recipe_management/viewmodel/pantry_provider.dart';
import 'package:recipe_management/views/widgets/menu_drawer_view.dart';

class PantryView extends StatelessWidget {
  PantryView({Key? key}) : super(key: key);

  final TextEditingController _itemEntryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PantryProvider()..initializeProvider(),
      child: Scaffold(
        endDrawer: MenuDrawer(),
          appBar: AppBar(
            title: Text('Recipe Manager'),
            backgroundColor: Colors.green,
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // Handle the plus button tap
                  _showAddItemDialog(context);
                },
              ),
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ],
          ),
        body: Consumer<PantryProvider>(
          builder: (_, provider, __) {
            return provider.state == ViewState.idle
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
                              controller: _itemEntryController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(16.0),
                                hintText: 'Enter text here',
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
                          onPressed: () {
                            print(_itemEntryController.text);
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
                : CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget ingredientsList({required PantryProvider provider}) {
    return ListView.builder(
      itemCount: provider.inStockIngredients.length,
      itemBuilder: (context, index) {
        Ingredient ingredient = provider.inStockIngredients[index];
        return Dismissible(
          key: Key(ingredient.name!), // Use a unique key for each item
          onDismissed: (direction) {
            // Remove the item from the data source
            provider.deleteItem(item: ingredient.name!);
            // Show a snack bar or perform any other action
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${ingredient.name} removed from ingredients'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    // Undo the dismissal
                    // provider.undoRemoveIngredient();
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
          ),
        );
      },
    );
  }

  // Function to show the add item dialog
  Future<void> _showAddItemDialog(BuildContext context) async {
    String newItem = ''; // Initialize an empty string

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Item'),
          content: TextField(
            onChanged: (value) {
              newItem = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter item name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Send the value to the PantryProvider and close the dialog
                Provider.of<PantryProvider>(context, listen: false).addItem(item: newItem);
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}


