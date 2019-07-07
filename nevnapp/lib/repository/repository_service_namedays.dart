import 'package:nevnapp/repository/database_creator.dart';

import '../models/nameday.dart';

class RepositoryServiceNamedays {
  static Future<List<Nameday>> getAll() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.nameDayTableHu}''';
    final data = await db.rawQuery(sql);

    List<Nameday> nameDaysHu = List();

    for (final node in data) {
      final nameDay = Nameday.fromJSON(node);
      nameDaysHu.add(nameDay);
    }
    return nameDaysHu;
  }

  static void toggleFavorite(Nameday nameDay) async {
    final sql = '''UPDATE ${DatabaseCreator.nameDayTableHu}
    SET ${DatabaseCreator.isFavorite} = ?
    WHERE ${DatabaseCreator.name} = ?
    ''';

    List<dynamic> params = [nameDay.isFavorite == 1 ? 0 : 1, nameDay.name];
    final result = await db.rawUpdate(sql, params);

    // DatabaseCreator.databaseLog('Update todo', sql, null, result, params);
  }
}
