import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Database db;

class DatabaseCreator {
  static const nameDayTableHu = "nameDaysHu";
  static const id = "id";
  static const day = "day";
  static const month = "month";
  static const name = "name";
  static const isFavorite = "isFavorite";

  static void databaseLog(String functionName, String sql,
      [List<Map<String, dynamic>> selectQueryResult,
      int insertAndUpdateQueryResult,
      List<dynamic> params]) {
    print(functionName);
    print(sql);
    if (params != null) {
      print(params);
    }
    if (selectQueryResult != null) {
      print(selectQueryResult);
    } else if (insertAndUpdateQueryResult != null) {
      print(insertAndUpdateQueryResult);
    }
  }

  Future<void> createNamedaysHuTable(Database db) async {
    final sql = '''CREATE TABLE $nameDayTableHu (
      $id INTEGER PRIMARY KEY,
      $name TEXT,
      $day INTEGER,
      $month INTEGER,
      $isFavorite BIT NOT NULL
    )''';
    await db.execute(sql);

    final insertInitialData = '''INSERT INTO $nameDayTableHu (
      $id, 
      $name, 
      $day, 
      $month, 
      $isFavorite
    ) 
    VALUES 
      (1, "Pista", 20, 6, 1),
      (2, "Pista2", 21, 6, 0),
      (3, "Pista3", 22, 6, 0)
      ''';

    await db.execute(insertInitialData);
  }

  Future<String> getDatabasePath(String databaseName) async {
    final databasebPath = await getDatabasesPath();
    final path = join(databasebPath, databaseName);

    if (await Directory(dirname(path)).exists()) {
      // await deleteDatabase(path);
    } else {
      await Directory(dirname(path)).create(recursive: true);
    }
    return path;
  }

  Future<void> initDatabase() async {
    final path = await getDatabasePath(nameDayTableHu);
    db = await openDatabase(path, version: 1, onCreate: onCreate);
    print(db);
  }

  Future<void> onCreate(Database db, int version) async {
    await createNamedaysHuTable(db);
  }
}
