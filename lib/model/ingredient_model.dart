import 'package:conduit_codable/conduit_codable.dart';

// for the purpose of this project, duplicates are not allowed by the provider
// thus, the name of the ingredient can be used as a unique id. For real world
// apps, this would not be the case and an actual unique id would be preferred

class Ingredient extends Coding {
  String? aisle;
  String? image;
  String? name;
  double? amount;
  bool onHand = false;

  Ingredient({
    this.aisle,
    this.image,
    this.name,
    this.amount,
    this.onHand = false,
  });

  Ingredient copyWith({
    String? aisle,
    String? image,
    String? item,
    double? amount,
    bool? available,
  }) {
    return Ingredient(
      aisle: aisle ?? this.aisle,
      image: image ?? this.image,
      name: item ?? this.name,
      amount: amount ?? this.amount,
      onHand: available ?? this.onHand,
    );
  }

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    aisle = object.decode('aisle');
    image = object.decode('image');
    name = object.decode('name');
    amount = object.decode('amount');
    onHand = false;
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('aisle', aisle);
    object.encode('image', image);
    object.encode('name', name);
    object.encode('amount', amount);
    object.encode('onHand', onHand);
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
