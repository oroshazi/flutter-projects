import 'dart:async';

import 'package:nevnapp/models/nameday.dart';
import 'package:nevnapp/models/nameday.event.dart';
import 'package:nevnapp/repository/database_creator.dart';
import 'package:rxdart/rxdart.dart';

class NamedaysBloc {
  final _allNamedaysSubject = BehaviorSubject<Map<DateTime, List<Nameday>>>();
  Observable<Map<DateTime, List<Nameday>>> get allNamedays =>
      _allNamedaysSubject.stream;

  NamedaysBloc() {
    _fetch();
  }

  dispose() {
    _allNamedaysSubject.close();
  }

  _handleVisibleDayChange(NamedayEvent event) {
    if (event is VisibleYearChanged) {
      _handleVisibleYearChanged(event);
    }
    if (event is ToggleFavorite) {
      _handleToggleFavorite(event);
    }
  }

  _handleVisibleYearChanged(VisibleYearChanged event) {
    //   // _year = event.year;
    //   // TODO: check if year was changed.
    //   _visibleYearSubject.sink.add(event.year);

    //   for (final i in nameDaysHu) {
    //     final nameDay = Nameday.fromJSON(i.toMap());

    //     nameDayList[DateTime(event.year, nameDay.month, nameDay.day)] = [
    //       Nameday(
    //           day: nameDay.day,
    //           month: nameDay.month,
    //           name: nameDay.name,
    //           id: nameDay.id,
    //           isFavorite: nameDay.isFavorite)
    //     ];
    //   }
    //   _allNamedaysSubject.sink.add(nameDayList);
  }

  _handleToggleFavorite(ToggleFavorite event) {
    //   DateTime key = nameDayList.keys.firstWhere(
    //       (name) => nameDayList[name][0].name == event.nameday.name,
    //       orElse: () => null);

    //   final sql = '''UPDATE ${DatabaseCreator.nameDayTableHu}
    //                 SET ${DatabaseCreator.isFavorite} = ?
    //                 WHERE ${DatabaseCreator.name} = ?
    //                 ''';

    //   List<dynamic> params = [
    //     event.nameday.isFavorite == 1 ? 0 : 1,
    //     event.nameday.name
    //   ];

    //   event.nameday.isFavorite = event.nameday.isFavorite == 1 ? 0 : 1;

    //   nameDayList[key] = [
    //     Nameday(
    //         day: event.nameday.day,
    //         month: event.nameday.month,
    //         name: event.nameday.name,
    //         id: event.nameday.id,
    //         isFavorite: event.nameday.isFavorite)
    //   ];

    //   _selectedEventSubject.sink.add(nameDayList[key]);
    //   _allNamedaysSubject.sink.add(nameDayList);
    //   db.rawUpdate(sql, params);
  }

  _fetch() async {
    List<Nameday> nameDaysHu = List();
    Map<DateTime, List<Nameday>> nameDayList = Map<DateTime, List<Nameday>>();

    print("fetch fired");
    final sql = '''SELECT * FROM ${DatabaseCreator.nameDayTableHu}''';

    final data = await db.rawQuery(sql);

    for (final node in data) {
      final nameDay = Nameday.fromJSON(node);
      nameDaysHu.add(Nameday(
          day: nameDay.day,
          id: nameDay.id,
          month: nameDay.month,
          name: nameDay.name,
          isFavorite: nameDay.isFavorite));
    }

    for (final i in nameDaysHu) {
      final nameDay = Nameday(
          id: i.id,
          isFavorite: i.isFavorite,
          month: i.month,
          day: i.day,
          name: i.name);

      nameDayList[DateTime(nameDay.year, nameDay.month, nameDay.day)] = [
        Nameday(
            day: nameDay.day,
            month: nameDay.month,
            name: nameDay.name,
            id: nameDay.id,
            isFavorite: nameDay.isFavorite)
      ];
    }

    _allNamedaysSubject.sink.add(nameDayList);
  }
}
