class DataBaseModel {
  String collection;
  String documentID;
  Map<String, dynamic> data;
  DataBaseModel(this.collection);
}
class ClauseModel {
  String attribute;
  String operator;
  dynamic value;
  ClauseModel(this.attribute, this.operator, this.value);
}
class OrderByModel {
  String fieldPath;
  String direction;
  OrderByModel(this.fieldPath, this.direction);
}
class OptionsModel {
  DataBaseModel parent;
  List<ClauseModel> where;
  OrderByModel orderBy;
  List<dynamic> startAfter;
  int limit;
}