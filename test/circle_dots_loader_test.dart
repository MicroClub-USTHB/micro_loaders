import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('CircleDotsLoader', () {
    testWidgets('CircleDotsLoader displays correctly',
        (WidgetTester tester) async {
      // Build the CircleDotsLoader widget.
      await tester.pumpWidget(const MaterialApp(
        home: CircleDotsLoader(
          color: Colors.white,
        ),
      ));

      // Verify that the CircleDotsLoader widget is displayed.
      expect(find.byType(CircleDotsLoader), findsOneWidget);
    });

    testWidgets(
      'CircleDotsLoader throws assertion error when size is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            CircleDotsLoader(
              size: 0,
              color: Colors.white,
            );
          },
          throwsAssertionError,
        );
        expect(
          () {
            CircleDotsLoader(
              size: -1,
              color: Colors.white,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'CircleDotsLoader throws assertion error when duration is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            CircleDotsLoader(
              size: 100,
              color: Colors.white,
              duration: 0,
            );
          },
          throwsAssertionError,
        );
        expect(
          () {
            CircleDotsLoader(
              size: 100,
              color: Colors.white,
              duration: -1,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'CircleDotsLoader displays with default color when color is not provided',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: CircleDotsLoader(
            size: 100,
          ),
        ));

        final circleDotsLoader =
            tester.widget<CircleDotsLoader>(find.byType(CircleDotsLoader));
        expect(circleDotsLoader.color, Colors.white);
      },
    );

    testWidgets(
      'CircleDotsLoader animation runs as expected',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: CircleDotsLoader(
            size: 100,
            color: Colors.blue,
            duration: 1,
          ),
        ));

        expect(find.byType(CircleDotsLoader), findsOneWidget);

        await tester.pump(const Duration(milliseconds: 500));
        expect(find.byType(CircleDotsLoader), findsOneWidget);

        await tester.pump(const Duration(seconds: 1));
        expect(find.byType(CircleDotsLoader), findsOneWidget);
      },
    );
  });
}
