import 'package:flutter/cupertino.dart';

class RecordsModel extends ChangeNotifier {
  // TODO: retrieve saved records data from internal DB
  // i think this is the way i want to do this for now anyways

  // TODO: also means we need to save records to DB either at app close
  // or whenever they are added, just don't want to create a lot of I/O stuff

  List list = [];

  void add(item) {
    list.add(item);
  }
}
