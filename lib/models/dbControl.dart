import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:option_chooser/models/item.dart';

class DbControl extends ChangeNotifier {
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
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
      await db.execute(
          "CREATE TABLE records(id INTEGER PRIMARY KEY, title TEXT, date TEXT)");
    });
  }

  Future<List<Item>> retrieve() async {
    print('query action');
    final Database db = await database;

    var results = await db.query('options');
    List<Item> tempList = [];
    for (var result in results) {
      tempList.add(Item.fromMap(result));
    }
    return tempList;
  }

  Future<void> saveToDB(String title) async {
    print('save action');
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

  Future<List<Item>> retrieveRecords() async {
    print('getting records');
    final Database db = await database;

    var results = await db.query('records');
    List<Item> tempList = [];
    for (var result in results) {
      tempList.add(Item.fromMapRecords(result));
    }
    return tempList;
  }

  Future<void> addToRecords(Item item) async {
    // this needs to write to a 'records' table
    Item holder = item;
    holder.complete = true;
    holder.finishedDate = DateTime.now().toString();

    List<Item> findId = await retrieveRecords();
    int newId = findId.length;
    holder.id = newId;

    print('saving to records table');
    final Database db = await database;

    await db.insert(
      'records',
      holder.toMapRecords(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> update() async {
    print('update action');
  }

  Future<void> delete(int id) async {
    print('delete action');
    final Database db = await database;

    await db.delete(
      'options',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> clearAll() async {
    print('clear all action');
    final Database db = await database;

    await db.delete('options');
    await db.delete('records');

    notifyListeners();
  }
}
