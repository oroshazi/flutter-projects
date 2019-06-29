import 'package:flutter/material.dart';
import 'package:nevnapp/widgets/event_item.widget.dart';

class EventList extends StatelessWidget {
  final List<dynamic> selectedEvents;
  final int selectedYear;

  EventList({this.selectedEvents, this.selectedYear});

  @override
  Widget build(BuildContext context) {
    print("year: " + selectedYear.toString());
    return ListView(
        shrinkWrap: true,
        children: selectedEvents != null
            ? selectedEvents
                .map((event) => EventItem(
                      event: event,
                      year: selectedYear,
                    ))
                .toList()
            : List());
  }
}
