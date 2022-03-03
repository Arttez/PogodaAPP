import 'package:PogodaApp/components/PogodaHours.dart';
import 'package:PogodaApp/models/Pogoda.dart';
import 'package:flutter/widgets.dart';

import 'PogodaCard.dart';

class MainScreenWrapper extends StatelessWidget {
  final Pogoda weather;
  final List<Pogoda> hourlyWeather;

  const MainScreenWrapper({Key key, this.weather, this.hourlyWeather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        Text(
          weather.cityName,
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text('${weather.description}'),
        Spacer(),
        PogodaCard(
          title: "Now",
          temperature: weather.temperature,
          iconCode: weather.iconCode,
          temperatureFontSize: 64,
          iconScale: 1,
        ),
        Spacer(),
        HourlyPogoda(hourlyWeather: this.hourlyWeather)
      ]),
    );
  }
}
//Компонент для главной страницы
// который будет в себя включать виджет с текущей погодой
// горизонтальный скролл с погодой по часам
