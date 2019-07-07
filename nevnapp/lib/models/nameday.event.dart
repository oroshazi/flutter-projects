import 'package:nevnapp/models/nameday.dart';

class NamedayEvent {}

class VisibleYearChanged extends NamedayEvent {
  final int year;
  VisibleYearChanged(this.year);
}

class ToggleFavorite extends NamedayEvent {
  final Nameday nameday;
  final isOnFavoriteScreen; 
  ToggleFavorite(this.nameday, {this.isOnFavoriteScreen = false});
}

class ToggleFavoriteInFavoriteScreen extends ToggleFavorite  {
  final Nameday nameday;
  ToggleFavoriteInFavoriteScreen(this.nameday) : super(null);
}

class SelectedDayChanged extends NamedayEvent {
  final DateTime selectedDay;
  SelectedDayChanged(this.selectedDay);
}
