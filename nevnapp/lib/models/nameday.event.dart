import 'package:nevnapp/models/nameday.dart';

class NamedayEvent {}

class VisibleYearChanged extends NamedayEvent {}

class ToggleFavorite extends NamedayEvent {
  final Nameday nameday;
  ToggleFavorite(this.nameday);
}
