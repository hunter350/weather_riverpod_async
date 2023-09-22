import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_riverpod_async/data/repository/model/models_repository.dart';
import 'package:weather_riverpod_async/data/repository/weather_repository.dart' ;
import 'package:weather_riverpod_async/domain/weather_models.dart';
import 'package:weather_riverpod_async/state/weather/weather_notifier.dart';
import 'package:weather_riverpod_async/state/weather/weather_state.dart';


const weatherLocation = 'London';
const weatherCondition = WeatherCondition.rainy;
const weatherTemperature = 9.8;

//final weatherNotifierProvider = StateNotifierProvider<WeatherNotifier, WeatherState>((ref) => WeatherNotifier());

class Listener extends Mock {
  void call(WeatherState? previous, WeatherState value);
}

class MockWeatherRepository extends Mock
    implements WeatherRepository{}

class MockWeather extends Mock implements WeatherSrcRepository {}

void main() {


  group('WeatherCubit', () {
    late WeatherSrcRepository weather;
    late WeatherRepository weatherRepository;
   //  late final weatherNotifier;

    final container = ProviderContainer();
   // addTearDown(container.dispose);
    final listener = Listener();

    // Observe a provider and spy the changes.
    container.listen(
      weatherNotifier,
      listener,
      fireImmediately: true,
    );

   // final weatherNotifier = container.read(weatherNotifierProvider);

    setUp(() async {
      weather = MockWeather();
      weatherRepository = MockWeatherRepository();
      when(() => weather.condition).thenReturn(weatherCondition);
      when(() => weather.location).thenReturn(weatherLocation);
      when(() => weather.temperature).thenReturn(weatherTemperature);
      when(
            () => weatherRepository.getWeather(any()),
      ).thenAnswer((_) async => weather);
     //weatherNotifier = container.read(weatherNotifierProvider);
    });

    test('initial state is correct', () {
      final state = container.read(weatherNotifier);
     //final weatherNotifier = container.read(weatherNotifierProvider.notifier);
      expect(state, WeatherState());
    });

    // group('toJson/fromJson', () {
    //   test('work properly', () {
    //    // final weatherNotifier = container.read(weatherNotifierProvider.notifier);
    //     final weatherNotif = container.read(weatherNotifier.notifier);
    //     //print(weatherNotif.toString());
    //     final weatherStateToJson = container.read(weatherNotifier);
    //     //print(weatherStateToJson.toString());
    //     final toJsonVariable = weatherNotif.toJson(weatherStateToJson);
    //   //  print(toJsonVariable.toString());
    //      final state1 = weatherNotif.fromJson(toJsonVariable);
    //     print(state1.toString());
    //   //  final state2 = weatherNotif.state;
    //
    //    // state.(state.toJson());
    //     expect(state1, equals(weatherStateToJson));
    //   });
    // });
    var weatherState = WeatherState(
        status: WeatherStatus.initial,
        temperatureUnits: TemperatureUnits.celsius,
        weatherModels: WeatherModels(
      condition: WeatherCondition.unknown,
      lastUpdated: DateTime(0),
      temperature: const Temperature(value: 0),
      location: '--',
    ));

      test('fetchWeather', () {
        final state = container.read(weatherNotifier.notifier);
        final fetchWeather =  state.fetchWeather(null);
        expect(state.state, weatherState);
      }
        );

  //   group('fetchWeather', () {
  //     blocTest<WeatherCubit, WeatherState>(
  //       'emits nothing when city is null',
  //       build: () => weatherCubit,
  //       act: (cubit) => cubit.fetchWeather(null),
  //       expect: () => <WeatherState>[],
  //     );

    test('emits nothing when city is empty', () {
      final state = container.read(weatherNotifier.notifier);
      final fetchWeather =  state.fetchWeather('');
      expect(state.state, weatherState);
    }
    );

  //     blocTest<WeatherCubit, WeatherState>(
  //       'emits nothing when city is empty',
  //       build: () => weatherCubit,
  //       act: (cubit) => cubit.fetchWeather(''),
  //       expect: () => <WeatherState>[],
  //     );

    test('calls getWeather with correct city', () async {
     // weatherState.weatherModels.location = weatherLocation;
     //  weatherState = WeatherState(
     //      status: WeatherStatus.success,
     //      temperatureUnits: TemperatureUnits.celsius,
     //      weatherModels: WeatherModels(
     //        condition: WeatherCondition.cloudy,
     //        lastUpdated: DateTime(0),
     //        temperature: const Temperature(value: 0),
     //        location: weatherLocation,
     //      ));
      final state = container.read(weatherNotifier.notifier);
      final fetchWeather =  await state.fetchWeather(weatherLocation).then((value)  {
     // print(state.state);
     // verify(() => weatherRepository.getWeather(weatherLocation)).called(1);
      });

    }
    );
  //     blocTest<WeatherCubit, WeatherState>(
  //       'calls getWeather with correct city',
  //       build: () => weatherCubit,
  //       act: (cubit) => cubit.fetchWeather(weatherLocation),
  //       verify: (_) {
  //         verify(() => weatherRepository.getWeather(weatherLocation)).called(1);
  //       },
  //     );

    test('emits nothing when city is empty', ()  {
      final state = container.read(weatherNotifier.notifier);

      // final fetchWeather =  state.fetchWeather('').then((value){},  onError: (onError) {
      //   return Exception('oops');
      // } ).onError((error, stackTrace) =>  );
      //print(state.state);
     // Timer(const Duration(seconds: 2), () => print(state.state));

     // printOnFailure('Fail');
      //Timer(const Duration(seconds: 2), () => print(state.state));


      // expect(state.state, weatherState);
      }
    );

  //     blocTest<WeatherCubit, WeatherState>(
  //       'emits [loading, failure] when getWeather throws',
  //       setUp: () {
  //         when(
  //               () => weatherRepository.getWeather(any()),
  //         ).thenThrow(Exception('oops'));
  //       },
  //       build: () => weatherCubit,
  //       act: (cubit) => cubit.fetchWeather(weatherLocation),
  //       expect: () => <WeatherState>[
  //         WeatherState(status: WeatherStatus.loading),
  //         WeatherState(status: WeatherStatus.failure),
  //       ],
  //     );
  //
  //     blocTest<WeatherCubit, WeatherState>(
  //       'emits [loading, success] when getWeather returns (celsius)',
  //       build: () => weatherCubit,
  //       act: (cubit) => cubit.fetchWeather(weatherLocation),
  //       expect: () => <dynamic>[
  //         WeatherState(status: WeatherStatus.loading),
  //         isA<WeatherState>()
  //             .having((w) => w.status, 'status', WeatherStatus.success)
  //             .having(
  //               (w) => w.weather,
  //           'weather',
  //           isA<Weather>()
  //               .having((w) => w.lastUpdated, 'lastUpdated', isNotNull)
  //               .having((w) => w.condition, 'condition', weatherCondition)
  //               .having(
  //                 (w) => w.temperature,
  //             'temperature',
  //             Temperature(value: weatherTemperature),
  //           )
  //               .having((w) => w.location, 'location', weatherLocation),
  //         ),
  //       ],
  //     );
  //
  //     blocTest<WeatherCubit, WeatherState>(
  //       'emits [loading, success] when getWeather returns (fahrenheit)',
  //       build: () => weatherCubit,
  //       seed: () => WeatherState(temperatureUnits: TemperatureUnits.fahrenheit),
  //       act: (cubit) => cubit.fetchWeather(weatherLocation),
  //       expect: () => <dynamic>[
  //         WeatherState(
  //           status: WeatherStatus.loading,
  //           temperatureUnits: TemperatureUnits.fahrenheit,
  //         ),
  //         isA<WeatherState>()
  //             .having((w) => w.status, 'status', WeatherStatus.success)
  //             .having(
  //               (w) => w.weather,
  //           'weather',
  //           isA<Weather>()
  //               .having((w) => w.lastUpdated, 'lastUpdated', isNotNull)
  //               .having((w) => w.condition, 'condition', weatherCondition)
  //               .having(
  //                 (w) => w.temperature,
  //             'temperature',
  //             Temperature(value: weatherTemperature.toFahrenheit()),
  //           )
  //               .having((w) => w.location, 'location', weatherLocation),
  //         ),
  //       ],
  //     );
  //   });
  //
  //   group('refreshWeather', () {
  //     blocTest<WeatherCubit, WeatherState>(
  //       'emits nothing when status is not success',
  //       build: () => weatherCubit,
  //       act: (cubit) => cubit.refreshWeather(),
  //       expect: () => <WeatherState>[],
  //       verify: (_) {
  //         verifyNever(() => weatherRepository.getWeather(any()));
  //       },
  //     );
  //
  //     blocTest<WeatherCubit, WeatherState>(
  //       'emits nothing when location is null',
  //       build: () => weatherCubit,
  //       seed: () => WeatherState(status: WeatherStatus.success),
  //       act: (cubit) => cubit.refreshWeather(),
  //       expect: () => <WeatherState>[],
  //       verify: (_) {
  //         verifyNever(() => weatherRepository.getWeather(any()));
  //       },
  //     );
  //
  //     blocTest<WeatherCubit, WeatherState>(
  //       'invokes getWeather with correct location',
  //       build: () => weatherCubit,
  //       seed: () => WeatherState(
  //         status: WeatherStatus.success,
  //         weather: Weather(
  //           location: weatherLocation,
  //           temperature: Temperature(value: weatherTemperature),
  //           lastUpdated: DateTime(2020),
  //           condition: weatherCondition,
  //         ),
  //       ),
  //       act: (cubit) => cubit.refreshWeather(),
  //       verify: (_) {
  //         verify(() => weatherRepository.getWeather(weatherLocation)).called(1);
  //       },
  //     );
  //
  //     blocTest<WeatherCubit, WeatherState>(
  //       'emits nothing when exception is thrown',
  //       setUp: () {
  //         when(
  //               () => weatherRepository.getWeather(any()),
  //         ).thenThrow(Exception('oops'));
  //       },
  //       build: () => weatherCubit,
  //       seed: () => WeatherState(
  //         status: WeatherStatus.success,
  //         weather: Weather(
  //           location: weatherLocation,
  //           temperature: Temperature(value: weatherTemperature),
  //           lastUpdated: DateTime(2020),
  //           condition: weatherCondition,
  //         ),
  //       ),
  //       act: (cubit) => cubit.refreshWeather(),
  //       expect: () => <WeatherState>[],
  //     );
  //
  //     blocTest<WeatherCubit, WeatherState>(
  //       'emits updated weather (celsius)',
  //       build: () => weatherCubit,
  //       seed: () => WeatherState(
  //         status: WeatherStatus.success,
  //         weather: Weather(
  //           location: weatherLocation,
  //           temperature: Temperature(value: 0),
  //           lastUpdated: DateTime(2020),
  //           condition: weatherCondition,
  //         ),
  //       ),
  //       act: (cubit) => cubit.refreshWeather(),
  //       expect: () => <Matcher>[
  //         isA<WeatherState>()
  //             .having((w) => w.status, 'status', WeatherStatus.success)
  //             .having(
  //               (w) => w.weather,
  //           'weather',
  //           isA<Weather>()
  //               .having((w) => w.lastUpdated, 'lastUpdated', isNotNull)
  //               .having((w) => w.condition, 'condition', weatherCondition)
  //               .having(
  //                 (w) => w.temperature,
  //             'temperature',
  //             Temperature(value: weatherTemperature),
  //           )
  //               .having((w) => w.location, 'location', weatherLocation),
  //         ),
  //       ],
  //     );
  //
  //     blocTest<WeatherCubit, WeatherState>(
  //       'emits updated weather (fahrenheit)',
  //       build: () => weatherCubit,
  //       seed: () => WeatherState(
  //         temperatureUnits: TemperatureUnits.fahrenheit,
  //         status: WeatherStatus.success,
  //         weather: Weather(
  //           location: weatherLocation,
  //           temperature: Temperature(value: 0),
  //           lastUpdated: DateTime(2020),
  //           condition: weatherCondition,
  //         ),
  //       ),
  //       act: (cubit) => cubit.refreshWeather(),
  //       expect: () => <Matcher>[
  //         isA<WeatherState>()
  //             .having((w) => w.status, 'status', WeatherStatus.success)
  //             .having(
  //               (w) => w.weather,
  //           'weather',
  //           isA<Weather>()
  //               .having((w) => w.lastUpdated, 'lastUpdated', isNotNull)
  //               .having((w) => w.condition, 'condition', weatherCondition)
  //               .having(
  //                 (w) => w.temperature,
  //             'temperature',
  //             Temperature(value: weatherTemperature.toFahrenheit()),
  //           )
  //               .having((w) => w.location, 'location', weatherLocation),
  //         ),
  //       ],
  //     );
  //   });
  //
  //   group('toggleUnits', () {
  //     blocTest<WeatherCubit, WeatherState>(
  //       'emits updated units when status is not success',
  //       build: () => weatherCubit,
  //       act: (cubit) => cubit.toggleUnits(),
  //       expect: () => <WeatherState>[
  //         WeatherState(temperatureUnits: TemperatureUnits.fahrenheit),
  //       ],
  //     );
  //
  //     blocTest<WeatherCubit, WeatherState>(
  //       'emits updated units and temperature '
  //           'when status is success (celsius)',
  //       build: () => weatherCubit,
  //       seed: () => WeatherState(
  //         status: WeatherStatus.success,
  //         temperatureUnits: TemperatureUnits.fahrenheit,
  //         weather: Weather(
  //           location: weatherLocation,
  //           temperature: Temperature(value: weatherTemperature),
  //           lastUpdated: DateTime(2020),
  //           condition: WeatherCondition.rainy,
  //         ),
  //       ),
  //       act: (cubit) => cubit.toggleUnits(),
  //       expect: () => <WeatherState>[
  //         WeatherState(
  //           status: WeatherStatus.success,
  //           weather: Weather(
  //             location: weatherLocation,
  //             temperature: Temperature(value: weatherTemperature.toCelsius()),
  //             lastUpdated: DateTime(2020),
  //             condition: WeatherCondition.rainy,
  //           ),
  //         ),
  //       ],
  //     );
  //
  //     blocTest<WeatherCubit, WeatherState>(
  //       'emits updated units and temperature '
  //           'when status is success (fahrenheit)',
  //       build: () => weatherCubit,
  //       seed: () => WeatherState(
  //         status: WeatherStatus.success,
  //         weather: Weather(
  //           location: weatherLocation,
  //           temperature: Temperature(value: weatherTemperature),
  //           lastUpdated: DateTime(2020),
  //           condition: WeatherCondition.rainy,
  //         ),
  //       ),
  //       act: (cubit) => cubit.toggleUnits(),
  //       expect: () => <WeatherState>[
  //         WeatherState(
  //           status: WeatherStatus.success,
  //           temperatureUnits: TemperatureUnits.fahrenheit,
  //           weather: Weather(
  //             location: weatherLocation,
  //             temperature: Temperature(
  //               value: weatherTemperature.toFahrenheit(),
  //             ),
  //             lastUpdated: DateTime(2020),
  //             condition: WeatherCondition.rainy,
  //           ),
  //         ),
  //       ],
  //     );
  //   });
  // });
});
}

extension on double {
  double toFahrenheit() => (this * 9 / 5) + 32;
  double toCelsius() => (this - 32) * 5 / 9;
}
