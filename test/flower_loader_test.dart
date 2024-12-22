// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('FlowerLoader', () {
    testWidgets('FlowerLoader displays correctly', (WidgetTester tester) async {
      // Build the FlowerLoader widget.
      await tester.pumpWidget(const MaterialApp(
        home: FlowerLoader(
          color: Colors.blue,
          size: 40,
          duration: 2000,
        ),
      ));

      // Verify that the FlowerLoader widget is displayed.
      expect(find.byType(FlowerLoader), findsOneWidget);
    });

    testWidgets(
      'FlowerLoader throws assertion error when size is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            FlowerLoader(
              size: -1,
              color: Colors.blue,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'FlowerLoader throws assertion error when duration is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            FlowerLoader(
              size: 40,
              color: Colors.blue,
              duration: 0,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets('FlowerLoader has correct color', (WidgetTester tester) async {
      const testColor = Color.fromARGB(255, 251, 103, 152);
      await tester.pumpWidget(MaterialApp(
        home: FlowerLoader(
          color: testColor,
          size: 40,
          duration: 2000,
        ),
      ));

      final coloredContainer =
          tester.widget<Container>(find.byType(Container).first);
      final decoration = coloredContainer.decoration as BoxDecoration;
      expect(decoration.color, testColor.withValues(
        alpha: 0.5
      ));
    });

    testWidgets('FlowerLoader animates correctly', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: FlowerLoader(
          color: Colors.blue,
          size: 40,
          duration: 2000,
        ),
      ));

      final initialPetalPosition =
          tester.getTopLeft(find.byType(Container).first);

      await tester.pump(const Duration(milliseconds: 1000));
      final midAnimationPosition =
          tester.getTopLeft(find.byType(Container).first);
      expect(midAnimationPosition, isNot(initialPetalPosition));

      await tester.pump(const Duration(milliseconds: 1000));

      final endAnimationPosition =
          tester.getTopLeft(find.byType(Container).first);
      expect(endAnimationPosition, isNot(midAnimationPosition));
    });
  });
}
