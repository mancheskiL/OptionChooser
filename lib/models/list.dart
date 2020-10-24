import 'package:flutter/cupertino.dart';
import 'package:option_chooser/models/records.dart';
import 'package:option_chooser/models/dbControl.dart';
import 'package:option_chooser/models/item.dart';

class ListModel extends ChangeNotifier {
  // TODO: save list to internal DB
  List<Item> list = [];
  RecordsModel records = RecordsModel();

  void add(String title) {
    var newId = list.length;
    var newItem = new Item(title, newId);
    list.add(newItem);

    DbControl.db.saveToDB(newItem);

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
    // set all 'item's to complete=false and finishedDate=null

    // must notify List route to uncheck boxes, but we don't want to rebuild records
    // actually i don't think this will be a problem, reseting list items will not
    // change records list, so even though that route technically rebuilds
    // there shouldn't be visible (or logical for that matter) changes
    for (var item in list) {
      item.complete = false;
      item.finishedDate = null;
    }
    notifyListeners();
  }

  void loadDB() async {
    // query DB for saved options
    // context.read a model we will make a provide
    List<Map<String, dynamic>> results = await DbControl.db.retrieve();
    print(results);
    for (var map in results) {
      list.add(Item(map['title'], map['it']));
    }
    notifyListeners();
    // ideally this is called once as startup, then we will handle
    // UI based changes within this class
    // ATM, simpler than doing huge DB class changes since I already
    // have this system built out
    // (although, DB extended as changenotifier probably better overall)
  }
}
