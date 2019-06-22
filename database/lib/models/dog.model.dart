import 'package:sqflite/sqflite.dart';
import "package:database/database/database.dart"; 

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({this.id, this.name, this.age});

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name, "age": age};
  }

  
  
}
