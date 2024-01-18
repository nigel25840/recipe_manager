import 'package:localstorage/localstorage.dart';

class LocalRepository {
  late LocalStorage storage;

  Future<List<String>> fetchIngredients() {
    return Future.value([]);
  }

  Future<void> initializeDataStore() async {
    if (!(await storage.ready)) {
      storage = LocalStorage('recipe_app.json');
    }
  }

  Future<void> addItem({required String itemId, required dynamic item}) async {
    await initializeDataStore();
    if (storage.getItem(itemId) == null) {
      storage.setItem(itemId, item);
    }
  }

  Future<void> removeItem({required String itemId}) async {
    await initializeDataStore();
    if (storage.getItem(itemId) == null) {
      storage.deleteItem(itemId);
    }
  }
}
