import 'package:nevnapp/models/nameday.dart';

abstract class NamedayEvent {}

class SelectedDayChanged extends NamedayEvent {}

class VisibleDayChanged extends NamedayEvent {}

class VisibleYearChanged extends NamedayEvent {
  final int year;
  VisibleYearChanged(this.year);
}

class SelectedEventChange extends NamedayEvent {}

class ToggleFavorite extends NamedayEvent {
  final Nameday nameday;
  ToggleFavorite(this.nameday);
}
