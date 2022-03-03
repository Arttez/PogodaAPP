import 'package:PogodaApp/models/Pogoda.dart';
import 'package:flutter/widgets.dart';

import 'PogodaCard.dart';

class HourlyPogoda extends StatelessWidget {
  final List<Pogoda> hourlyWeather;

  const HourlyPogoda({Key key, this.hourlyWeather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200.0,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: hourlyWeather.length,
            itemBuilder: (context, i) {
              return PogodaCard(
                title: '${hourlyWeather[i].time.hour}:${hourlyWeather[i].time.minute}0',
                temperature: hourlyWeather[i].temperature.toInt(),
                iconCode: hourlyWeather[i].iconCode,
                temperatureFontSize: 20,
              );
            }));
  }
}
//компонент для отображения погоды по часам
