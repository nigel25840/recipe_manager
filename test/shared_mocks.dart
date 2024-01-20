import 'package:conduit_codable/conduit_codable.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:recipe_management/repository/app_facade.dart';

class MockAppFacade<T extends Coding> extends Mock implements IAppFacade {
  @override
  Future<Either<Exception, List<T>>>? fetchRecipes<T extends Coding>({List<String>? ingredients}) async {
    return Future.value(right([]));
  }
}