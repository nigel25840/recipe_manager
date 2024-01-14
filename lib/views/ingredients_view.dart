import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_management/globals.dart';
import 'package:recipe_management/utils/app_constants.dart';
import 'package:recipe_management/viewmodel/ingredients_provider.dart';
import 'package:recipe_management/views/menu_view.dart';

class IngredientsView extends StatelessWidget {
  IngredientsView({super.key});
  final TextEditingController _itemEntryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IngredientsProvider()..initializeProvider(),
      child: Scaffold(
        endDrawer: MenuDrawer(),
        appBar: AppBar(
          title: Text('Recipe Manager'),
          backgroundColor: Colors.green,
        ),
        body: Center(
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
                      // You can access the text from _itemEntryController.text here
                    },
                    child: Text('Add'),
                  ),
                ],
              ),
              // Consumer<IngredientsProvider>(builder: (_, provider, __) {
              //   return provider.state == ViewState.idle
              //       ? Expanded(child: ingredientsList(provider: provider))
              //       : CircularProgressIndicator();
              // })
            ],
          )
          ,
        ),
      ),
    );
  }

  Widget ingredientsList({required IngredientsProvider provider}) {
    return ListView.separated(
      itemBuilder: (context, index) {
        String ingredient = provider.inStockIngredients[index];
        return ListTile(
          title: Text(
            ingredient,
            style: TextStyle(fontSize: 16, color: Colors.black), // Example styles
          ),
        );
      },
      separatorBuilder: (context, index) => Divider(height: 25, color: Colors.blue),
      itemCount: provider.inStockIngredients.length,
    );
  }
}
