import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/widgets/circle_rotating_dots_loader.dart';

void main() {
  group('CircleRotatingDotsLoader', () {
    testWidgets("CircleRotatingDotsLoader renders correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: CircleRotatingDotsLoader(
          size: 48,
          color: Colors.white,
          dotColor: Colors.orange,
          dotSize: 6.0,
          duration: 1000,
        ),
      ));

      expect(find.byType(CircleRotatingDotsLoader), findsOneWidget);
    });

    testWidgets("CircleRotatingDotsLoader throws error when size is negative",
        (WidgetTester tester) async {
      expect(() {
        CircleRotatingDotsLoader(
          size: -1,
          color: Colors.white,
          dotColor: Colors.orange,
          dotSize: 6.0,
          duration: 1000,
        );
      }, throwsAssertionError);
    });

    testWidgets(
        "CircleRotatingDotsLoader throws error when dotSize is negative",
        (WidgetTester tester) async {
      expect(() {
        CircleRotatingDotsLoader(
          size: 48,
          color: Colors.white,
          dotColor: Colors.orange,
          dotSize: -1,
          duration: 1000,
        );
      }, throwsAssertionError);
    });

    testWidgets(
        "CircleRotatingDotsLoader throws error when duration is negative",
        (WidgetTester tester) async {
      expect(() {
        CircleRotatingDotsLoader(
          size: 48,
          color: Colors.white,
          dotColor: Colors.orange,
          dotSize: 6.0,
          duration: -1,
        );
      }, throwsAssertionError);
    });

    testWidgets("CircleRotatingDotsLoader animation runs as expected",
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: CircleRotatingDotsLoader(
          size: 48,
          color: Colors.white,
          dotColor: Colors.orange,
          dotSize: 6.0,
          duration: 1000,
        ),
      ));

      final loader = tester.widget<CircleRotatingDotsLoader>(
          find.byType(CircleRotatingDotsLoader));
      expect(loader.size, 48);
      expect(loader.color, Colors.white);
      expect(loader.dotColor, Colors.orange);
      expect(loader.dotSize, 6.0);
      expect(loader.duration, 1000);

      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(CircleRotatingDotsLoader), findsOneWidget);
    });
  });
}
