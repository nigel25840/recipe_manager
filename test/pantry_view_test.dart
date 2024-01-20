import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:recipe_management/repository/app_facade.dart';
import 'package:recipe_management/utils/app_constants.dart';
import 'package:recipe_management/view_model/pantry_provider.dart';
import 'package:recipe_management/views/pantry_view.dart';

import 'shared_mocks.dart';

void main() async {
  setUp(() {
    // Register the MockAppFacade only if it's not registered
    if (!GetIt.instance.isRegistered<IAppFacade>()) {
      GetIt.instance.registerLazySingleton<IAppFacade>(() => MockAppFacade.new());
    }
  });

  tearDown(() {
    GetIt.instance.unregister<IAppFacade>();
  });

  Widget widgetInTest() {
    return ChangeNotifierProvider(
      create: (_) => PantryProvider()..initializeProvider(),
      child: MaterialApp(
        home: PantryView(),
      ),
    );
  }

  testWidgets('UI elements in place', (tester) async {
    await tester.pumpWidget(widgetInTest());
    await tester.pumpAndSettle();
    expect(find.byKey(AppConstants.keyAddIngredientText), findsOneWidget);
    expect(find.byKey(AppConstants.keyAddButton), findsOneWidget);
    expect(find.byKey(AppConstants.keySearchRecipesButton), findsOneWidget);
  });

  testWidgets('Tests pantry view', (tester) async {
    await tester.pumpWidget(widgetInTest());
    await tester.pumpAndSettle();

    Finder tileFinder = find.byType(Dismissible);
    expect(tileFinder, findsAtLeast(2));
    expect(find.text('ingredient1'), findsOneWidget);
    expect(find.text('ingredient2'), findsOneWidget);
  });
}
