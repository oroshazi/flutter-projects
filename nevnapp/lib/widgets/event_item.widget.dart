import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nevnapp/bloc/namedays_bloc.dart';
import 'package:nevnapp/models/nameday.dart';
import 'package:nevnapp/models/nameday.event.dart';
import 'package:nevnapp/repository/repository_service_namedays.dart';

class EventItem extends StatelessWidget {
  final Nameday event;
  final int year;

  EventItem({this.event, this.year});

  final bloc = NamedaysBloc();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: event.isFavorite == 1
            ? Icon(Icons.favorite)
            : Icon(Icons.favorite_border),
        subtitle: Text(formatDateTime(DateTime(year, event.month, event.day))),
        title: Text(
          event.name.toString(),
          style: TextStyle(fontSize: 50),
          textAlign: TextAlign.justify,
        ),
        onTap: () {
          bloc.visibleDaysChangeSink.add(ToggleFavorite(event));
          print('${event.isFavorite} tapped!');
        },
      ),
    );
  }

  String formatDateTime(DateTime date) => new DateFormat("MMMM d").format(date);
}
