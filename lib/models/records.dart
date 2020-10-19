import 'package:flutter/cupertino.dart';

class RecordsModel extends ChangeNotifier {
  List list = [];

  void add(item) {
    list.add(item);
    // notifyListeners();
  }
}
