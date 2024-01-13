import 'package:conduit_codable/conduit_codable.dart';

class Ingredient extends Coding {
  int? id;
  String? aisle;
  String? image;
  String? name;
  double? amount;
  bool onHand = false;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    id = object.decode('id');
    aisle = object.decode('aisle');
    image = object.decode('image');
    name = object.decode('name');
    amount = object.decode('amount');
    onHand = false;
  }

  @override
  void encode(KeyedArchive object) {}
}