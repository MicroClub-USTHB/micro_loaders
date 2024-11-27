import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('spiraling', () {
    testWidgets("SpiralLoader displays correctly", (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: SpiralLoader(
          color: Colors.red,
        ),
      ));

      expect(find.byType(SpiralLoader), findsOneWidget);
    });

    testWidgets("SpiralLoader throws error when radius is negative",
        (WidgetTester tester) async {
      expect(() {
        SpiralLoader(
          radius: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });
    testWidgets("SpiralLoader throws error when size is negative",
        (WidgetTester tester) async {
      expect(() {
        SpiralLoader(
          radius: 10,
          size: -23,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });
    testWidgets("SpiralLoader throws error when duration is negative",
        (WidgetTester tester) async {
      expect(() {
        SpiralLoader(
          radius: 12,
          duration: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });

    testWidgets("SpiralLoader throws error when spiralLength is negative",
        (WidgetTester tester) async {
      expect(() {
        SpiralLoader(
          spiralLength: -31,
        );
      }, throwsAssertionError);
    });
  });

  testWidgets("SpiralLoader animation runs as expected",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: SpiralLoader(
        size: 80,
        color: Colors.orange,
        duration: 1500,
      ),
    ));

    final spiralLoader = tester.widget<SpiralLoader>(find.byType(SpiralLoader));
    expect(spiralLoader.size, 80);
    expect(spiralLoader.color, Colors.orange);
    expect(spiralLoader.duration, 1500);
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(SpiralLoader), findsOneWidget);
  });
}
