import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nevnapp/repository/database_creator.dart';
import 'package:nevnapp/repository/repository_service_namedays.dart';
import 'package:nevnapp/widgets/bottom_navigation.widget.dart';

void main() async {
  await DatabaseCreator().initDatabase();
  initializeDateFormatting().then((_) => runApp(MyApp()));
  final dbContent = await RepositoryServiceNamedays.getAll(); 

  print(dbContent);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomNavigation(),
    );
  }
}
