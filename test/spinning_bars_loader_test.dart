import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('SpinningBarsLoader', () {
    testWidgets('SpinningBarsLoader displays correctly',
        (WidgetTester tester) async {
      // Build the SpinningBarsLoader widget.
      await tester.pumpWidget(const MaterialApp(
        home: SpinningBarsLoader(
          size: 50,
          color: Colors.white,
          barHeight: 14,
          duration: 1,
        ),
      ));

      // Verify that the SpinningBarsLoader widget is displayed.
      expect(find.byType(SpinningBarsLoader), findsOneWidget);
    });

    testWidgets(
      'SpinningBarsLoader throws assertion error when size is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            SpinningBarsLoader(
              size: -1,
              color: Colors.white,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'SpinningBarsLoader throws assertion error when barHeight is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            SpinningBarsLoader(
              size: 50,
              color: Colors.white,
              barHeight: -1,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'SpinningBarsLoader throws assertion error when barHeight is greater than size',
      (WidgetTester tester) async {
        expect(
          () {
            SpinningBarsLoader(
              size: 50,
              color: Colors.white,
              barHeight: 70,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'SpinningBarsLoader throws assertion error when duration is less than or equal to 0',
      (WidgetTester tester) async {
        expect(
          () {
            SpinningBarsLoader(
              size: 60,
              color: Colors.white,
              duration: 0,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets('SpinningBarsLoader starts with correct color and animation',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: SpinningBarsLoader(
            size: 50,
            color: Colors.red,
            barHeight: 14,
            duration: 1,
          ),
        ),
      ));

      final bar = tester.widget<Container>(find.byType(Container).first);
      expect(
        (bar.decoration as BoxDecoration).color?.withOpacity(1.0),
        Colors.red.withOpacity(1.0),
      );
    });

    testWidgets('SpinningBarsLoader bars animate with opacity over time',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: SpinningBarsLoader(
            size: 50,
            color: Colors.blue,
            barHeight: 14,
            duration: 1,
          ),
        ),
      ));

      Container bar = tester.widget(find.byType(Container).first);
      final initialOpacity = (bar.decoration as BoxDecoration).color?.opacity;

      await tester.pump(const Duration(milliseconds: 500));
      bar = tester.widget(find.byType(Container).first);
      final midOpacity = (bar.decoration as BoxDecoration).color?.opacity;

      expect(midOpacity, isNot(initialOpacity));

      await tester.pump(const Duration(milliseconds: 500));
      bar = tester.widget(find.byType(Container).first);
      final finalOpacity = (bar.decoration as BoxDecoration).color?.opacity;

      expect(finalOpacity, isNot(midOpacity));
    });
  });
}
