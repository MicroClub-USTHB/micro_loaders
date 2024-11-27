// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('TextLoader', () {
    testWidgets('TextLoader displays correctly', (tester) async {
      // Build the widget
      await tester.pumpWidget(MaterialApp(
          home: TextLoader(
        duration: 2,
        textStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            fontSize: 25,
            color: Colors.white),
      )));

      expect(find.byType(TextLoader), findsOneWidget);
    });

    testWidgets('TextLoader throws error if duration is less or equal to 0',
        (WidgetTester tester) async {
      expect(
        () {
          TextLoader(duration: 0);
        },
        throwsAssertionError,
      );

      expect(
        () {
          TextLoader(duration: -1);
        },
        throwsAssertionError,
      );
    });
  });
}
