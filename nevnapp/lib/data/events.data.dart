import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:nevnapp/models/nameday.dart';
import 'package:nevnapp/repository/repository_service_namedays.dart';

class Events {
  final int year;

  Events({@required this.year});

  Map<DateTime, List> get hu {
    return {
      DateTime(year, 6, 1): ["Tünde"],
      DateTime(year, 6, 2): ["Anita", "Kármen"],
      DateTime(year, 6, 3): ["Klotild"],
      DateTime(year, 6, 4): ["Bulcsú"],
      DateTime(year, 6, 5): ["Fatime"],
      DateTime(year, 6, 6): ["Cintia", "Norbert"],
      DateTime(year, 6, 7): ["Róbert"],
      DateTime(year, 6, 8): ["Medárd"],
      DateTime(year, 6, 9): ["Félix"],
      DateTime(year, 6, 10): ["Gréta, Margit"],
      DateTime(year, 6, 11): ["Barnabás"],
      DateTime(year, 6, 12): ["Villõ"],
      DateTime(year, 6, 13): ["Anett, Antal"],
      // DateTime(year, 6, 2): ["Kármen"],
      DateTime(year, 7, 1): ["Tünde"],
      DateTime(year, 7, 2): ["Anita", "Kármen"],
      DateTime(year, 7, 3): ["Klotild"],
      DateTime(year, 7, 4): ["Bulcsú"],
      DateTime(year, 7, 5): ["Fatime"],
      DateTime(year, 7, 6): ["Cintia", "Norbert"],
      DateTime(year, 7, 7): ["Róbert"],
      DateTime(year, 7, 8): ["Medárd"],
      DateTime(year, 7, 9): ["Félix"],
      DateTime(year, 7, 10): ["Gréta, Margit"],
      DateTime(year, 7, 11): ["Barnabás"],
      DateTime(year, 7, 12): ["Villõ"],
      DateTime(year, 7, 13): ["Anett, Antal"],
      // DateTime(year, 6, 2): ["Kármen"],
      DateTime(year, 8, 1): ["Tünde"],
      DateTime(year, 8, 2): ["Anita", "Kármen"],
      DateTime(year, 8, 3): ["Klotild"],
      DateTime(year, 8, 4): ["Bulcsú"],
      DateTime(year, 8, 5): ["Fatime"],
      DateTime(year, 8, 6): ["Cintia", "Norbert"],
      DateTime(year, 8, 7): ["Róbert"],
      DateTime(year, 8, 8): ["Medárd"],
      DateTime(year, 8, 9): ["Félix"],
      DateTime(year, 8, 10): ["Gréta, Margit"],
      DateTime(year, 8, 11): ["Barnabás"],
      DateTime(year, 8, 12): ["Villõ"],
      DateTime(year, 8, 13): ["Anett, Antal"],
      // DateTime(year, 6, 2): ["Kármen"],
    };
  }

  // Future <Map<DateTime, Nameday>> get nameDays async {
  //   final nameDays = await RepositoryServiceNamedays.getAll();

  //   List<Nameday> nameDayList = List();

  //   for (final node in nameDays) {
  //     final nameDays = Nameday.fromJSON(node.toMap());
  //     nameDayList.add(nameDays);
  //   }

  //   return nameDayList;
  // }

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

    print(nameDayList); 
    
    return nameDayList;
  }
}
