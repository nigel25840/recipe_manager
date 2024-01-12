class DataModel {
  String? name;
  String? type;
}

class PersonModel {
  String? fName;
  String? lName;
  String? nickname;
}

Future<List<T>> fetchModel<T>() async {
  List<T> resultList = [];
  if (T == DataModel) {
    resultList.add(DataModel() as T);
  } else if (T == PersonModel) {
    resultList.add(PersonModel() as T);
  }
  return resultList;
}
