import 'package:async/async.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbControl {
  DbControl() {
    // pass
  }

  void main() async {
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'options_app.db'),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE options(id INTEGER PRIMARY KEY, title TEXT, complete INTEGER, date TEXT");
      },
      version: 1,
    );
  }
}
