import 'package:nevnapp/models/nameday.dart';
import 'package:nevnapp/repository/repository_service_namedays.dart';

class NamedayScopedModel {
  int _year;

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
