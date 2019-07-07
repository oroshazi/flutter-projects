import 'package:flutter/material.dart';
import 'package:nevnapp/bloc/namedays.bloc.dart';
import 'package:nevnapp/constansts/routes.dart';
import 'package:nevnapp/data/events.data.dart';
import 'package:nevnapp/data/holidays.data.dart';
import 'package:nevnapp/models/nameday.dart';
import 'package:nevnapp/models/nameday.event.dart';
import 'package:nevnapp/widgets/event_list.widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:date_utils/date_utils.dart';

class CalendarScreen extends StatefulWidget {
  final String title = 'Flutter Demo Home Page';

  @override
  _CalendarScreen createState() => _CalendarScreen();
}

class _CalendarScreen extends State<CalendarScreen>
    with TickerProviderStateMixin {
  DateTime _selectedDay;
  Map<DateTime, List> _events;
  Map<DateTime, List> _visibleHolidays;
  List _selectedEvents;
  AnimationController _controller;
  int year;
  bool _loading;
  Map<DateTime, List> holidays = Holidays().holidayList;

  final bloc = NamedaysBloc();

  @override
  void initState() {
    super.initState();

    _loading = true;
    year = DateTime.now().year;
    _selectedDay =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    Events(year: year).nameDays().then((data) {
      _events = data;
      _selectedEvents = _events[_selectedDay];
    }).then((_) {
      setState(() {
        _visibleHolidays = holidays;
        _controller = AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 400),
        );
        _controller.forward();
      });
    }).then((_) {
      _loading = false;
    });
  }

  void _onDaySelected(DateTime day, List events) {
    bloc.namedayEventSink.add(SelectedDayChanged(day));
    // bloc.namedayEventSink.add(SelectedDayChanged(day));
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    bloc.namedayEventSink.add(VisibleYearChanged(first.year));

    // TODO:Think of a better solution
    bloc.namedayEventSink.add(SelectedDayChanged(last));
    setState(() {
      // Update year in Events, when the year changes in the calendar.
      year = first.year;
      // _selectedDay = last;

      // Get namedays from database when changing visibility.
      Events(year: year).nameDays().then((data) {
        _events = data;
      }).then((_) {
        _visibleHolidays = Map.fromEntries(
          holidays.entries.where(
            (entry) =>
                entry.key.isAfter(first.subtract(const Duration(days: 1))) &&
                entry.key.isBefore(last.add(const Duration(days: 1))),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //transparent Appbar
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: _buildSettingsButton(),
        actions: <Widget>[
          _buildBackToTodayButton(),
        ],
      ),
      body: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
        Flexible(child: Center(child: _buildEventList(context))),
        _buildTableCalendarWithBuilders(),
      ]),
    );
  }

  Widget _buildEventList(BuildContext context) {
    return StreamBuilder(
      stream: bloc.selectedNameday,
      builder: (context, AsyncSnapshot<Map<DateTime, List<Nameday>>> snapshot) {
        print("REBUILD EVENTLISt");
        if (snapshot.hasData) {
          return EventList(
            selectedEvents: snapshot.data.values.toList().first,
            selectedYear: year,
            bloc: bloc
          );
        } else {
          return Card();
        }
      },
    );
  }

  // More advanced TableCalendar configuration (using Builders & Styles)
  Widget _buildTableCalendarWithBuilders() {
    return StreamBuilder(
      stream: bloc.allNamedays,
      builder: (context, AsyncSnapshot<Map<DateTime, List<Nameday>>> snapshot) {
        if (snapshot.hasData) {
          return StreamBuilder(
            stream: bloc.selectedNameday,
            builder: (context,
                AsyncSnapshot<Map<DateTime, List<Nameday>>> selectedEvent) {
              // print("first nameday: " + selectedEvent.data.values.toList().first[0].isFavorite.toString());
              // print("first: " + selectedEvent.data.keys.toList().first.toString());
              if (selectedEvent.hasData) {
                return TableCalendar(
                  locale: 'en_US',
                  events: snapshot.data,
                  selectedDay: selectedEvent.data.keys.toList().first,
                  holidays: _visibleHolidays,
                  initialCalendarFormat: CalendarFormat.month,
                  formatAnimation: FormatAnimation.slide,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  availableGestures: AvailableGestures.all,
                  availableCalendarFormats: const {
                    CalendarFormat.month: '',
                    CalendarFormat.week: '',
                  },
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    weekendStyle: TextStyle().copyWith(color: Colors.green),
                    holidayStyle: TextStyle().copyWith(color: Colors.blue[800]),
                  ),
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekendStyle: TextStyle().copyWith(color: Colors.blue[600]),
                  ),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonVisible: false,
                  ),
                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, _) {
                      return FadeTransition(
                        opacity:
                            Tween(begin: 0.0, end: 1.0).animate(_controller),
                        child: Container(
                          margin: const EdgeInsets.all(4.0),
                          padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                          color: Colors.deepOrange[300],
                          width: 100,
                          height: 100,
                          child: Text(
                            '${date.day}',
                            style: TextStyle().copyWith(fontSize: 16.0),
                          ),
                        ),
                      );
                    },
                    todayDayBuilder: (context, date, _) {
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        padding: const EdgeInsets.only(top: 5.0, left: 6.0),
                        color: Colors.amber[400],
                        width: 100,
                        height: 100,
                        child: Text(
                          '${date.day}',
                          style: TextStyle().copyWith(fontSize: 16.0),
                        ),
                      );
                    },
                    markersBuilder: (context, date, events, holidays) {
                      final children = <Widget>[];

                      if (events.isNotEmpty && events[0].isFavorite == 1) {
                        children.add(
                          Positioned(
                            right: 1,
                            bottom: 1,
                            child: _buildEventsMarker(date, events),
                          ),
                        );
                      }

                      if (holidays.isNotEmpty) {
                        children.add(
                          Positioned(
                            right: -2,
                            top: -2,
                            child: _buildHolidaysMarker(),
                          ),
                        );
                      }

                      return children;
                    },
                  ),
                  onDaySelected: (date, events) {
                    bloc.namedayEventSink.add(SelectedDayChanged(date));
                    _controller.forward(from: 0.0);
                  },
                  onVisibleDaysChanged: _onVisibleDaysChanged,
                );
              } else {
                return Card();
              }
            },
          );
        } else {
          return LinearProgressIndicator();
        }
      },
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Utils.isSameDay(date, _selectedDay)
            ? Colors.brown[500]
            : Utils.isSameDay(date, DateTime.now())
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events[0].isFavorite}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.add_box,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildBackToTodayButton() {
    return FlatButton(
      child: Text("Today"),
      color: Colors.transparent,
      onPressed: () {
        final _today = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day);
        bloc.namedayEventSink.add(SelectedDayChanged(_today));
        _controller.forward(from: 0.0);
      },
    );
  }

  Widget _buildSettingsButton() {
    return IconButton(
      icon: Icon(Icons.settings),
      color: Colors.grey,
      onPressed: () {
        Navigator.pushNamed(context, ROUTES.SETTINGS);
      },
    );
  }
  
}
