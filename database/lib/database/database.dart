import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import "../models/dog.model.dart";

void main() async {
  final Future<Database> database = openDatabase(
    join(await getDatabasesPath(), 'doggie_database.db'),
    onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
      );
    },
    version: 1,
  );

  Future<void> insertDog(Dog dog) async {
    final Database db = await database;

    await db.insert("dogs", dog.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  final fido = Dog(
    id: 0,
    name: 'Fido',
    age: 35,
  );

  await insertDog(fido);

  Future<void> updateDog(Dog dog) async {
    final Database db = await database;

    await db.update('dogs', dog.toMap(), where: "id = ? ", whereArgs: [dog.id]);
  }

  await updateDog(Dog(
    id: 0,
    name: 'Fido',
    age: 42,
  ));

  Future<List<Dog>> dogs() async {
  // Get a reference to the database.
  final Database db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('dogs');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return Dog(
      id: maps[i]['id'],
      name: maps[i]['name'],
      age: maps[i]['age'],
    );
  });
}
}
