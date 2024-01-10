import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'list_item.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE items(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, description TEXT NOT NULL, isDone INTEGER NOT NULL)",
        );
      },
      version: 1,
    );
  }
}
