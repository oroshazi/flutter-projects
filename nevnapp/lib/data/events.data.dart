import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:nevnapp/models/nameday.dart';
import 'package:nevnapp/repository/repository_service_namedays.dart';

class Events {
  final int year;

  Events({@required this.year});

  Future<Map<DateTime, List<Nameday>>> nameDays() async {
    final nameDays = await RepositoryServiceNamedays.getAll();

    Map<DateTime, List<Nameday>> nameDayList = Map<DateTime, List<Nameday>>();

    for (final i in nameDays) {
      final nameDay = Nameday.fromJSON(i.toMap());

      nameDayList[DateTime(year, nameDay.month, nameDay.day)] = [
        Nameday(
            day: nameDay.day,
            month: nameDay.month,
            name: nameDay.name,
            id: nameDay.id,
            isFavorite: nameDay.isFavorite)
      ];
      // nameDayList.add(nameDays);
    }

    // print(nameDayList);

    return nameDayList;
  }
}
