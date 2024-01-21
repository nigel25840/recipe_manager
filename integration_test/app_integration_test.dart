import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:recipe_management/main.dart' as app;
import 'package:recipe_management/utils/app_constants.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  WidgetTester widgetTester;

  String ingredient1 = 'garlic';
  String ingredient2 = 'shrimp';
  String ingredient3 = 'tomatoes';
  String ingredient4 = 'butter';
  String ingredient5 = 'anchovies';

  testWidgets('Test app flow', (WidgetTester tester) async {
    widgetTester = tester;
    // Build our app and trigger a frame.
    app.main(); // This will execute the main function in your app

    await tester.pumpAndSettle();

    expect(find.text(AppConstants.kAppTitle), findsOneWidget);
    // Add more test expectations and interactions as needed.
    await tester.pump(const Duration(seconds: 2));

    final menuDrawerFinder = find.byIcon(Icons.menu);
    expect(menuDrawerFinder, findsOneWidget);
    await tester.tap(menuDrawerFinder);
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // Find the 'Pantry' item in the drawer.
    final pantryItemFinder = find.text('Pantry');

    // Verify that the 'Pantry' item is found.
    expect(pantryItemFinder, findsOneWidget);

    // Tap the 'Pantry' item.
    await tester.tap(pantryItemFinder);
    await tester.pump(const Duration(seconds: 2));

    // when the pantry view opens, add some ingredients
    final ingredientEntryText = find.byKey(AppConstants.keyAddIngredientText);
    final addIngredientButton = find.byKey(AppConstants.keyAddButton);
    expect(addIngredientButton, findsOneWidget);
    expect(ingredientEntryText, findsOneWidget);

    await tester.pump(const Duration(seconds: 1));

    await tester.enterText(ingredientEntryText, ingredient1);
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(addIngredientButton);
    await tester.pump(const Duration(seconds: 1));

    await tester.enterText(ingredientEntryText, ingredient2);
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(addIngredientButton);
    await tester.pump(const Duration(seconds: 1));

    await tester.enterText(ingredientEntryText, ingredient3);
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(addIngredientButton);
    await tester.pump(const Duration(seconds: 1));

    await tester.enterText(ingredientEntryText, ingredient4);
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(addIngredientButton);
    await tester.pump(const Duration(seconds: 1));

    final ingredientFinder1 = find.text(ingredient1);
    expect(ingredientFinder1, findsOneWidget);

    await tester.pump(const Duration(seconds: 1));

    // tap the check the first ingredient
    await tester.tap(ingredientFinder1);
    await tester.pump(const Duration(seconds: 5));
  });
}
