import 'package:flutter/foundation.dart';
import '../repository/database_creator.dart';

class Nameday {
  int year;
  int id;
  int day;
  int month;
  int isFavorite;
  String name;

  Nameday({
    @required this.id,
    @required this.isFavorite,
    @required this.day,
    @required this.month,
    this.year = 2019,
    @required this.name,
  });

  set setYear(int newYear) {
    this.year = newYear;
  }

  Nameday.fromJSON(Map<String, dynamic> json) {
    this.id = json[DatabaseCreator.id];
    this.name = json[DatabaseCreator.name];
    this.day = json[DatabaseCreator.day];
    this.month = json[DatabaseCreator.month];
    this.year = json[this.year];
    this.isFavorite = json[DatabaseCreator.isFavorite];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "day": this.day,
      "month": this.month,
      "year": this.year,
      "isFavorite": this.isFavorite,
      "name": this.name,
    };
  }

  printOut() {
    print('id: ${this.id}' +
        " day: ${this.day}" +
        " month: ${this.month}" +
        " year: ${this.year}" +
        " name: ${this.name}");
  }
}
