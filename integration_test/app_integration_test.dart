import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:recipe_management/main.dart' as app;
import 'package:recipe_management/utils/app_constants.dart';
import 'package:recipe_management/views/widgets/grocery_item_tile.dart';
import 'package:recipe_management/views/widgets/recipe_tile.dart';

/// this integration test represents the flow of the entire application.
/// In a larger application, separate integration tests would be added for
/// different workflows. This would be achieved by navigating to the entry
/// point of the workflow being integration tested.
///
/// Delays have been added to this integration test to better demonstrate the app flow

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  String ingredient1 = 'garlic';
  String ingredient2 = 'shrimp';
  String ingredient3 = 'tomatoes';
  String ingredient4 = 'butter';
  String ingredient5 = 'anchovies';
  
  const int delay = 500;

  testWidgets('Test app flow', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    app.main(); // This will execute the main function in your app

    await tester.pumpAndSettle();

    expect(find.text(AppConstants.kAppTitle), findsOneWidget);
    // Add more test expectations and interactions as needed.
    await tester.pump(const Duration(seconds: 2));

    final menuDrawerFinder = find.byIcon(Icons.menu);
    expect(menuDrawerFinder, findsOneWidget);
    await tester.tap(menuDrawerFinder);
    await tester.pump(const Duration(milliseconds: delay));
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

    await tester.pump(const Duration(milliseconds: delay));

    // add some ingredients to the pantry list
    await tester.enterText(ingredientEntryText, ingredient1);
    await tester.pump(const Duration(milliseconds: delay));
    await tester.tap(addIngredientButton);
    await tester.pump(const Duration(milliseconds: delay));

    await tester.enterText(ingredientEntryText, ingredient2);
    await tester.pump(const Duration(milliseconds: delay));
    await tester.tap(addIngredientButton);
    await tester.pump(const Duration(milliseconds: delay));

    await tester.enterText(ingredientEntryText, ingredient3);
    await tester.pump(const Duration(milliseconds: delay));
    await tester.tap(addIngredientButton);
    await tester.pump(const Duration(milliseconds: delay));

    await tester.enterText(ingredientEntryText, ingredient4);
    await tester.pump(const Duration(milliseconds: delay));
    await tester.tap(addIngredientButton);
    await tester.pump(const Duration(milliseconds: delay));

    await tester.enterText(ingredientEntryText, ingredient5);
    await tester.pump(const Duration(milliseconds: delay));
    await tester.tap(addIngredientButton);
    await tester.pump(const Duration(milliseconds: delay));

    // check that the ingredients are found in the list
    final ingredientFinder1 = find.text(ingredient1);
    expect(ingredientFinder1, findsOneWidget);

    await tester.pump(const Duration(milliseconds: delay));

    // locate, verify and tap the check boxes in the first 3 items
    final Finder firstIngredient = find.byKey(Key('${AppConstants.keyIngredientCheckbox}0'));
    expect(firstIngredient, findsOneWidget);

    final Finder secondIngredient = find.byKey(Key('${AppConstants.keyIngredientCheckbox}1'));
    expect(secondIngredient, findsOneWidget);

    final Finder thirdIngredient = find.byKey(Key('${AppConstants.keyIngredientCheckbox}2'));
    expect(thirdIngredient, findsOneWidget);

    await tester.tap(firstIngredient);
    await tester.pump(const Duration(milliseconds: delay));

    await tester.tap(secondIngredient);
    await tester.pump(const Duration(milliseconds: delay));

    await tester.tap(thirdIngredient);
    await tester.pump(const Duration(milliseconds: delay));

    // locate the floating action button (search button) and tap it
    final Finder searchButtonFinder = find.byKey(AppConstants.keySearchRecipesButton);
    expect(searchButtonFinder, findsOneWidget);

    await tester.tap(searchButtonFinder);
    await tester.pumpAndSettle();

    // locate and tap the fist item in the recipes list
    final Finder recipeTileFinder = find.byType(RecipeTile).first;
    expect(recipeTileFinder, findsOneWidget);

    // NOTE: a bug exists that is preventing the tap event unless the actual text is tapped
    // with more time, this would be addressed: following is a workaround
    final Finder textWidgetFinder = find.descendant(
      of: recipeTileFinder,
      matching: find.byType(Text),
    );
    expect(textWidgetFinder, findsWidgets);

    await tester.pump(const Duration(milliseconds: delay));
    await tester.tap(textWidgetFinder.first);

    await tester.pumpAndSettle();
    await tester.pump(const Duration(milliseconds: delay));

    final Finder groceryTileFinder = find.byType(GroceryItemTile);
    expect(groceryTileFinder, findsWidgets);

    // long delay before closing the app
    await tester.pump(const Duration(seconds: 5));
  });
}
