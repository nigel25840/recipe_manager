import 'dart:convert';
import 'package:conduit_codable/conduit_codable.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_management/exceptions/exceptions.dart';
import 'package:http/http.dart' show Client, Response;
import 'package:recipe_management/utils/app_constants.dart';

/// The "ApiRepository" class is a generic repository for making API requests and handling responses
/// with models that extend the "Coding" interface. The generic type [T] represents the model type
/// that the repository will work with. The "ModelCreator" typedef is used to provide a way to create
/// instances of the generic model [T].
///
/// Generics are employed to make the repository reusable for various data models,
/// promoting code reusability. By allowing different model types to be used,
/// this repository can interact with diverse API endpoints that return different types of data objects.
///
/// The "fetchAll" method fetches a json response from the Spoonacular API based on provided search terms.
/// The decoded response is then transformed to a list of model instances using the provided "ModelCreator".
/// Making this class generic ensures that it can be used with different model types that implement "Coding"


typedef ModelCreator<T extends Coding> = T Function();

class ApiRepository<T extends Coding> {
  ModelCreator<T> creator;
  ApiRepository(this.creator);
  Client client = Client();
  final Map<String, String> headers = {"Content-Type": "application/json"};

  Future<Either<Exception, List<T>>> fetchAll({List<String>? searchTerms}) async {

    String baseUrl = 'https://api.spoonacular.com/recipes/findByIngredients?ingredients=';
    String urlParams = searchTerms != null ? searchTerms.join(',+') : '';
    String apiKey = AppConstants.apiKey;
    int numberOfResults = 10;
    String urlString = '${baseUrl}${urlParams}&number=${numberOfResults}&apiKey=${apiKey}';
    Uri url = Uri.parse(urlString);

    Response response = await client.get(url, headers: headers);
    if (response.statusCode == 200) {
      final decodedMap = json.decode(response.body);
      List<T> items = decodedMap.map<T>((e) {
        final T model = creator();
        model.decode(KeyedArchive.unarchive(e));
        return model;
      }).toList();
      return Future.value(Right(items));
    } else {
      return Left(ServerFailure(
        code: response.statusCode,
        message: _getErrorDetail(response),
      ));
    }
  }

  String _getErrorDetail(Response response) {
    String msg = 'Cannot get a response from the server';
    return msg + json.decode(response.body)['message'];
  }
}
