import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void createDatabase() {
  getDatabasesPath().then((dbPath) {
    final String path = join(dbPath, 'muralha.db');
    openDatabase(path, onCreate: (db, version) {
      db.execute('CREATE TABLE user('
          'id INTEGER PRIMARY KEY, '
          'name TEXT,'
          'password BLOB)');
    }, version: 1);
  });
}
