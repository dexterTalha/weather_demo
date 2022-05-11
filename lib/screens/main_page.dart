import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../api/weather_api.dart';
import '../models/weather_forcast_daily.dart';
import '../screens/search_page.dart';
import '../widgets/current_weather.dart';

class HomePage extends StatefulWidget {
  final WeatherForecast? locationWeather;

  const HomePage({Key? key, required this.locationWeather}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<WeatherForecast> weatherObj;
  late String _cityName;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.locationWeather != null) {
      weatherObj = Future.value(widget.locationWeather);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff030317),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff030317),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  weatherObj = WeatherApi().fetchWeatherForecast();
                });
              },
              child: const Icon(
                CupertinoIcons.location_fill,
                color: Colors.white,
                size: 30,
              ),
            ),
            const Text(
              'Weather Demo App',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            GestureDetector(
              child: const Icon(
                Icons.search_rounded,
                color: Colors.white,
                size: 30,
              ),
              onTap: () async {
                var tappedName = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SearchPage();
                }));
                if (tappedName != null) {
                  setState(() {
                    _cityName = tappedName;
                    weatherObj = WeatherApi().fetchWeatherForecast(
                      cityName: _cityName,
                      isCity: true,
                    );
                  });
                }
              },
            )
          ],
        ),
      ),
      body: FutureBuilder<WeatherForecast>(
        future: weatherObj,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SpinKitChasingDots(color: Color(0xff00A1FF), size: 100.0),
            );
          }

          if (snapshot.hasData) {
            return CurrentWeather(snapshot: snapshot);
          }
          return const Center(
            child: Text(
              'Wrong City Name',
              style: TextStyle(fontSize: 25, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}
