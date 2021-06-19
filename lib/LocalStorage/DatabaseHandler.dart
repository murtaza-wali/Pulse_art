import 'package:art/Model/LoginUser.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHandler {

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'art.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT,user_id INTEGER NOT NULL, name TEXT NOT NULL,status INTEGER NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertUser(user users) async {
    final Database db = await initializeDB();
    int result = await db.insert('users', users.toMap());
    return result;
  }

  Future<List<user>> retrieveUsers() async {
    final Database db = await initializeDB();
    final List<Map<String, Object>> queryResult = await db.query('users');
    print('query : ${queryResult.map((e) => user.fromMap(e)).toList()}');
    return queryResult.map((e) => user.fromMap(e)).toList();
  }

  Future<void> deleteUser(int id) async {
    final db = await initializeDB();
    await db.delete(
      'users',
      where: "id = ?",
      whereArgs: [id],
    );
  }

}
