import 'package:flutter/material.dart';

class EventItem extends StatelessWidget {
  final String event;

  EventItem({this.event});

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   decoration: BoxDecoration(
    //       border: Border.all(width: 0.8),
    //       borderRadius: BorderRadius.circular(3.0),
    //       color: Colors.red),
    //   margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    //   child: ListTile(
    //     title: Text(event.toString()),
    //     onTap: () => print('$event tapped!'),
    //   ),
    // );

    return Card(
      child: ListTile(
        leading: Icon(
          Icons.favorite_border,
          size: 40,
          color: Colors.red,
        ),

        subtitle: Text(event.toString()),
        title: Text(
          event.toString(),
          style: TextStyle(fontSize: 50),
          textAlign: TextAlign.justify,
        ),
        // subtitle: event.,
        onTap: () => print('$event tapped!'),
      ),
    );
  }
}
