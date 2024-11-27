import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('DualExpandingArcLoader', () {
    testWidgets('DualExpandingArcLoader displays correctly',
        (WidgetTester tester) async {
      // Build the DualExpandingArcLoader widget.
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: Center(
            child: DualExpandingArcLoader(
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

      // Verify that the DualExpandingArcLoader widget is displayed.
      expect(find.byType(DualExpandingArcLoader), findsOneWidget);
    });

    testWidgets(
        'DualExpandingArcLoader throws assertion error when size is less than or equal to 0',
        (WidgetTester tester) async {
      expect(
        () {
          DualExpandingArcLoader(
            size: 0,
            strokeWidth: 5.0,
          );
        },
        throwsAssertionError,
      );
    });

    testWidgets(
        'DualExpandingArcLoader throws assertion error when strokeWidth is less than or equal to 0',
        (WidgetTester tester) async {
      expect(
        () {
          DualExpandingArcLoader(
            size: 80,
            strokeWidth: 0,
          );
        },
        throwsAssertionError,
      );
    });

    testWidgets(
        'DualExpandingArcLoader throws assertion error when strokeWidth is greater than size / 3',
        (WidgetTester tester) async {
      expect(
        () {
          DualExpandingArcLoader(
            size: 90,
            strokeWidth: 31,
          );
        },
        throwsAssertionError,
      );
    });

    testWidgets(
        'DualExpandingArcLoader throws assertion error when rotationDurationMs is less than 500',
        (WidgetTester tester) async {
      expect(
        () {
          DualExpandingArcLoader(
            size: 80,
            rotationDurationMs: 400,
          );
        },
        throwsAssertionError,
      );
    });

    testWidgets(
        'DualExpandingArcLoader throws assertion error when animationDurationMs is less than 1000',
        (WidgetTester tester) async {
      expect(
        () {
          DualExpandingArcLoader(
            size: 80,
            animationDurationMs: 900,
          );
        },
        throwsAssertionError,
      );
    });
  });
}
