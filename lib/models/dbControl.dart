import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:option_chooser/models/item.dart';

class DbControl {
  DbControl._();
  static final DbControl db = DbControl._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      print('DB action performed');
      return _database;
    }

    print('creating database');
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

  Future<List<Map<String, dynamic>>> retrieve() async {
    final Database db = await database;

    return await db.query('options');
  }

  Future<void> saveToDB(Item item) async {
    final Database db = await database;

    await db.insert(
      'options',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
