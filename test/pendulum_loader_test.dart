import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/widgets/pendulum_loader.dart';

void main() {
  group('PendulumLoader', () {
    testWidgets('PendulumLoader displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: PendulumLoader(
          duration: 500,
          size: 30,
          width: 2,
          color: Colors.white,
        ),
      ));

      expect(find.byType(PendulumLoader), findsOneWidget);
    });

    testWidgets(
      'PendulumLoader throws assertion error when duration is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            PendulumLoader(
              duration: 0,
              size: 30,
              width: 2,
              color: Colors.white,
            );
          },
          throwsAssertionError,
        );

        expect(
          () {
            PendulumLoader(
              duration: -1,
              size: 30,
              width: 2,
              color: Colors.white,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'PendulumLoader throws assertion error when size is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            PendulumLoader(
              duration: 500,
              size: 0,
              width: 2,
              color: Colors.white,
            );
          },
          throwsAssertionError,
        );

        expect(
          () {
            PendulumLoader(
              duration: 500,
              size: -1,
              width: 2,
              color: Colors.white,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'PendulumLoader throws assertion error when width is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            PendulumLoader(
              duration: 500,
              size: 30,
              width: 0,
              color: Colors.white,
            );
          },
          throwsAssertionError,
        );

        expect(
          () {
            PendulumLoader(
              duration: 500,
              size: 30,
              width: -1,
              color: Colors.white,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'PendulumLoader displays with default color when color is not provided',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: PendulumLoader(
            duration: 500,
            size: 30,
            width: 2,
          ),
        ));

        final pendulumLoader =
            tester.widget<PendulumLoader>(find.byType(PendulumLoader));
        expect(pendulumLoader.color, Colors.white);
      },
    );

    testWidgets('PendulumLoader animation runs as expected',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: PendulumLoader(
          duration: 500,
          size: 30,
          width: 2,
          color: Colors.white,
        ),
      ));

      expect(find.byType(Pendulum), findsNWidgets(5));

      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(Pendulum), findsNWidgets(5));

      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(Pendulum), findsNWidgets(5));
    });
  });
}
