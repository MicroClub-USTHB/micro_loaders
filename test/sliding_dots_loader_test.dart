import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('SlidingDotsLoader', () {
    testWidgets('SlidingDotsLoader displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: SlidingDotsLoader(
          size: 10,
          color: Colors.white,
          duration: 3,
        ),
      ));

      expect(find.byType(SlidingDotsLoader), findsOneWidget);
    });

    testWidgets(
        'SlidingDotsLoader throws assertion error when size is less than or equal to 0',
        (WidgetTester tester) async {
      expect(
        () {
          SlidingDotsLoader(
            size: 0,
            color: Colors.white,
            duration: 3,
          );
        },
        throwsAssertionError,
      );
      expect(
        () {
          SlidingDotsLoader(
            size: -1,
            color: Colors.white,
            duration: 3,
          );
        },
        throwsAssertionError,
      );
    });

    testWidgets(
        'SlidingDotsLoader throws assertion error when duration is less than or equal to 0',
        (WidgetTester tester) async {
      expect(
        () {
          SlidingDotsLoader(
            size: 10,
            color: Colors.white,
            duration: 0,
          );
        },
        throwsAssertionError,
      );
      expect(
        () {
          SlidingDotsLoader(
            size: 10,
            color: Colors.white,
            duration: -1,
          );
        },
        throwsAssertionError,
      );
    });

    testWidgets(
        'SlidingDotsLoader displays with default color when color is not provided',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: SlidingDotsLoader(
          size: 10,
          duration: 3,
        ),
      ));

      final slidingDotsLoader =
          tester.widget<SlidingDotsLoader>(find.byType(SlidingDotsLoader));
      expect(slidingDotsLoader.color, Colors.white);
    });

    testWidgets('SlidingDotsLoader animation runs as expected',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: SlidingDotsLoader(
          size: 10,
          color: Colors.white,
          duration: 3,
        ),
      ));

      expect(find.byType(SlidingDotsLoader), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.byType(SlidingDotsLoader), findsOneWidget);
    });
  });
}
