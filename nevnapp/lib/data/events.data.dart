import 'package:flutter/widgets.dart';

class Events {
  final int year;

  Events({@required this.year});

  Map<DateTime, List> get hu {
    return {
      DateTime(year, 6, 19): ["thing"],
    };
  }
}
