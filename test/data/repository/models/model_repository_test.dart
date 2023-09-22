import 'package:flutter_test/flutter_test.dart';
import 'package:weather_riverpod_async/data/repository/model/models_repository.dart';

void main() {
  group('Weather', () {
    test('can be (de)serialized', () {
      const weather = WeatherSrcRepository(
        condition: WeatherCondition.cloudy,
        temperature: 10.2,
        location: 'Chicago',
      );
      expect(WeatherSrcRepository.fromJson(weather.toJson()), equals(weather));
    });
  });
}