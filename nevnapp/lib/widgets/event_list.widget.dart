import 'package:flutter/material.dart';
import 'package:nevnapp/widgets/event_item.widget.dart';

class EventList extends StatelessWidget {
  final List<dynamic> selectedEvents;
  // final int selectedYear;
  final bloc; 

  EventList({this.selectedEvents, this.bloc});

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        children: selectedEvents != null
            ? selectedEvents
                .map((event) => EventItem(
                      event: event,
                      year: event.year,
                      bloc: bloc
                    ))
                .toList()
            : List());
  }
}
