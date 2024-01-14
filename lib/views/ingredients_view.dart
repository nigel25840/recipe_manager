import 'package:flutter/material.dart';
import 'package:recipe_management/views/menu_view.dart';

class IngredientsView extends StatelessWidget {
  const IngredientsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: MenuDrawer(),
      appBar: AppBar(
        title: Text('Recipe Manager'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text('Ingredients View'),
      ),
    );
  }
}
