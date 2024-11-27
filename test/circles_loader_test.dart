import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('circlesFormation', () {
    testWidgets("CirclesLoader displays correctly",
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: CirclesLoader(
          color: Colors.red,
        ),
      ));

      expect(find.byType(CirclesLoader), findsOneWidget);
    });

    testWidgets("CirclesLoader throws error when radius is negative",
        (WidgetTester tester) async {
      expect(() {
        CirclesLoader(
          radius: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });
    testWidgets("CirclesLoader throws error when size is negative",
        (WidgetTester tester) async {
      expect(() {
        CirclesLoader(
          radius: 10,
          size: -23,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });
    testWidgets("CirclesLoader throws error when duration is negative",
        (WidgetTester tester) async {
      expect(() {
        CirclesLoader(
          radius: 12,
          duration: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });
  });

  testWidgets("CirclesLoader animation runs as expected",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CirclesLoader(
        size: 80,
        color: Colors.orange,
        duration: 1500,
      ),
    ));

    final circlesLoader =
        tester.widget<CirclesLoader>(find.byType(CirclesLoader));
    expect(circlesLoader.size, 80);
    expect(circlesLoader.color, Colors.orange);
    expect(circlesLoader.duration, 1500);
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(CirclesLoader), findsOneWidget);
  });
}
