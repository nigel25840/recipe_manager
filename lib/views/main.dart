import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_management/viewmodel/recipe_provider.dart';

void main() {
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
      home: MainView(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainView extends StatelessWidget {
  late final String title;
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
        body: Center(
          child: Text(
            'Test Harness App',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
