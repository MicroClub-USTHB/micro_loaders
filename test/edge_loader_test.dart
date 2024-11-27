import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

///
///  * [color] - the color of the loader
/// * [radius] - the radius of the loader
/// * [duration] - the duration of the loader
/// * [size] - the size of the loader
/// * [speed] - the speed of the loader
/// * [numEdges] - the number of edges in the loader

void main() {
  group('edgesFormation', () {
    testWidgets("EdgeLoader displays correctly", (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: EdgeLoader(
          color: Colors.red,
        ),
      ));

      expect(find.byType(EdgeLoader), findsOneWidget);
    });

    testWidgets("EdgeLoader throws error when radius is negative",
        (WidgetTester tester) async {
      expect(() {
        EdgeLoader(
          radius: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });

    testWidgets("EdgeLoader throws error when size is negative",
        (WidgetTester tester) async {
      expect(() {
        EdgeLoader(
          size: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });

    testWidgets("EdgeLoader throws error when duration is negative",
        (WidgetTester tester) async {
      expect(() {
        EdgeLoader(
          duration: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });

    testWidgets("EdgeLoader throws error when numEdges is negative",
        (WidgetTester tester) async {
      expect(() {
        EdgeLoader(
          numEdges: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });

    testWidgets("EdgeLoader throws error when speed is negative",
        (WidgetTester tester) async {
      expect(() {
        EdgeLoader(
          speed: -1,
          color: Colors.red,
        );
      }, throwsAssertionError);
    });
  });

  testWidgets("EdgeLoader animation runs as expected",
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: EdgeLoader(
        size: 80,
        color: Colors.orange,
        duration: 1500,
      ),
    ));

    final edgeLoader = tester.widget<EdgeLoader>(find.byType(EdgeLoader));
    expect(edgeLoader.size, 80);
    expect(edgeLoader.color, Colors.orange);
    expect(edgeLoader.duration, 1500);
    await tester.pump(const Duration(milliseconds: 500));
    expect(find.byType(EdgeLoader), findsOneWidget);
  });
}
