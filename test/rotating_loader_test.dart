import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('RotatingLoader', () {
    testWidgets('RotatingLoader displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: RotatingLoader(
          color: Colors.white,
          radius: 7,
          size: 50,
          duration: 1,
        ),
      ));

      expect(find.byType(RotatingLoader), findsOneWidget);
    });

    testWidgets(
      'RotatingLoader throws assertion error when size is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingLoader(
              size: 0,
              color: Colors.white,
              radius: 7,
              duration: 1,
            );
          },
          throwsAssertionError,
        );

        expect(
          () {
            RotatingLoader(
              size: -1,
              color: Colors.white,
              radius: 7,
              duration: 1,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'RotatingLoader throws assertion error when radius is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingLoader(
              size: 50,
              color: Colors.white,
              radius: 0,
              duration: 1,
            );
          },
          throwsAssertionError,
        );

        expect(
          () {
            RotatingLoader(
              size: 50,
              color: Colors.white,
              radius: -1,
              duration: 1,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'RotatingLoader throws assertion error when radius is greater than size / 6',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingLoader(
              size: 50,
              color: Colors.white,
              radius: 10,
              duration: 1,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'RotatingLoader throws assertion error when duration is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingLoader(
              size: 50,
              color: Colors.white,
              radius: 7,
              duration: 0,
            );
          },
          throwsAssertionError,
        );

        expect(
          () {
            RotatingLoader(
              size: 50,
              color: Colors.white,
              radius: 7,
              duration: -1,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'RotatingLoader uses default color when color is not provided',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: RotatingLoader(
            size: 50,
            radius: 7,
            duration: 1,
          ),
        ));

        final rotatingLoader =
            tester.widget<RotatingLoader>(find.byType(RotatingLoader));
        expect(rotatingLoader.color, Colors.white);
      },
    );

    testWidgets(
      'RotatingLoader animation runs as expected',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: RotatingLoader(
            size: 50,
            color: Colors.white,
            radius: 7,
            duration: 1,
          ),
        ));

        final rotatingLoader =
            tester.widget<RotatingLoader>(find.byType(RotatingLoader));
        expect(rotatingLoader.size, 50);
        expect(rotatingLoader.duration, 1);

        await tester.pump(const Duration(milliseconds: 500));
        expect(find.byType(RotatingLoader), findsOneWidget);
      },
    );
  });
}
