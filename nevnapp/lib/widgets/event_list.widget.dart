import 'package:flutter/material.dart';
import 'package:nevnapp/widgets/event_item.widget.dart';

class EventList extends StatelessWidget {
  List selectedEvents;
  EventList({this.selectedEvents});

  @override
  Widget build(BuildContext context) {
    return ListView(
        children:
            selectedEvents.map((event) => EventItem(event: event)).toList());
  }
}
