import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('ExpandingArcLoader', () {
    testWidgets('ExpandingArcLoader displays correctly',
        (WidgetTester tester) async {
      // Build the ExpandingArcLoader widget.
      await tester.pumpWidget(const MaterialApp(
        home: ExpandingArcLoader(
          color: Colors.blue,
        ),
      ));

      // Verify that the ExpandingArcLoader widget is displayed.
      expect(find.byType(ExpandingArcLoader), findsOneWidget);
    });

    testWidgets(
        'ExpandingArcLoader throws assertion error when size is less than or equal to 0',
        (WidgetTester tester) async {
      expect(
        () {
          ExpandingArcLoader(
            size: 0,
            color: Colors.blue,
          );
        },
        throwsAssertionError,
      );
    });

    testWidgets(
        'ExpandingArcLoader throws assertion error when strokeWidth is less than or equal to 0',
        (WidgetTester tester) async {
      expect(
        () {
          ExpandingArcLoader(
            size: 80,
            strokeWidth: 0,
            color: Colors.blue,
          );
        },
        throwsAssertionError,
      );
    });

    testWidgets(
        'ExpandingArcLoader throws assertion error when strokeWidth is greater than size / 3',
        (WidgetTester tester) async {
      expect(
        () {
          ExpandingArcLoader(
            size: 90,
            strokeWidth: 31,
            color: Colors.blue,
          );
        },
        throwsAssertionError,
      );
    });

    testWidgets(
        'ExpandingArcLoader throws assertion error when rotationDurationMs is less than 500',
        (WidgetTester tester) async {
      expect(
        () {
          ExpandingArcLoader(
            size: 80,
            rotationDurationMs: 400,
            color: Colors.blue,
          );
        },
        throwsAssertionError,
      );
    });

    testWidgets(
        'ExpandingArcLoader throws assertion error when expansionDurationMs is less than 1000',
        (WidgetTester tester) async {
      expect(
        () {
          ExpandingArcLoader(
            size: 80,
            expansionDurationMs: 900,
            color: Colors.blue,
          );
        },
        throwsAssertionError,
      );
    });
  });
}
