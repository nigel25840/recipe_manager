import 'dart:io';
import 'dart:convert';
import 'package:conduit_codable/conduit_codable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recipe_management/model/recipe_model.dart';

// tests that a Recipe model can be deserialized from json response
// json data is in same directory: recipe_json.json

void main() async {
  late Recipe recipe;
  String filePath = '${Directory.current.path}/test/recipe_json.json';
  final jsonFile = File(filePath);
  final jsonString = await jsonFile.readAsStringSync();
  final List<dynamic> jsonDataList = json.decode(jsonString);

  if(jsonDataList.isNotEmpty) {
    final Map<String, dynamic> jsonDataMap = jsonDataList.first;
    final archive = KeyedArchive.unarchive(jsonDataMap);
    recipe = Recipe()..decode(archive);f
  }

  test('Recipe data model is deserialized from json', () async {
    expect(recipe.ingredients.isNotEmpty, true);
    expect(recipe.title!.isNotEmpty, true);
    expect(recipe.likes != null, true);
    expect(recipe.id != null, true);
    expect(recipe.image!.isNotEmpty, true);
    expect(recipe.ingredients.first.name!.isNotEmpty, true);
    expect(recipe.ingredients.first.aisle!.isNotEmpty, true);
    expect(recipe.ingredients.first.image!.isNotEmpty, true);
    expect(recipe.ingredients.first.amount != null, true);
  });
}