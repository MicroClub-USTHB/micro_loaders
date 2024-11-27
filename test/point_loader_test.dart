import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('ChasingDots', () {
    testWidgets('PointsLoader displays correctly', (WidgetTester tester) async {
      // Build the PointsLoader widget.
      await tester.pumpWidget(const MaterialApp(
        home: PointsLoader(
          color: Colors.orange,
        ),
      ));

      // verify that the PointsLoader widget is displayed.
      expect(find.byType(PointsLoader), findsOneWidget);
    });

    testWidgets(
      'PointsLoader throws assertion error when size is less than 0',
      (WidgetTester tester) async {
        expect(
          () {
            PointsLoader(
              size: -1,
              color: Colors.orange,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'PointsLoader throws assertion error when strokeWidth is less than 0',
      (WidgetTester tester) async {
        expect(
          () {
            PointsLoader(
              size: 80,
              color: Colors.orange,
              strokeWidth: -1,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'PointsLoader throws assertion error when strokeWidth is greater than size / 12',
      (WidgetTester tester) async {
        expect(
          () {
            PointsLoader(
              size: 80,
              color: Colors.orange,
              strokeWidth: 7,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'PointsLoader throws assertion error when duration is less than 1000',
      (WidgetTester tester) async {
        expect(
          () {
            PointsLoader(
              size: 80,
              color: Colors.orange,
              duration: 999,
            );
          },
          throwsAssertionError,
        );
      },
    );
  });
}
