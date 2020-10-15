import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class ListModel extends ChangeNotifier {
  List<Item> list = [];

  void add(String title) {
    var newId = list.length;
    var newItem = new Item(title, newId);
    list.add(newItem);
    notifyListeners();
  }
}

class Item {
  String title;
  int id;
  bool complete;
  var finishedDate;

  Item(String title, int id) {
    this.title = title;
    this.id = id;
    this.complete = false;
  }

  void setFinished() {
    // TODO: use intl package to save a date time object into finishedDate
    complete = true;
  }
}
