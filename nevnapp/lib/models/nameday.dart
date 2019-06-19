import 'package:flutter/foundation.dart';

class Nameday {
  final int id;
  final int day;
  final int month;
  final bool isFavorite;
  final String name;

  Nameday(
      {@required this.id,
      @required this.isFavorite,
      @required this.day,
      @required this.month,
      @required this.name});

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      "day": this.day,
      "month": this.month,
      "isFavorite": this.isFavorite,
      "name": this.name,
    };
  }
}
