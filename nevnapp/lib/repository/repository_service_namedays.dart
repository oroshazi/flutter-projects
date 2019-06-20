import 'package:nevnapp/repository/database_creator.dart';

import '../models/nameday.dart';

class RepositoryServiceNamedays {
  static Future<List<Nameday>> getAll() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.nameDayTableHu}''';
    final data = await db.rawQuery(sql);

    print(data); 

    List<Nameday> nameDaysHu = List();

    for (final node in data) {
      final nameDay = Nameday.fromJSON(node);
      nameDaysHu.add(nameDay);
    }
    return nameDaysHu;
  }
}
