import 'package:flutter/cupertino.dart';
import 'package:option_chooser/models/records.dart';

class ListModel extends ChangeNotifier {
  List<Item> list = [];
  RecordsModel records = RecordsModel();

  void add(String title) {
    var newId = list.length;
    var newItem = new Item(title, newId);
    list.add(newItem);
    notifyListeners();
  }

  void setFinished(int index) {
    var workingItem = list[index];

    workingItem.complete = true;
    workingItem.finishedDate = DateTime.now();
    records.add(workingItem);

    // at this point, seems safe to say any change to this class, must call notifyListener
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
}
