import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('FadeScaleLoader', () {
    testWidgets('FadeScaleLoader displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: FadeScaleLoader(
          color: Colors.white,
          size: 60,
          duration: 1,
        ),
      ));

      expect(find.byType(FadeScaleLoader), findsOneWidget);
    });

    testWidgets(
      'FadeScaleLoader throws assertion error when duration is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            FadeScaleLoader(
              duration: 0,
              color: Colors.white,
              size: 60,
            );
          },
          throwsAssertionError,
        );

        expect(
          () {
            FadeScaleLoader(
              duration: -1,
              color: Colors.white,
              size: 60,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'FadeScaleLoader throws assertion error when size is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            FadeScaleLoader(
              duration: 1,
              color: Colors.white,
              size: 0,
            );
          },
          throwsAssertionError,
        );

        expect(
          () {
            FadeScaleLoader(
              duration: 1,
              color: Colors.white,
              size: -1,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'FadeScaleLoader displays with default color when color is not provided',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: FadeScaleLoader(
            duration: 1,
            size: 60,
          ),
        ));

        final fadeScaleLoader =
            tester.widget<FadeScaleLoader>(find.byType(FadeScaleLoader));
        expect(fadeScaleLoader.color, Colors.white);
      },
    );

    testWidgets(
      'FadeScaleLoader animation runs as expected',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: FadeScaleLoader(
            size: 60,
            color: Colors.white,
            duration: 1,
          ),
        ));

        final fadeScaleLoader =
            tester.widget<FadeScaleLoader>(find.byType(FadeScaleLoader));
        expect(fadeScaleLoader.size, 60);
        await tester.pump(const Duration(milliseconds: 500));
        expect(find.byType(FadeScaleLoader), findsOneWidget);
      },
    );
  });
}
