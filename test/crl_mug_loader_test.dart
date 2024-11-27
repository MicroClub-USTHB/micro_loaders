import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('CrlMugLoader', () {
    testWidgets('CrlMugLoader displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: CrlMugLoader(
          size: 80,
          primaryColor: Colors.white,
          secondaryColor: Colors.red,
          backgroundColor: Colors.black,
          strokeWidth: 20,
          duration: 1500,
        ),
      ));

      expect(find.byType(CrlMugLoader), findsOneWidget);
    });

    testWidgets(
      'CrlMugLoader throws assertion error when size is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            CrlMugLoader(
              size: 0,
              primaryColor: Colors.white,
              secondaryColor: Colors.red,
              backgroundColor: Colors.black,
              strokeWidth: 20,
              duration: 1500,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'CrlMugLoader throws assertion error when strokeWidth is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            CrlMugLoader(
              size: 80,
              primaryColor: Colors.white,
              secondaryColor: Colors.red,
              backgroundColor: Colors.black,
              strokeWidth: 0,
              duration: 1500,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'CrlMugLoader throws assertion error when strokeWidth is greater than size/3',
      (WidgetTester tester) async {
        expect(
          () {
            CrlMugLoader(
              size: 80,
              primaryColor: Colors.white,
              secondaryColor: Colors.red,
              backgroundColor: Colors.black,
              strokeWidth: 30,
              duration: 1500,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'CrlMugLoader throws assertion error when duration is less than or equal to 1000',
      (WidgetTester tester) async {
        expect(
          () {
            CrlMugLoader(
              size: 80,
              primaryColor: Colors.white,
              secondaryColor: Colors.red,
              backgroundColor: Colors.black,
              strokeWidth: 20,
              duration: 1000,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets('CrlMugLoader animates properly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: CrlMugLoader(
          size: 80,
          primaryColor: Colors.white,
          secondaryColor: Colors.red,
          backgroundColor: Colors.black,
          strokeWidth: 20,
          duration: 1500,
        ),
      ));

      await tester.pump(const Duration(milliseconds: 750));

      expect(find.byType(CrlMugLoader), findsOneWidget);
    });
  });
}
