import 'package:flutter/material.dart';
import 'package:recipe_management/dependencies.dart';
import 'views/main_recipes_view.dart';

void main() async {
  await initiateDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainRecipesView(title: 'Flutter Demo Home Page'),
    );
  }
}