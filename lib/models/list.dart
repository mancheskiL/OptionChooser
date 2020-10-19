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

  void resetItems() {
    // TODO: set all 'item's to complete=false and finishedDate=null
    // every day (i.e. when midnight passes)
    // super duper no idea how to do this yet

    // maybe...save the app launch date and upon next app launch, compare dates
    // if date are not equal, then it's a new day and we reset

    // must notify List route to uncheck boxes, but we don't want to rebuild records
    // actually i don't think this will be a problem, reseting list items will not
    // change records list, so even though that route technically rebuilds
    // there shouldn't be visible (or logical for that matter) changes
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
