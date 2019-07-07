import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nevnapp/models/nameday.dart';
import 'package:nevnapp/models/nameday.event.dart';

class EventItem extends StatelessWidget {
  final Nameday event;
  final int year;
  final bloc; 

  EventItem({this.event, this.year, this.bloc});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          event.isFavorite == 0 ? Icons.favorite_border : Icons.favorite,
          size: 40,
          color: Colors.red,
        ),
        subtitle: Text(formatDateTime(DateTime(year, event.month, event.day))),
        title: Text(
          event.name.toString(),
          style: TextStyle(fontSize: 50),
          textAlign: TextAlign.justify,
        ),
        onTap: () {
          // RepositoryServiceNamedays.toggleFavorite(event);
          bloc.namedayEventSink.add(ToggleFavorite(event));
          bloc.namedayEventSink
              .add(SelectedDayChanged(DateTime(year, event.month, event.day)));

          print('${event.isFavorite} tapped!');
        },
      ),
    );
  }

  String formatDateTime(DateTime date) => new DateFormat("MMMM d").format(date);
}
