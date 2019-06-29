import 'package:flutter/material.dart';
import 'package:nevnapp/models/nameday.dart';
import 'package:nevnapp/repository/repository_service_namedays.dart';

class NamedayScopedModel {
  AnimationController _controller;
  Map<DateTime, List> _events;
  Map<DateTime, List> _visibleHolidays;
  DateTime _selectedDay;
  List _selectedEvents;
  int _year;
  bool _loading;

  Future<Map<DateTime, List<Nameday>>> get allNamedays async {
    final _nameDays = await RepositoryServiceNamedays.getAll();

    Map<DateTime, List<Nameday>> nameDayList = Map<DateTime, List<Nameday>>();

    for (final i in _nameDays) {
      final _nameDay = Nameday.fromJSON(i.toMap());

      nameDayList[DateTime(_year, _nameDay.month, _nameDay.day)] = [
        Nameday(
            day: _nameDay.day,
            month: _nameDay.month,
            name: _nameDay.name,
            id: _nameDay.id,
            isFavorite: _nameDay.isFavorite)
      ];
      // nameDayList.add(nameDays);
    }
    return nameDayList;
  }
}
