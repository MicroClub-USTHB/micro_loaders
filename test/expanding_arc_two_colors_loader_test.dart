import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('ExpandingArcTwoColorsLoader', () {
    testWidgets('ExpandingArcTwoColorsLoader displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: ExpandingArcTwoColorsLoader(
            size: 80,
            strokeWidth: 6,
            color1: Colors.blue,
            color2: Colors.red,
            rotationDurationMs: 1500,
            expansionDurationMs: 2000,
          ),
        ),
      ));

      // Verify that the ExpandingArcTwoColorsLoader widget is displayed.
      expect(find.byType(ExpandingArcTwoColorsLoader), findsOneWidget);
    });

    testWidgets(
      'ExpandingArcTwoColorsLoader throws assertion error when size is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            ExpandingArcTwoColorsLoader(
              size: -1,
              strokeWidth: 6,
              color1: Colors.blue,
              color2: Colors.red,
              rotationDurationMs: 1500,
              expansionDurationMs: 2000,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'ExpandingArcTwoColorsLoader throws assertion error when strokeWidth is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            ExpandingArcTwoColorsLoader(
              size: 80,
              strokeWidth: -1,
              color1: Colors.blue,
              color2: Colors.red,
              rotationDurationMs: 1500,
              expansionDurationMs: 2000,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'ExpandingArcTwoColorsLoader throws assertion error when strokeWidth is greater than size / 3',
      (WidgetTester tester) async {
        expect(
          () {
            ExpandingArcTwoColorsLoader(
              size: 80,
              strokeWidth: 30,
              color1: Colors.blue,
              color2: Colors.red,
              rotationDurationMs: 1500,
              expansionDurationMs: 2000,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'ExpandingArcTwoColorsLoader throws assertion error when rotationDurationMs is less than 500',
      (WidgetTester tester) async {
        expect(
          () {
            ExpandingArcTwoColorsLoader(
              size: 80,
              strokeWidth: 6,
              color1: Colors.blue,
              color2: Colors.red,
              rotationDurationMs: 499,
              expansionDurationMs: 2000,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'ExpandingArcTwoColorsLoader throws assertion error when expansionDurationMs is less than 1000',
      (WidgetTester tester) async {
        expect(
          () {
            ExpandingArcTwoColorsLoader(
              size: 80,
              strokeWidth: 6,
              color1: Colors.blue,
              color2: Colors.red,
              rotationDurationMs: 1500,
              expansionDurationMs: 999,
            );
          },
          throwsAssertionError,
        );
      },
    );
  });
}
