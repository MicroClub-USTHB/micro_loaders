import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('RotatingDualHalfArcLoader', () {
    testWidgets('RotatingDualHalfArcLoader displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: RotatingDualHalfArcLoader(
            size: 48.0,
            strokeWidth: 5.0,
            color: Colors.red,
            rotationDurationMs: 1000,
          ),
        ),
      ));

      expect(find.byType(RotatingDualHalfArcLoader), findsOneWidget);
    });

    testWidgets(
      'RotatingDualHalfArcLoader throws assertion error when size is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingDualHalfArcLoader(
              size: 0,
              strokeWidth: 5.0,
              color: Colors.red,
              rotationDurationMs: 1000,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'RotatingDualHalfArcLoader throws assertion error when strokeWidth is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingDualHalfArcLoader(
              size: 48.0,
              strokeWidth: 0,
              color: Colors.red,
              rotationDurationMs: 1000,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'RotatingDualHalfArcLoader throws assertion error when strokeWidth is greater than size / 3',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingDualHalfArcLoader(
              size: 48.0,
              strokeWidth: 20.0,
              color: Colors.red,
              rotationDurationMs: 1000,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'RotatingDualHalfArcLoader throws assertion error when rotationDurationMs is less than 500 milliseconds',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingDualHalfArcLoader(
              size: 48.0,
              strokeWidth: 5.0,
              color: Colors.red,
              rotationDurationMs: 499,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets('RotatingDualHalfArcLoader respects custom properties',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: RotatingDualHalfArcLoader(
            size: 60.0,
            strokeWidth: 6.0,
            color: Colors.blue,
            rotationDurationMs: 1500,
          ),
        ),
      ));

      final loader = tester.widget<RotatingDualHalfArcLoader>(
          find.byType(RotatingDualHalfArcLoader));
      expect(loader.size, 60.0);
      expect(loader.strokeWidth, 6.0);
      expect(loader.color, Colors.blue);
      expect(loader.rotationDurationMs, 1500);
    });
  });
}
