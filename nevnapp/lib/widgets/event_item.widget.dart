import 'package:flutter/material.dart';
import 'package:nevnapp/models/nameday.dart';
import 'package:nevnapp/repository/repository_service_namedays.dart';

class EventItem extends StatelessWidget {
  final Nameday event;

  EventItem({this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          event.isFavorite == 0 ? Icons.favorite_border : Icons.favorite,
          size: 40,
          color: Colors.red,
        ),
        title: Text(
          event.name.toString(),
          style: TextStyle(fontSize: 50),
          textAlign: TextAlign.justify,
        ),
        onTap: () {
          RepositoryServiceNamedays.toggleFavorite(event);
          print('${event.isFavorite} tapped!');
        },
      ),
    );
  }
}
