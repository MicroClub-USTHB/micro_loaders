import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('explode', () {
    testWidgets("ExplosionLoader displays correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ExplosionLoader(
          color: Colors.red,
        ),
      ));

      expect(find.byType(ExplosionLoader), findsOneWidget);
    });

    testWidgets("ExplosionLoader throws error when radius is negative",
        (WidgetTester tester) async {
      expect(() {
        ExplosionLoader(
          radius: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });
    testWidgets("ExplosionLoader throws error when size is negative",
        (WidgetTester tester) async {
      expect(() {
        ExplosionLoader(
          radius: 10,
          size: -23,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });
    testWidgets("ExplosionLoader throws error when duration is negative",
        (WidgetTester tester) async {
      expect(() {
        ExplosionLoader(
          radius: 12,
          duration: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });

    testWidgets("ExplosionLoader throws error when xInterval is negative",
        (WidgetTester tester) async {
      expect(() {
        ExplosionLoader(
          radius: 12,
          duration: 1,
          xInterval: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });

    testWidgets("ExplosionLoader throws error when yMax is negative",
        (WidgetTester tester) async {
      expect(() {
        ExplosionLoader(
          radius: 12,
          yMax: -1,
          color: Colors.blue,
        );
      }, throwsAssertionError);
    });
  });

  testWidgets("ExplosionLoader animation runs as expected",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: ExplosionLoader(
        size: 80,
        color: Colors.orange,
        duration: 1500,
      ),
    ));

    final explosionLoader =
        tester.widget<ExplosionLoader>(find.byType(ExplosionLoader));
    expect(explosionLoader.size, 80);
    expect(explosionLoader.color, Colors.orange);
    expect(explosionLoader.duration, 1500);
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(ExplosionLoader), findsOneWidget);
  });
}
