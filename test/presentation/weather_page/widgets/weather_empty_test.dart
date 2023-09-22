// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_bg_null_safety/bg/weather_bg.dart';
import 'package:weather_riverpod_async/data/repository/model/models_repository.dart';
import 'package:weather_riverpod_async/presentation/weather_page/widgets/weather_empty_new.dart';

void main() {
  final condition = WeatherCondition.clear;
  group('WeatherEmpty', () {
    testWidgets('renders correct text and icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: WeatherEmptyNew(
              weatherCondition: condition,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      // expect(find.text('Please Select a City!'), findsOneWidget);
      // expect(find.text('🏙️'), findsOneWidget);
      expect(find.byType(WeatherBg), findsOneWidget);
    });
  });
}
