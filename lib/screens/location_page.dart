import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
import '../api/weather_api.dart';
import 'main_page.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Future<void> getLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    //check if the location service enabled or not
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    //check the location permission is granted or not
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  void getLocationData() async {
    try {
      await getLocation();
      var weatherInfo = await WeatherApi().fetchWeatherForecast();
      await Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage(locationWeather: weatherInfo);
      }));
    } catch (e) {
      log('$e');
    }
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xff030317),
      body: Center(
        child: SpinKitChasingDots(color: Color(0xff00A1FF), size: 100.0),
      ),
    );
  }
}
