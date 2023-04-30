// ignore: depend_on_referenced_packages
import 'package:note_app/db/AppSQLHelper.dart';
import 'package:sqflite/sqflite.dart';

import '../model/User.dart';
import '../ultilities/Constant.dart';

class UserSQLHelper {

  static Future<void> createUser(User user) async {
    final db = await AppSQLHelper.db();

    await db.insert(Constant.KEY_TABLE_USER, user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

  }

  static Future<User?> getUserByEmailPassword(String email, String password) async {
    final db = await AppSQLHelper.db();
    final List<Map<String, dynamic>> maps = await db.query(Constant.KEY_TABLE_USER,
        where: '${Constant.KEY_USER_EMAIL} = ? AND ${Constant.KEY_USER_PASSWORD} = ?', whereArgs: [email, password]);


    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<User?> getUserById(int id) async {
    final db = await AppSQLHelper.db();

    final maps = await db.query(Constant.KEY_TABLE_USER, where: '${Constant.KEY_USER_ID} = ?', whereArgs: [id]);

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }



  static Future<bool> checkEmailAlreadyUsed(String email) async {
    final db = await AppSQLHelper.db();
    final List<Map<String, dynamic>> maps = await db
        .query(Constant.KEY_TABLE_USER, where: '${Constant.KEY_USER_EMAIL} = ?', whereArgs: [email]);

    if (maps.isEmpty) {
      return true;
    } else {
      return false;
    }
  }



}