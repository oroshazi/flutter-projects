import 'package:flutter/material.dart';
import 'package:nevnapp/bloc/namedays.bloc.dart';
import 'package:nevnapp/models/nameday.dart';
import 'package:nevnapp/models/nameday.event.dart';

class FavoritesScreen extends StatelessWidget {
  final bloc = NamedaysBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        title: TextField(),
      ),
      body: Center(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: bloc.allNamedays,
      // initialData: initialData ,
      builder: (BuildContext context,
          AsyncSnapshot<Map<DateTime, List<Nameday>>> snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final dates = snapshot.data.keys.toList();
                final namedays = snapshot.data[dates[index]][0];

                return ListTile(
                  leading: Icon(
                    namedays.isFavorite == 0
                        ? Icons.favorite_border
                        : Icons.favorite,
                    size: 40,
                    color: Colors.red,
                  ),
                  title: Text(namedays.name),
                  subtitle: Text(
                    dates[index].toString(),
                    style: TextStyle(fontSize: 10.0),
                  ),
                  isThreeLine: true,
                  dense: true,
                  onTap: () {
                    bloc.namedayEventSink.add(
                        ToggleFavorite(namedays, isOnFavoriteScreen: true));
                  },
                );
              },
            ),
          );
        } else {
          return LinearProgressIndicator();
        }
      },
    );
  }
}
