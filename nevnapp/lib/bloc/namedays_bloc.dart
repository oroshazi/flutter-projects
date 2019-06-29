import 'dart:async';

import 'package:nevnapp/models/nameday.dart';
import 'package:nevnapp/repository/database_creator.dart';
import 'package:rxdart/rxdart.dart';

class NamedaysBloc {
  int _year;

  final _allNamedaysSubject = BehaviorSubject<Map<DateTime, List<Nameday>>>();
  final _selectedDaySubject = BehaviorSubject<DateTime>();
  final _selectedDayController = StreamController<DateTime>();

  Observable<Map<DateTime, List<Nameday>>> get allNameday =>
      _allNamedaysSubject.stream;

  Observable<DateTime> get selectedDay => _selectedDaySubject.stream;

  Sink<DateTime> get selectedDayChangeSink => _selectedDaySubject.sink;

  set setYear(int year) {
    _year = year;
  }

  NamedaysBloc() {
    _year = DateTime.now().year;
    _fetch();
    _selectedDayController.stream.listen(_handleSelectedDayChange);
  }

  dispose() {
    _allNamedaysSubject.close();
    _selectedDaySubject.close();
    _selectedDayController.close();
  }

  _handleSelectedDayChange(DateTime newSelectedDate) {
    if (newSelectedDate is DateTime) {
      _selectedDaySubject.sink.add(newSelectedDate);
    }
  }

  _fetch() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.nameDayTableHu}''';

    final data = await db.rawQuery(sql);
    List<Nameday> nameDaysHu = List();

    for (final node in data) {
      final nameDay = Nameday.fromJSON(node);
      nameDaysHu.add(nameDay);
    }

    Map<DateTime, List<Nameday>> nameDayList = Map<DateTime, List<Nameday>>();

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
