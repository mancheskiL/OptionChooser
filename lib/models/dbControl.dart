import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:option_chooser/models/item.dart';

class DbControl extends ChangeNotifier {
  // comment out because I don't need a Singleton right now I think
  // DbControl._();
  // static final DbControl db = DbControl._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      print('DB action performed');
      return _database;
    }

    print('initializing database');
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'options_app.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db
          .execute("CREATE TABLE options(id INTEGER PRIMARY KEY, title TEXT)");
    });
  }

  Future<List<Item>> retrieve() async {
    final Database db = await database;

    var results = await db.query('options');
    List<Item> tempList = [];
    for (var result in results) {
      tempList.add(Item.fromMap(result));
    }
    return tempList;
  }

  Future<void> saveToDB(String title) async {
    final Database db = await database;

    var temp = await retrieve();
    var id = temp.length;

    var item = Item(
      title,
      id,
    );

    await db.insert(
      'options',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    notifyListeners();
  }

  Future<void> update() async {}

  Future<void> delete() async {}
}
