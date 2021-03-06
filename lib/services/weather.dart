import 'package:clima_flutter_app/services/location.dart';
import 'package:clima_flutter_app/services/networking.dart';

const apiMainDomain = 'api.openweathermap.org';
const apiRoute = '/data/2.5/weather';
const apiKey = 'eaaf25748cbac49f3e98a5df996bb406';
const units = 'metric';

class WeatherModel {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }

  Future<dynamic> getCityWeather(String? cityName) async {
    final Map<String, String> queryParameters = {
      'q': '$cityName',
      'appid': apiKey,
      'units': units
    };
    NetworkHelper networkHelper = NetworkHelper(
        queryParameters: queryParameters,
        apiMainDomain: apiMainDomain,
        apiRoute: apiRoute);
    dynamic cityWeather = await networkHelper.getData();
    return cityWeather;
  }

  Future<dynamic> getLocationWeather() async {
    try {
      Location location = Location();
      await location.getCurrentLocation();
      final Map<String, String> queryParameters = {
        'lat': '${location.latitude}',
        'lon': '${location.longitude}',
        'appid': '$apiKey',
        'units': units
      };
      // NetworkHelper networkHelper = NetworkHelper(
      //   longitude: location.longitude,
      //   latitude: location.latitude,
      // );
      NetworkHelper networkHelper = NetworkHelper(
          queryParameters: queryParameters,
          apiMainDomain: apiMainDomain,
          apiRoute: apiRoute);
      dynamic weatherData = await networkHelper.getData();
      return weatherData;
    } catch (e) {
      throw 'error $e';
    }
  }
}
