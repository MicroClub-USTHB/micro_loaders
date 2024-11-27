import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('ProgressLoader', () {
    testWidgets('ProgressLoader displays correctly',
        (WidgetTester tester) async {
      // Build the ProgressLoader widget.
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: ProgressLoader(
            width: 120,
            height: 22,
            borderColor: Colors.blue,
            progressColor: Colors.blue,
          ),
        ),
      ));

      // Verify that the ProgressLoader widget is displayed.
      expect(find.byType(ProgressLoader), findsOneWidget);
    });

    testWidgets(
      'ProgressLoader throws assertion error when width is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            ProgressLoader(
              width: 0,
              height: 22,
              borderColor: Colors.blue,
              progressColor: Colors.blue,
            );
          },
          throwsAssertionError,
        );

        expect(
          () {
            ProgressLoader(
              width: -1,
              height: 22,
              borderColor: Colors.blue,
              progressColor: Colors.blue,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'ProgressLoader throws assertion error when height is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            ProgressLoader(
              width: 120,
              height: 0,
              borderColor: Colors.blue,
              progressColor: Colors.blue,
            );
          },
          throwsAssertionError,
        );

        expect(
          () {
            ProgressLoader(
              width: 120,
              height: -1,
              borderColor: Colors.blue,
              progressColor: Colors.blue,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'ProgressLoader throws assertion error when duration is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            ProgressLoader(
              width: 120,
              height: 22,
              duration: 0,
              borderColor: Colors.blue,
              progressColor: Colors.blue,
            );
          },
          throwsAssertionError,
        );

        expect(
          () {
            ProgressLoader(
              width: 120,
              height: 22,
              duration: -1,
              borderColor: Colors.blue,
              progressColor: Colors.blue,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets('ProgressLoader starts with the correct progress color',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: ProgressLoader(
            width: 120,
            height: 22,
            duration: 2,
            borderColor: Colors.blue,
            progressColor: Colors.red,
          ),
        ),
      ));

      final progressIndicator =
          tester.widget<Container>(find.byType(Container).at(1));
      expect(
        (progressIndicator.decoration as BoxDecoration).color,
        Colors.red,
      );
    });

    testWidgets('ProgressLoader loops animation correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: ProgressLoader(
            width: 120,
            height: 22,
            duration: 2,
            borderColor: Colors.blue,
            progressColor: Colors.blue,
          ),
        ),
      ));

      await tester.pump(const Duration(seconds: 2));

      var positionAfterOneCycle =
          tester.getTopLeft(find.byType(Container).at(1)).dx;

      await tester.pump(const Duration(seconds: 1));
      var positionMidSecondCycle =
          tester.getTopLeft(find.byType(Container).at(1)).dx;
      expect(positionMidSecondCycle, greaterThan(positionAfterOneCycle));
    });
  });
}
