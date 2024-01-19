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
          title: Text('My Pantry'),
          backgroundColor: Colors.green,
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
    return ListView.separated(
      itemBuilder: (context, index) {
        Ingredient ingredient = provider.inStockIngredients[index];
        return ListTile(
          title: Text(
            ingredient.name ?? '',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(height: 0, color: Colors.blue),
      itemCount: provider.inStockIngredients.length,
    );
  }
}


