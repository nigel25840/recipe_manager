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
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Ingredients'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IngredientsView()),
              );
            },
          ),
          ListTile(
            title: Text('Recipes'),
            onTap: () {
              Navigator.pop(context); // Close the drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MainRecipesView()),
              );
            },
          ),
          // Add more ListTile items as needed
        ],
      ),
    );
  }
}