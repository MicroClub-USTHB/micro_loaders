import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('ExpandingTwoHalvesArcLoader', () {
    testWidgets('ExpandingTwoHalvesArcLoader displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: ExpandingTwoHalvesArcLoader(
            size: 48.0,
            strokeWidth: 5.0,
            color1: Colors.blue,
            color2: Colors.red,
            rotationDurationMs: 1000,
            expansionDurationMs: 2000,
          ),
        ),
      ));

      expect(find.byType(ExpandingTwoHalvesArcLoader), findsOneWidget);
    });

    testWidgets('Throws assertion error if size is <= 0',
        (WidgetTester tester) async {
      expect(
        () => ExpandingTwoHalvesArcLoader(size: 0),
        throwsAssertionError,
      );
    });

    testWidgets('Throws assertion error if strokeWidth is invalid',
        (WidgetTester tester) async {
      expect(
        () => ExpandingTwoHalvesArcLoader(size: 48.0, strokeWidth: 0),
        throwsAssertionError,
      );
      expect(
        () => ExpandingTwoHalvesArcLoader(size: 48.0, strokeWidth: 20),
        throwsAssertionError,
      );
    });

    testWidgets('Throws assertion error if rotationDurationMs is < 500',
        (WidgetTester tester) async {
      expect(
        () => ExpandingTwoHalvesArcLoader(rotationDurationMs: 499),
        throwsAssertionError,
      );
    });

    testWidgets('Throws assertion error if expansionDurationMs is < 500',
        (WidgetTester tester) async {
      expect(
        () => ExpandingTwoHalvesArcLoader(expansionDurationMs: 499),
        throwsAssertionError,
      );
    });

    testWidgets('Respects custom properties', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: ExpandingTwoHalvesArcLoader(
            size: 60.0,
            strokeWidth: 6.0,
            color1: Colors.green,
            color2: Colors.yellow,
            rotationDurationMs: 1200,
            expansionDurationMs: 2500,
          ),
        ),
      ));

      final loader = tester.widget<ExpandingTwoHalvesArcLoader>(
          find.byType(ExpandingTwoHalvesArcLoader));
      expect(loader.size, 60.0);
      expect(loader.strokeWidth, 6.0);
      expect(loader.color1, Colors.green);
      expect(loader.color2, Colors.yellow);
      expect(loader.rotationDurationMs, 1200);
      expect(loader.expansionDurationMs, 2500);
    });
  });
}
