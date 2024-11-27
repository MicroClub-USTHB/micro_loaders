import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/widgets/sunshine_loader.dart';

void main() {
  group('SunchineFire', () {
    testWidgets("SunchineLoader displays correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: SunshineLoader(
          color: Colors.red,
        ),
      ));

      expect(find.byType(SunshineLoader), findsOneWidget);
    });

    testWidgets("SunshineLoader throws error when radius is negative",
        (WidgetTester tester) async {
      expect(() {
        SunshineLoader(
          radius: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });

    testWidgets("SunshineLoader throws error when size is negative",
        (WidgetTester tester) async {
      expect(() {
        SunshineLoader(
          size: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });

    testWidgets("SunshineLoader throws error when duration is negative",
        (WidgetTester tester) async {
      expect(() {
        SunshineLoader(
          duration: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });

    testWidgets("SunshineLoader throws error when numPoints is negative",
        (WidgetTester tester) async {
      expect(() {
        SunshineLoader(
          numRays: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });

    testWidgets("SunshineLoader throws error when speed is negative",
        (WidgetTester tester) async {
      expect(() {
        SunshineLoader(
          speed: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });
  });

  testWidgets("SunshineLoader animation runs as expected",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SunshineLoader(
        size: 80,
        color: Colors.orange,
        duration: 1500,
      ),
    ));

    final sunshineLoader =
        tester.widget<SunshineLoader>(find.byType(SunshineLoader));
    expect(sunshineLoader.size, 80);
    expect(sunshineLoader.color, Colors.orange);
    expect(sunshineLoader.duration, 1500);
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(SunshineLoader), findsOneWidget);
  });
}
