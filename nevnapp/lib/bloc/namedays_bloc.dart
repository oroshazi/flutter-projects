import 'dart:async';

import 'package:nevnapp/models/nameday.dart';
import 'package:nevnapp/models/nameday.event.dart';
import 'package:nevnapp/repository/database_creator.dart';
import 'package:rxdart/rxdart.dart';

class NamedaysBloc {
  int _year;
  List<Nameday> nameDaysHu = List();
  Map<DateTime, List<Nameday>> nameDayList = Map<DateTime, List<Nameday>>();

  final _visibleYearSubject = BehaviorSubject<int>();
  final _selectedEventSubject = BehaviorSubject<List>();
  final _allNamedaysSubject = BehaviorSubject<Map<DateTime, List<Nameday>>>();
  final _selectedDaySubject = BehaviorSubject<DateTime>();
  final _selectedDayController = StreamController<DateTime>();
  final _visibleDaysController = StreamController<NamedayEvent>();

  Observable<Map<DateTime, List<Nameday>>> get allNameday =>
      _allNamedaysSubject.stream;
  Observable<DateTime> get selectedDay => _selectedDaySubject.stream;
  Observable<List> get selectedEvents => _selectedEventSubject.stream;
  Observable<int> get visibleYear => _visibleYearSubject.stream;

  Sink<DateTime> get selectedDayChangeSink => _selectedDayController.sink;
  Sink<NamedayEvent> get visibleDaysChangeSink => _visibleDaysController.sink;

  NamedaysBloc() {
    _year = DateTime.now().year;
    _visibleYearSubject.sink.add(DateTime.now().year);
    _fetch();
    _selectedDayController.stream.listen(_handleSelectedDayChange);
    _visibleDaysController.stream.listen(_handleVisibleDayChange);
  }

  dispose() {
    _allNamedaysSubject.close();
    _selectedDaySubject.close();
    _visibleYearSubject.close();
    _selectedEventSubject.close();
    _selectedDayController.close();
    _visibleDaysController.close();
  }

  _handleSelectedDayChange(DateTime newSelectedDate) {
    _selectedDaySubject.sink.add(newSelectedDate);
    _selectedEventSubject.sink.add(nameDayList[newSelectedDate]);
  }

  _handleVisibleDayChange(NamedayEvent event) {
    if (event is VisibleYearChanged) {
      _year = event.year;
      // TODO: check if year was changed.
      _visibleYearSubject.sink.add(event.year);

      for (final i in nameDaysHu) {
        final nameDay = Nameday.fromJSON(i.toMap());

        nameDayList[DateTime(event.year, nameDay.month, nameDay.day)] = [
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

    if (event is SelectedEventChange) {}
  }

  _fetch() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.nameDayTableHu}''';

    final data = await db.rawQuery(sql);

    for (final node in data) {
      final nameDay = Nameday.fromJSON(node);
      nameDaysHu.add(nameDay);
    }

    for (final i in nameDaysHu) {
      final nameDay = Nameday.fromJSON(i.toMap());

      nameDayList[DateTime(_year, nameDay.month, nameDay.day)] = [
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
