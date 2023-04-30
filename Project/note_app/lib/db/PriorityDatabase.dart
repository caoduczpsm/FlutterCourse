// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:note_app/model/Priority.dart';
import 'package:sqflite/sqflite.dart';
import '../ultilities/Constant.dart';
import 'AppSQLHelper.dart';

class PrioritySQLHelper {

  static Future<int?> createPriority(Priority priority) async {
    final db = await AppSQLHelper.db();

    if(await checkPriorityAlreadyByNameAndUserId(priority.name!, priority.userId!)){
      return  await db.insert(Constant.KEY_TABLE_PRIORITY, priority.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      return null;
    }

  }

  static Future<Priority?> getPriorityByNameAndUserID(String name, String userId) async {
    final db = await AppSQLHelper.db();
    final List<Map<String, dynamic>> maps = await db.query(Constant.KEY_TABLE_PRIORITY,
        where: '${Constant.KEY_PRIORITY_NAME} = ? AND ${Constant.KEY_PRIORITY_USER_ID} = ?', whereArgs: [name, userId]);


    if (maps.isNotEmpty) {
      return Priority.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<Priority> getPriorityById(int id) async {
    final db = await AppSQLHelper.db();

    final maps = await db.query(Constant.KEY_TABLE_PRIORITY, where: '${Constant.KEY_PRIORITY_ID} = ?', whereArgs: [id]);
    return Priority.fromMap(maps.first);
  }

  static Future<Priority?> getPriorityByName(String name) async {
    final db = await AppSQLHelper.db();
    final List<Map<String, dynamic>> maps = await db.query(Constant.KEY_TABLE_PRIORITY,
        where: '${Constant.KEY_PRIORITY_NAME} = ?', whereArgs: [name]);


    if (maps.isNotEmpty) {
      return Priority.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getAllPriorities(int userId) async {
    final db = await AppSQLHelper.db();

    return db.query(Constant.KEY_TABLE_PRIORITY, orderBy: "id", where: '${Constant.KEY_PRIORITY_USER_ID} = ?', whereArgs: [userId]);
  }

  static Future<int> updatePriority(Priority priority) async {
    final db = await AppSQLHelper.db();

    final result = await db
        .update(Constant.KEY_TABLE_PRIORITY, priority.toMap(), where: "id = ?", whereArgs: [priority.id]);

    return result;
  }

  static Future<void> deletePriority(int id) async {
    final db = await AppSQLHelper.db();

    try {
      await db.delete(Constant.KEY_TABLE_PRIORITY, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item $err");
    }
  }

  static Future<bool> checkPriorityAlreadyByNameAndUserId(String name, int userId) async {
    final db = await AppSQLHelper.db();
    final List<Map<String, dynamic>> maps = await db
        .query(Constant.KEY_TABLE_PRIORITY, where: '${Constant.KEY_PRIORITY_NAME} = ? AND ${Constant.KEY_PRIORITY_USER_ID} = ?',
        whereArgs: [name, userId]);

    if (maps.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

}