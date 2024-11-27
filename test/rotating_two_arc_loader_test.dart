import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('RotatingTwoArcLoader', () {
    testWidgets('RotatingTwoArcLoader displays correctly',
        (WidgetTester tester) async {
      // Build the RotatingTwoArcLoader widget.
      await tester.pumpWidget(const MaterialApp(
        home: RotatingTwoArcLoader(
          arcSize: 80.0,
          arcWidth: 6.0,
          rotationDurationOuterMilliseconds: 2000,
          rotationDurationInnerMilliseconds: 1500,
          outerArcColor: Colors.blue,
          innerArcColor: Colors.orange,
        ),
      ));

      // Verify that the RotatingTwoArcLoader widget is displayed.
      expect(find.byType(RotatingTwoArcLoader), findsOneWidget);
    });

    testWidgets(
      'RotatingTwoArcLoader throws assertion error when arcSize is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingTwoArcLoader(
              arcSize: 0,
              arcWidth: 6.0,
              rotationDurationOuterMilliseconds: 2000,
              rotationDurationInnerMilliseconds: 1500,
              outerArcColor: Colors.blue,
              innerArcColor: Colors.orange,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'RotatingTwoArcLoader throws assertion error when arcWidth is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingTwoArcLoader(
              arcSize: 80.0,
              arcWidth: 0,
              rotationDurationOuterMilliseconds: 2000,
              rotationDurationInnerMilliseconds: 1500,
              outerArcColor: Colors.blue,
              innerArcColor: Colors.orange,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'RotatingTwoArcLoader throws assertion error when rotationDurationOuterMilliseconds is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingTwoArcLoader(
              arcSize: 80.0,
              arcWidth: 6.0,
              rotationDurationOuterMilliseconds: 0,
              rotationDurationInnerMilliseconds: 1500,
              outerArcColor: Colors.blue,
              innerArcColor: Colors.orange,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'RotatingTwoArcLoader throws assertion error when rotationDurationInnerMilliseconds is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            RotatingTwoArcLoader(
              arcSize: 80.0,
              arcWidth: 6.0,
              rotationDurationOuterMilliseconds: 2000,
              rotationDurationInnerMilliseconds: 0,
              outerArcColor: Colors.blue,
              innerArcColor: Colors.orange,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets('RotatingTwoArcLoader displays with custom colors',
        (WidgetTester tester) async {
      // Build the RotatingTwoArcLoader widget with custom colors.
      await tester.pumpWidget(const MaterialApp(
        home: RotatingTwoArcLoader(
          arcSize: 80.0,
          arcWidth: 6.0,
          rotationDurationOuterMilliseconds: 2000,
          rotationDurationInnerMilliseconds: 1500,
          outerArcColor: Colors.green,
          innerArcColor: Colors.red,
        ),
      ));

      // Verify that the RotatingTwoArcLoader widget is displayed.
      expect(find.byType(RotatingTwoArcLoader), findsOneWidget);

      // You can also test if the colors are set correctly by using tester to inspect the widget's paint
      // This requires using the tester to interact with the widget's rendered visual elements, which is not possible with simple widget tests
    });
  });
}
