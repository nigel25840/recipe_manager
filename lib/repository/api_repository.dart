import 'dart:convert';

import 'package:conduit_codable/conduit_codable.dart';
import 'package:dartz/dartz.dart';
import 'package:recipe_management/exceptions/exceptions.dart';
import 'package:recipe_management/globals.dart' as globals;
import 'package:http/http.dart' show Client, Response;

typedef ModelCreator<T extends Coding> = T Function();

class ApiRepository<T extends Coding> {
  ModelCreator<T> creator;
  ApiRepository(this.creator);
  Client client = Client();

  final String apiBaseUrl = globals.apiBaseUrl;

  final Map<String, String> headers = {"Content-Type": "application/json"};

  Future<Either<Exception, List<T>>> fetchAll() async {
    String urlString =
        'https://api.spoonacular.com/recipes/findByIngredients?ingredients=eggs,+walnuts,+sugar,+cranberries&number=5&apiKey=9cdd0725f3a1411fae547fba718cce83';
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
