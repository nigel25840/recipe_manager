import 'package:conduit_codable/conduit_codable.dart';

class AiIngredient extends Coding {
  String? name;
  String? amount;

  @override
  void decode(KeyedArchive object) {
    name = object.decode('name');
    amount = object.decode('amount');
    super.decode(object);
  }

  @override
  void encode(KeyedArchive object) {}
}