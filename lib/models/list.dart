import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ListModel extends ChangeNotifier {
  List<Item> list;

  void add(String title) {
    var newId = list.length;
    var newItem = new Item(title, newId);
    list.add(newItem);
    notifyListeners();
  }
}

// @immutable
class Item {
  String title;
  int id;
  bool complete;
  // Date finished;

  Item(String title, int id) {
    this.title = title;
    this.id = id;
    this.complete = false;
  }
}
