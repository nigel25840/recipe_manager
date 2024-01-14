import 'package:flutter/material.dart';
import 'package:recipe_management/views/ingredients_view.dart';
import 'package:recipe_management/views/main_recipes_view.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black38,
              ),
              child: Text(''),
            ),
          ),
          ListTile(
            title: Text('Ingredients'),
            onTap: () => _navigate(context, MaterialPageRoute(builder: (context) => IngredientsView())),
          ),
          ListTile(
            title: Text('Recipes'),
            onTap: () => _navigate(context, MaterialPageRoute(builder: (context) => MainRecipesView())),
          ),
          // Add more ListTile items as needed
        ],
      ),
    );
  }

  void _navigate(BuildContext context, MaterialPageRoute route) {
    Navigator.pop(context); // Close the drawer
    Navigator.push(context, route);
  }
}
