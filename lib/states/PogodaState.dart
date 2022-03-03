import 'package:PogodaApp/models/Pogoda.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class PogodaState extends Equatable {
  const PogodaState();

  @override
  List<Object> get props => [];
}

class PogodaInitial extends PogodaState {}

class PogodaLoadInProgress extends PogodaState {}

class PogodaLoadSuccess extends PogodaState {
  final Pogoda weather;
  final List<Pogoda> hourlyWeather;

  const PogodaLoadSuccess({@required this.weather, @required this.hourlyWeather}) : assert(weather != null);

  @override
  List<Object> get props => [
        weather,
        hourlyWeather
      ];
}

class PogodaLoadFailure extends PogodaState {}
//список состояний компонента с погодой
//PogodaInitial – если не происходит ничего
//PogodaLoadInProgress – если мы загружаем данные о погоде
//PogodaLoadSuccess – если данные загружены успешно
//PogodaLoadFailure – если произошла какая-то ошибка
