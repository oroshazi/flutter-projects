import 'package:flutter/foundation.dart';
import '../repository/database_creator.dart';

class Nameday {
  int id;
  int day;
  int month;
  int isFavorite;
  String name;

  Nameday(
      {@required this.id,
      @required this.isFavorite,
      @required this.day,
      @required this.month,
      @required this.name});

  Nameday.fromJSON(Map<String, dynamic> json) {
    this.id = json[DatabaseCreator.id];
    this.name = json[DatabaseCreator.name];
    this.day = json[DatabaseCreator.day];
    this.month = json[DatabaseCreator.month];
    this.isFavorite = json[DatabaseCreator.isFavorite];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "day": this.day,
      "month": this.month,
      "isFavorite": this.isFavorite,
      "name": this.name,
    };
  }

  printOut() {
    print('id: ${this.id}' +
        " day: ${this.day}" +
        " month: ${this.month}" +
        " name: ${this.name}");
  }
}
