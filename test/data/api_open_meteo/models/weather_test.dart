import 'package:flutter_test/flutter_test.dart';
import 'package:weather_riverpod_async/data/api_open_meteo/models/weather_meteo_api.dart';

void main() {
  group('Weather', () {
    group('fromJson', () {
      test('returns correct Weather object', () {
        expect(
          WeatherMeteoApi.fromJson(
            <String, dynamic>{'temperature': 15.3, 'weathercode': 63},
          ),
          isA<WeatherMeteoApi>()
              .having((w) => w.temperature, 'temperature', 15.3)
              .having((w) => w.weatherCode, 'weatherCode', 63),
        );
      });
    });
  });
}
