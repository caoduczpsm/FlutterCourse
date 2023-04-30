// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import '../model/Status.dart';
import '../ultilities/Constant.dart';
import 'AppSQLHelper.dart';

class StatusSQLHelper {

  static Future<int?> createStatus(Status status) async {
    final db = await AppSQLHelper.db();

    if(await checkStatusAlreadyByNameAndUserId(status.name!, status.userId!)){
      return  await db.insert(Constant.KEY_TABLE_STATUS, status.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      return null;
    }

  }

  static Future<Status?> getStatusByNameAndUserID(String name, String userId) async {
    final db = await AppSQLHelper.db();
    final List<Map<String, dynamic>> maps = await db.query(Constant.KEY_TABLE_STATUS,
        where: '${Constant.KEY_STATUS_NAME} = ? AND ${Constant.KEY_STATUS_USER_ID} = ?', whereArgs: [name, userId]);


    if (maps.isNotEmpty) {
      return Status.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<Status> getStatusById(int id) async {
    final db = await AppSQLHelper.db();

    final maps = await db.query(Constant.KEY_TABLE_STATUS, where: '${Constant.KEY_STATUS_ID} = ?', whereArgs: [id]);
    return Status.fromMap(maps.first);

  }

  static Future<Status?> getStatusByName(String name) async {
    final db = await AppSQLHelper.db();
    final List<Map<String, dynamic>> maps = await db.query(Constant.KEY_TABLE_STATUS,
        where: '${Constant.KEY_STATUS_NAME} = ?', whereArgs: [name]);


    if (maps.isNotEmpty) {
      return Status.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getAllStatuses(int userId) async {
    final db = await AppSQLHelper.db();

    return db.query(Constant.KEY_TABLE_STATUS, orderBy: "id", where: '${Constant.KEY_STATUS_USER_ID} = ?', whereArgs: [userId]);
  }

  static Future<int> updateStatus(Status status) async {
    final db = await AppSQLHelper.db();

    final result = await db
        .update(Constant.KEY_TABLE_STATUS, status.toMap(), where: "id = ?", whereArgs: [status.id]);

    return result;
  }

  static Future<void> deleteStatus(int id) async {
    final db = await AppSQLHelper.db();

    try {
      await db.delete(Constant.KEY_TABLE_STATUS, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item $err");
    }
  }

  static Future<bool> checkStatusAlreadyByNameAndUserId(String name, int userId) async {
    final db = await AppSQLHelper.db();
    final List<Map<String, dynamic>> maps = await db
        .query(Constant.KEY_TABLE_STATUS, where: '${Constant.KEY_STATUS_NAME} = ? AND ${Constant.KEY_STATUS_USER_ID} = ?',
        whereArgs: [name, userId]);

    if (maps.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

}