import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';
import 'package:micro_loaders/widgets/dual_dot_loader.dart';

void main() {
  group('CircleDualDotsLoader Tests', () {
    testWidgets("CircleDualDotsLoader displays correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: CircleDualDotsLoader(
          size: 48,
          color: Colors.white,
          dotColor: Colors.orange,
          dotSize: 6.0,
          duration: 1000,
        ),
      ));

      expect(find.byType(CircleDualDotsLoader), findsOneWidget);
    });

    testWidgets("CircleDualDotsLoader throws error when size is negative",
        (WidgetTester tester) async {
      expect(() {
        CircleDualDotsLoader(
          size: -1,
          color: Colors.white,
          dotColor: Colors.orange,
          dotSize: 6.0,
          duration: 1000,
        );
      }, throwsAssertionError);
    });

    testWidgets("CircleDualDotsLoader throws error when dotSize is negative",
        (WidgetTester tester) async {
      expect(() {
        CircleDualDotsLoader(
          size: 48,
          color: Colors.white,
          dotColor: Colors.orange,
          dotSize: -1.0,
          duration: 1000,
        );
      }, throwsAssertionError);
    });

    testWidgets("CircleDualDotsLoader throws error when duration is negative",
        (WidgetTester tester) async {
      expect(() {
        CircleDualDotsLoader(
          size: 48,
          color: Colors.white,
          dotColor: Colors.orange,
          dotSize: 6.0,
          duration: -1000,
        );
      }, throwsAssertionError);
    });

    testWidgets("CircleDualDotsLoader animation runs as expected",
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: CircleDualDotsLoader(
          size: 48,
          color: Colors.white,
          dotColor: Colors.orange,
          dotSize: 6.0,
          duration: 1000,
        ),
      ));

      final circleDualDotsLoader = tester
          .widget<CircleDualDotsLoader>(find.byType(CircleDualDotsLoader));
      expect(circleDualDotsLoader.size, 48);
      expect(circleDualDotsLoader.color, Colors.white);
      expect(circleDualDotsLoader.dotColor, Colors.orange);
      expect(circleDualDotsLoader.dotSize, 6.0);
      expect(circleDualDotsLoader.duration, 1000);

      await tester.pump(const Duration(milliseconds: 500));
      expect(find.byType(CircleDualDotsLoader), findsOneWidget);
    });
  });
}
