// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('ColorfulDotsLoader', () {
    testWidgets('ColorfulDotsLoader displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: ColorfulDotsLoader(
          colors: [Colors.red, Colors.green, Colors.blue],
          duration: 1000,
          dotSize: 20,
          height: 50,
          width: 300,
        ),
      ));

      expect(find.byType(ColorfulDotsLoader), findsOneWidget);
    });

    testWidgets(
      'ColorfulDotsLoader throws assertion error when duration is less than 0',
      (WidgetTester tester) async {
        expect(
          () {
            ColorfulDotsLoader(
              colors: [Colors.red, Colors.green, Colors.blue],
              duration: -1,
              dotSize: 20,
              height: 50,
              width: 300,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'ColorfulDotsLoader throws assertion error when duration is zero',
      (WidgetTester tester) async {
        expect(
          () {
            ColorfulDotsLoader(
              colors: [Colors.red, Colors.green, Colors.blue],
              duration: 0,
              dotSize: 20,
              height: 50,
              width: 300,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'ColorfulDotsLoader animation runs as expected',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: ColorfulDotsLoader(
            colors: [Colors.red, Colors.green, Colors.blue],
            duration: 1000,
            dotSize: 20,
            height: 50,
            width: 300,
          ),
        ));

        await tester.pump(const Duration(milliseconds: 500));
        expect(find.byType(ColorfulDotsLoader), findsOneWidget);
      },
    );
  });
}
