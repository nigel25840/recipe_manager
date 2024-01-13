import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_management/globals.dart';
import 'package:recipe_management/viewmodel/recipe_provider.dart';

class MainView extends StatelessWidget {
  late final String title;
  final TextStyle style = TextStyle(fontSize: 30);
  MainView({required String title});

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
        appBar: AppBar(
          title: Text('Recipe Manager'),
          backgroundColor: Colors.green,
        ),
        body: Container(
          child: Consumer<RecipeProvider>(
            builder: (_, RecipeProvider provider, __) {
              return provider.state == ViewState.idle
                  ? Text('My Recipes', style: style)
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
