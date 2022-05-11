import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

import '../models/weather_forcast_daily.dart';
import '../utils/forcast_utils.dart';
import '../widgets/extra_widgets.dart';

class CurrentWeather extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const CurrentWeather({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = snapshot.data;
    var forecastList = data!.list!;
    var temp = forecastList[0].temp!.day!.toStringAsFixed(0);
    var formattedDate = DateTime.fromMillisecondsSinceEpoch(forecastList[0].dt! * 1000);

    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlowText(
              data.city!.name!,
              style: const TextStyle(
                height: 0.1,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Image(
              image: AssetImage(
                Util.findIcon('${forecastList[0].weather![0].main}', true),
              ),
              fit: BoxFit.fill,
            ),
            GlowText(
              '$temp °C',
              style: const TextStyle(
                height: 0.1,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '${forecastList[0].weather![0].description}'.toTitleCase(),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              Util.getFormattedDate(formattedDate),
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            const Divider(color: Colors.white),
            const SizedBox(height: 10),
            ExtraWeather(snapshot: snapshot),
          ],
        ),
      ),
    );
  }
}
