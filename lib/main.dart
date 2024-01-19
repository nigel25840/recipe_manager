import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_management/dependencies.dart';
import 'package:recipe_management/view_model/pantry_provider.dart';
import 'package:recipe_management/view_model/recipe_provider.dart';
import 'views/main_recipes_view.dart';

void main() async {
  await initiateDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => RecipeProvider(
                  errorCallback: (String message) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(message),
                    ));
                  },
                )..initializeProvider()),
        ChangeNotifierProvider(create: (_) => PantryProvider()..initializeProvider())
        // Add more providers as needed
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MainRecipesView(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
