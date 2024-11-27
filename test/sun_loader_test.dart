import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('sunFire', () {
    testWidgets("SunLoader displays correctly", (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: SunLoader(
          color: Colors.red,
        ),
      ));

      expect(find.byType(SunLoader), findsOneWidget);
    });

    testWidgets("SunLoader throws error when radius is negative",
        (WidgetTester tester) async {
      expect(() {
        SunLoader(
          radius: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });

    testWidgets("SunLoader throws error when size is negative",
        (WidgetTester tester) async {
      expect(() {
        SunLoader(
          size: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });

    testWidgets("SunLoader throws error when duration is negative",
        (WidgetTester tester) async {
      expect(() {
        SunLoader(
          duration: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });

    testWidgets("SunLoader throws error when numPoints is negative",
        (WidgetTester tester) async {
      expect(() {
        SunLoader(
          numPoints: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });

    testWidgets("SunLoader throws error when speed is negative",
        (WidgetTester tester) async {
      expect(() {
        SunLoader(
          speed: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });
  });

  testWidgets("SunLoader animation runs as expected",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SunLoader(
        size: 80,
        color: Colors.orange,
        duration: 1500,
      ),
    ));

    final sunLoader = tester.widget<SunLoader>(find.byType(SunLoader));
    expect(sunLoader.size, 80);
    expect(sunLoader.color, Colors.orange);
    expect(sunLoader.duration, 1500);
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(SunLoader), findsOneWidget);
  });
}
