import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbControl {
  Future<Database> database;

  DbControl() {
    main();
  }

  void main() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'options_app.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE options(id INTEGER PRIMARY KEY, title TEXT, complete INTEGER)");
      },
      version: 1,
    );
  }

  Future<List<Map<String, dynamic>>> retrieve() async {
    final Database db = await database;

    return await db.query('options');
  }

  Future<void> saveToDB(var entry) async {
    final Database db = await database;

    await db.insert(
      'options',
      entry.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
