import 'package:flutter/material.dart';
import 'package:nevnapp/widgets/event_item.widget.dart';

class EventList extends StatelessWidget {
  final List<dynamic> selectedEvents;

  EventList({this.selectedEvents});

  @override
  Widget build(BuildContext context) {
    print(selectedEvents); 
    return ListView(
        shrinkWrap: true,
        children:
            selectedEvents.map((event) => EventItem(event: event)).toList());
  }
}
