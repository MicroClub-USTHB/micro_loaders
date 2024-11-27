import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('DotsProgressLoader', () {
    testWidgets('DotsProgressLoader displays correctly',
        (WidgetTester tester) async {
      // Build the DotsProgressLoader widget.
      await tester.pumpWidget(const MaterialApp(
        home: DotsProgressLoader(
          initialColor: Colors.grey,
          secondColor: Colors.white,
          duration: 2,
          size: 17,
        ),
      ));

      // Verify that the DotsProgressLoader widget is displayed.
      expect(find.byType(DotsProgressLoader), findsOneWidget);
    });

    testWidgets(
      'DotsProgressLoader throws assertion error when size is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            DotsProgressLoader(
              initialColor: Colors.grey,
              secondColor: Colors.white,
              duration: 2,
              size: 0,
            );
          },
          throwsAssertionError,
        );

        expect(
          () {
            DotsProgressLoader(
              initialColor: Colors.grey,
              secondColor: Colors.white,
              duration: 2,
              size: -1,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'DotsProgressLoader throws assertion error when duration is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            DotsProgressLoader(
              initialColor: Colors.grey,
              secondColor: Colors.white,
              duration: 0,
              size: 17,
            );
          },
          throwsAssertionError,
        );

        expect(
          () {
            DotsProgressLoader(
              initialColor: Colors.grey,
              secondColor: Colors.white,
              duration: -1,
              size: 17,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets('DotsProgressLoader dots have initial color',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: DotsProgressLoader(
          initialColor: Colors.grey,
          secondColor: Colors.white,
          duration: 2,
          size: 17,
        ),
      ));

      for (final dot in tester.widgetList<Container>(find.byType(Container))) {
        final decoration = dot.decoration as BoxDecoration;
        expect(decoration.color, Colors.grey);
      }
    });

    testWidgets(
      'DotsProgressLoader animation runs as expected',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: DotsProgressLoader(
            initialColor: Colors.grey,
            secondColor: Colors.white,
            duration: 2,
            size: 17,
          ),
        ));

        expect(find.byType(DotsProgressLoader), findsOneWidget);

        // Capture initial state of the first dot
        final initialDot =
            tester.widget<Container>(find.byType(Container).first);
        final initialColor = (initialDot.decoration as BoxDecoration).color;

        // Advance the animation halfway through (1 second if duration is 2 seconds)
        await tester.pump(const Duration(seconds: 1));

        // Capture the state of the first dot again to check if color has changed
        final animatedDot =
            tester.widget<Container>(find.byType(Container).first);
        final animatedColor = (animatedDot.decoration as BoxDecoration).color;

        // Verify that the color changes, indicating animation
        expect(animatedColor, isNot(equals(initialColor)));

        // Pump to end of animation cycle
        await tester.pump(const Duration(seconds: 1));

        // Check if animation cycles back to the initial color
        final endDot = tester.widget<Container>(find.byType(Container).first);
        final endColor = (endDot.decoration as BoxDecoration).color;
        expect(endColor, equals(initialColor));
      },
    );
  });
}
