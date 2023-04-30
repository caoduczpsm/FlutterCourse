// ignore: depend_on_referenced_packages
import 'package:flutter/cupertino.dart';
import 'package:note_app/db/AppSQLHelper.dart';
import 'package:note_app/model/Categories.dart';
import 'package:sqflite/sqflite.dart';
import '../ultilities/Constant.dart';

class CategorySQLHelper {

  static Future<List<Map<String, dynamic>>> getAllCategories(int userId) async {
    final db = await AppSQLHelper.db();

    return db.query(Constant.KEY_TABLE_CATEGORY, orderBy: "id", where: '${Constant.KEY_CATEGORY_USER_ID} = ?', whereArgs: [userId]);
  }

  static Future<int> updateCategory(Categories categories) async {
    final db = await AppSQLHelper.db();

    final result = await db
        .update(Constant.KEY_TABLE_CATEGORY, categories.toMap(), where: "id = ?", whereArgs: [categories.id]);

    return result;
  }

  static Future<void> deleteCategory(int id) async {
    final db = await AppSQLHelper.db();

    try {
      await db.delete(Constant.KEY_TABLE_CATEGORY, where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item $err");
    }
  }

  static Future<int?> createCategory(Categories category) async {
    final db = await AppSQLHelper.db();

    if(await checkCategoryAvailableByNameAndUserID(category.name!, category.userId!)){
      return  await db.insert(Constant.KEY_TABLE_CATEGORY, category.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } else {
      return null;
    }

  }

  static Future<Categories?> getCategoryByName(String name) async {
    final db = await AppSQLHelper.db();
    final List<Map<String, dynamic>> maps = await db.query(Constant.KEY_TABLE_CATEGORY,
        where: '${Constant.KEY_CATEGORY_NAME} = ?', whereArgs: [name]);


    if (maps.isNotEmpty) {
      return Categories.fromMap(maps.first);
    } else {
      return null;
    }
  }

  static Future<Categories> getCategoryById(int id) async {
    final db = await AppSQLHelper.db();

    final maps = await db.query(Constant.KEY_TABLE_CATEGORY, where: '${Constant.KEY_CATEGORY_ID} = ?', whereArgs: [id]);

    return Categories.fromMap(maps.first);

  }

  static Future<bool> checkCategoryAvailableByNameAndUserID(String name, int userId) async {
    final db = await AppSQLHelper.db();
    final List<Map<String, dynamic>> maps = await db
        .query(Constant.KEY_TABLE_CATEGORY, where: '${Constant.KEY_CATEGORY_NAME} = ? AND ${Constant.KEY_CATEGORY_USER_ID} = ?',
        whereArgs: [name, userId]);

    if (maps.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

}