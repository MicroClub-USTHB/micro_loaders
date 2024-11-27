import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('ScaleDotsLoader', () {
    testWidgets('ScaleDotsLoader displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ScaleDotsLoader(
          color: Colors.white,
          size: 12,
        ),
      ));

      expect(find.byType(ScaleDotsLoader), findsOneWidget);
    });

    testWidgets(
      'ScaleDotsLoader throws assertion error when size is less than or equal to zero',
      (WidgetTester tester) async {
        expect(
          () => ScaleDotsLoader(
            size: 0,
            color: Colors.white,
            duration: 150,
          ),
          throwsAssertionError,
        );

        expect(
          () => ScaleDotsLoader(
            size: -1,
            color: Colors.white,
            duration: 150,
          ),
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'ScaleDotsLoader throws assertion error when duration is less than or equal to zero',
      (WidgetTester tester) async {
        expect(
          () => ScaleDotsLoader(
            size: 12,
            color: Colors.white,
            duration: 0,
          ),
          throwsAssertionError,
        );

        expect(
          () => ScaleDotsLoader(
            size: 12,
            color: Colors.white,
            duration: -1,
          ),
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'ScaleDotsLoader displays with default color when color is not provided',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: ScaleDotsLoader(
            size: 12,
          ),
        ));

        final scaleDotsLoader =
            tester.widget<ScaleDotsLoader>(find.byType(ScaleDotsLoader));
        expect(scaleDotsLoader.color, Colors.white);
      },
    );

    testWidgets(
      'ScaleDotsLoader animation runs as expected',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: ScaleDotsLoader(
            size: 12,
            color: Colors.white,
            duration: 150,
          ),
        ));

        final scaleDotsLoader =
            tester.widget<ScaleDotsLoader>(find.byType(ScaleDotsLoader));
        expect(scaleDotsLoader.size, 12);
        await tester.pump(const Duration(milliseconds: 75));
        expect(find.byType(ScaleDotsLoader), findsOneWidget);
      },
    );
  });
}
