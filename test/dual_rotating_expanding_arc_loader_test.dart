import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('DualRotatingExpandingArcLoader', () {
    testWidgets('DualRotatingExpandingArcLoader displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Center(
            child: DualRotatingExpandingArcLoader(
              size: 48.0,
              strokeWidth: 5.0,
              innerColor: Colors.white,
              outerColor: Colors.red,
              rotationDurationMs: 1000,
              animationDurationMs: 2000,
            ),
          ),
        ),
      ));

      expect(find.byType(DualRotatingExpandingArcLoader), findsOneWidget);
    });

    testWidgets(
      'DualRotatingExpandingArcLoader throws assertion error when size is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            DualRotatingExpandingArcLoader(
              size: 0,
              strokeWidth: 5.0,
              innerColor: Colors.white,
              outerColor: Colors.red,
              rotationDurationMs: 1000,
              animationDurationMs: 2000,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'DualRotatingExpandingArcLoader throws assertion error when strokeWidth is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            DualRotatingExpandingArcLoader(
              size: 80,
              strokeWidth: 0,
              innerColor: Colors.white,
              outerColor: Colors.red,
              rotationDurationMs: 1000,
              animationDurationMs: 2000,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'DualRotatingExpandingArcLoader throws assertion error when strokeWidth is greater than size / 3',
      (WidgetTester tester) async {
        expect(
          () {
            DualRotatingExpandingArcLoader(
              size: 90,
              strokeWidth: 31,
              innerColor: Colors.white,
              outerColor: Colors.red,
              rotationDurationMs: 1000,
              animationDurationMs: 2000,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'DualRotatingExpandingArcLoader throws assertion error when rotationDurationMs is less than 500',
      (WidgetTester tester) async {
        expect(
          () {
            DualRotatingExpandingArcLoader(
              size: 80,
              strokeWidth: 5.0,
              innerColor: Colors.white,
              outerColor: Colors.red,
              rotationDurationMs: 400,
              animationDurationMs: 2000,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'DualRotatingExpandingArcLoader throws assertion error when animationDurationMs is less than 1000',
      (WidgetTester tester) async {
        expect(
          () {
            DualRotatingExpandingArcLoader(
              size: 80,
              strokeWidth: 5.0,
              innerColor: Colors.white,
              outerColor: Colors.red,
              rotationDurationMs: 1000,
              animationDurationMs: 900,
            );
          },
          throwsAssertionError,
        );
      },
    );
  });
}
