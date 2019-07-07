import 'package:nevnapp/models/nameday.dart';

class NamedayEvent {}

class VisibleYearChanged extends NamedayEvent {
  final int year;
  VisibleYearChanged(this.year);
}

class ToggleFavorite extends NamedayEvent {
  final Nameday nameday;
  ToggleFavorite(this.nameday);
}

class SelectedDayChanged extends NamedayEvent {
  final DateTime selectedDay;
  SelectedDayChanged(this.selectedDay);
}
