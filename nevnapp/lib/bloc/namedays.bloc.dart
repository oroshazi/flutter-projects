import 'dart:async';

import 'package:nevnapp/models/nameday.dart';
import 'package:nevnapp/models/nameday.event.dart';
import 'package:nevnapp/repository/database_creator.dart';
import 'package:rxdart/rxdart.dart';

class NamedaysBloc {
  List<Nameday> nameDaysHu = List();
  Map<DateTime, List<Nameday>> nameDayList = Map<DateTime, List<Nameday>>();

  final _allNamedaysSubject = BehaviorSubject<Map<DateTime, List<Nameday>>>();
  Observable<Map<DateTime, List<Nameday>>> get allNamedays =>
      _allNamedaysSubject.stream;

  final _selectedNamedaySubject =
      BehaviorSubject<Map<DateTime, List<Nameday>>>();
  Observable<Map<DateTime, List<Nameday>>> get selectedNameday =>
      _selectedNamedaySubject.stream;

  Sink<NamedayEvent> get namedayEventSink => _namedayEventController.sink;
  final _namedayEventController = StreamController<NamedayEvent>();

  NamedaysBloc() {
    _fetch();
    _handleSelectedDayChanged(DateTime.now());
    // _selectedNamedaySubject.sink.add(nameDayList[DateTime.now()]);
    _namedayEventController.stream.listen(_handle);
  }

  dispose() {
    _allNamedaysSubject.close();
    _selectedNamedaySubject.close();
    _namedayEventController.close();
  }

  _handle(NamedayEvent event) {
    if (event is VisibleYearChanged) {
      _fetch(year: event.year);
    }
    if (event is SelectedDayChanged) {
      _handleSelectedDayChanged(event.selectedDay);
    }
    if (event is ToggleFavorite) {
      _handleToggleFavorite(event);
      if (event.isOnFavoriteScreen) {
        _fetch();
      }
    }
  }

  _handleSelectedDayChanged(DateTime date) {
    Map<DateTime, List<Nameday>> mappedSelectedDay = Map();
    mappedSelectedDay = {date: nameDayList[date] ?? []};
    _selectedNamedaySubject.sink.add(mappedSelectedDay);
  }

  _handleToggleFavorite(ToggleFavorite event) {
    Map<DateTime, List<Nameday>> mappedSelectedDay = Map();

    DateTime key = nameDayList.keys.firstWhere(
        (name) => nameDayList[name][0].name == event.nameday.name,
        orElse: () => null);

    final sql = '''UPDATE ${DatabaseCreator.nameDayTableHu}
                    SET ${DatabaseCreator.isFavorite} = ?
                    WHERE ${DatabaseCreator.name} = ?
                    ''';

    List<dynamic> params = [
      event.nameday.isFavorite == 1 ? 0 : 1,
      event.nameday.name
    ];

    event.nameday.isFavorite = event.nameday.isFavorite == 1 ? 0 : 1;

    nameDayList[key] = [
      Nameday(
          year: event.nameday.year,
          day: event.nameday.day,
          month: event.nameday.month,
          name: event.nameday.name,
          id: event.nameday.id,
          isFavorite: event.nameday.isFavorite)
    ];
    mappedSelectedDay = {key: nameDayList[key]};
    _selectedNamedaySubject.sink.add(mappedSelectedDay);
    db.rawUpdate(sql, params);
  }

  _fetch({int year = 2019}) async {
    // TODO: check if year was changed.

    print("fetch fired");
    final sql = '''SELECT * FROM ${DatabaseCreator.nameDayTableHu}''';

    final data = await db.rawQuery(sql);

    for (final node in data) {
      final nameDay = Nameday.fromJSON(node);
      nameDaysHu.add(Nameday(
          year: year,
          day: nameDay.day,
          id: nameDay.id,
          month: nameDay.month,
          name: nameDay.name,
          isFavorite: nameDay.isFavorite));
    }

    for (final i in nameDaysHu) {
      final nameDay = Nameday(
          year: year,
          id: i.id,
          isFavorite: i.isFavorite,
          month: i.month,
          day: i.day,
          name: i.name);

      nameDayList[DateTime(nameDay.year, nameDay.month, nameDay.day)] = [
        Nameday(
            year: year,
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
