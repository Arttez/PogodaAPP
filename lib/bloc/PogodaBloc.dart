import 'dart:async';

import 'package:PogodaApp/events/PogodaEvent.dart';
import 'package:PogodaApp/models/Pogoda.dart';
import 'package:PogodaApp/service/PogodaService.dart';
import 'package:PogodaApp/states/PogodaState.dart';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

class PogodaBloc extends Bloc<PogodaEvent, PogodaState> {
  PogodaBloc() : super(null) {
    add(PogodaCurrentPositionRequested());
  }

  get WeatherService => null;

  @override
  Stream<PogodaState> mapEventToState(PogodaEvent event) async* {
    if (event is PogodaRequested) {
      yield* _newPogodaRequested(event);
    }
    if (event is PogodaCurrentPositionRequested) {
      yield* _newWeatherCurrentPositionRequested();
    }
  }

  Stream<PogodaState> _newPogodaRequested(PogodaRequested event) async* {
    yield PogodaLoadInProgress();
    try {
      final Pogoda weather = await WeatherService.fetchCurrentWeather(query: event.city, lon: event.lon, lat: event.lat);
      final List<Pogoda> hourlyWeather = await WeatherService.fetchHourlyWeather(query: event.city, lon: event.lon, lat: event.lat);
      yield PogodaLoadSuccess(weather: weather, hourlyWeather: hourlyWeather);
    } catch (e) {
      yield PogodaLoadFailure();
    }
  }

  Stream<PogodaState> _newWeatherCurrentPositionRequested() async* {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      Position lastKnownPosition = await Geolocator.getLastKnownPosition();
      if (lastKnownPosition != null) {
        add(PogodaRequested(lat: lastKnownPosition.latitude.toString(), lon: lastKnownPosition.longitude.toString()));
      } else {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        add(PogodaRequested(lat: position.latitude.toString(), lon: position.longitude.toString()));
      }
    } else {
      await Geolocator.requestPermission();
      add(PogodaCurrentPositionRequested());
    }
  }
}
