import 'package:equatable/equatable.dart';

class PostEvent extends Equatable {}

class Fetch extends PostEvent {
  @override
  String toString() => 'Fetch';
}

class Tap extends PostEvent {
  @override
  String toString() => 'Tap' ;
}
