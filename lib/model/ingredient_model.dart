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
  void encode(KeyedArchive object) {
    object.encode('id', id);
    object.encode('aisle', aisle);
    object.encode('image', image);
    object.encode('name', name);
    object.encode('amount', amount);
    object.encode('onHand', onHand);

    print(object.toString());
  }

  // override the == operator and hashcode so that a set can be used to remove duplicate entries
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Ingredient &&
        runtimeType == other.runtimeType &&
        name == other.name;
  }

  @override
  int get hashCode => name.hashCode ?? 0;
}
