import 'package:buoi_4_bai_1/buoi10/ExtraTask/model/account.dart';
import 'package:sqflite/sqflite.dart';

class SQLHelper {

  static Future<void> createItemTable(Database database) async {
    await database.execute('''CREATE TABLE accounts( 
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, 
        userName TEXT, 
        password TEXT,
        email TEXT,
        gender int)''');
  }

  static Future<Database> db() async {
    return openDatabase(
      'account.db',
      version: 1,
      onCreate: (Database database, int version) async {
        await createItemTable(database);
      },
    );
  }

  static Future<int?> createAccount(Account account) async {
    final db = await SQLHelper.db();
    var isAvailable = await isAvailableUsername(account.userName!);
    if(isAvailable) {
      final id = await db.insert('accounts', account.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      return id;
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getAccount(String userName) async {
    final db = await SQLHelper.db();
    String sql = "accounts WHERE userName = '$userName'";
    var result = await db.query(sql);
    if (result.isNotEmpty) {
      var row = result.first;
      return row;
    } else {
      return null; // or throw an exception
    }
  }

  static Future<bool> isAvailableUsername(String userName) async {
    final db = await SQLHelper.db();
    String sql = "accounts WHERE userName = '$userName'";
    var result = await db.query(sql);
    if(result.isNotEmpty){
      return false;
    } else {
      return true;
    }
  }

  // static Future<List<Map<String, dynamic>>> getItems() async {
  //   final db = await SQLHelper.db();
  //
  //   return db.query('items', orderBy: "id");
  // }

  // static Future<int> updateItem(Item item) async {
  //   final db = await SQLHelper.db();
  //
  //   final result = await db
  //   .update('items', item.toMap(), where: "id = ?", whereArgs: [item.id]);
  //
  //   return result;
  // }
  //
  // static Future<void> deleteItem(int id) async {
  //   final db = await SQLHelper.db();
  //
  //   try {
  //     await db.delete("items", where: "id = ?", whereArgs: [id]);
  //   } catch (err) {
  //     debugPrint("Something went wrong when deleting an item $err");
  //   }
  // }
}