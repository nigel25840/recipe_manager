import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:recipe_management/repository/app_facade.dart';
import 'package:recipe_management/utils/app_constants.dart';
import 'package:recipe_management/view_model/recipe_provider.dart';
import 'package:recipe_management/views/main_recipes_view.dart';

import 'shared_mocks.dart';

void main() async {
  setUp(() {
    if(!GetIt.instance.isRegistered<IAppFacade>()) {
      GetIt.instance.registerLazySingleton<IAppFacade>(() => MockAppFacade.new());
    }
  });

  tearDown(() {
    GetIt.instance.unregister<IAppFacade>();
  });

  Widget widgetInTest() {
    return ChangeNotifierProvider(
      create: (_) => RecipeProvider()..initializeProvider(),
      child: MaterialApp(
        home: MainRecipesView(),
      ),
    );
  }

  testWidgets('Tests empty state of recipe view', (tester) async {
    await tester.pumpWidget(widgetInTest());
    await tester.pumpAndSettle();
    Finder emptyResultsFinder = find.byKey(AppConstants.keyNoRecipesView);
    expect(emptyResultsFinder, findsOneWidget);
  });
}
