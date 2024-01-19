import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_management/globals.dart';
import 'package:recipe_management/model/ingredient_model.dart';
import 'package:recipe_management/utils/app_constants.dart';
import 'package:recipe_management/viewmodel/pantry_provider.dart';
import 'package:recipe_management/views/menu_drawer_view.dart';

class PantryView extends StatelessWidget {
  PantryView({super.key});
  final TextEditingController _itemEntryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PantryProvider()..initializeProvider(),
      child: Scaffold(
        endDrawer: MenuDrawer(),
        appBar: AppBar(
          title: Text('My Pantry'),
          backgroundColor: Colors.green,
        ),
        body: Consumer<PantryProvider>(
          builder: (_, provider, __) {
            return provider.state == ViewState.idle
                ? Center(
                    child: Column(
                      children: [
                        Text('Ingredients View', style: AppConstants.kTextStyleDefault),
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _itemEntryController,
                                decoration: InputDecoration(
                                  labelText: 'Enter text',
                                ),
                              ),
                            ),
                            SizedBox(width: 8), // Add some spacing between TextField and button
                            ElevatedButton(
                              onPressed: () {
                                // Handle button press
                                print(_itemEntryController.text);
                                provider.addItem(item: _itemEntryController.text);
                                _itemEntryController.clear();
                              },
                              child: Text('Add'),
                            ),
                          ],
                        ),
                        Expanded(child: ingredientsList(provider: provider))
                      ],
                    ),
                  )
                : CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Widget ingredientsList({required PantryProvider provider}) {
    return ListView.separated(
      itemBuilder: (context, index) {
        Ingredient ingredient = provider.inStockIngredients[index];
        return ListTile(
          title: Text(
            ingredient.name ?? '',
            style: TextStyle(fontSize: 16, color: Colors.black), // Example styles
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(height: 25, color: Colors.blue),
      itemCount: provider.inStockIngredients.length,
    );
  }
}