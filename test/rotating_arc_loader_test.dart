import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('RotatingArcLoader', () {
    testWidgets('RotatingArcLoader displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: RotatingArcLoader(
            size: 80,
            primaryColor: Colors.blue,
            secondaryColor: Colors.red,
            strokeWidth: 6,
            duration: 1500,
          ),
        ),
      ));

      expect(find.byType(RotatingArcLoader), findsOneWidget);
    });

    testWidgets(
      'RotatingArcLoader throws assertion error when size is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingArcLoader(
              size: -1,
              primaryColor: Colors.blue,
              secondaryColor: Colors.red,
              strokeWidth: 6,
              duration: 1500,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'RotatingArcLoader throws assertion error when strokeWidth is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingArcLoader(
              size: 80,
              primaryColor: Colors.blue,
              secondaryColor: Colors.red,
              strokeWidth: -1,
              duration: 1500,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'RotatingArcLoader throws assertion error when strokeWidth is greater than size / 12',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingArcLoader(
              size: 80,
              primaryColor: Colors.blue,
              secondaryColor: Colors.red,
              strokeWidth: 7,
              duration: 1500,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'RotatingArcLoader throws assertion error when duration is less than or equal to 1000',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingArcLoader(
              size: 80,
              primaryColor: Colors.blue,
              secondaryColor: Colors.red,
              strokeWidth: 6,
              duration: 999,
            );
          },
          throwsAssertionError,
        );
      },
    );
  });
}
