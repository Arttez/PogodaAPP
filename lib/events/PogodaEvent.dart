import 'package:equatable/equatable.dart';

abstract class PogodaEvent extends Equatable {
  const PogodaEvent([List props = const []]);
}

class PogodaCurrentPositionRequested extends PogodaEvent {
  const PogodaCurrentPositionRequested() : super();

  @override
  List<Object> get props => [];
}

class PogodaRequested extends PogodaEvent {
  final String city;
  final String lat;
  final String lon;

  const PogodaRequested({this.city = "", this.lat = "", this.lon = ""}) : super();

  @override
  List<Object> get props => [
        city,
        lat,
        lon
      ];
}
//Cобытия которые будет обрабатывать BLoC @AlekseyNemtyrev
