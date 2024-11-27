import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('PulseRingLoader', () {
    testWidgets('PulseRingLoader displays correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: PulseRingLoader(
          color: Colors.blueAccent,
          size: 20,
        ),
      ));

      expect(find.byType(PulseRingLoader), findsOneWidget);
    });

    testWidgets(
      'PulseRingLoader throws assertion error when size is less than 0',
      (WidgetTester tester) async {
        expect(
          () {
            PulseRingLoader(
              size: -1,
              color: Colors.blueAccent,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'PulseRingLoader throws assertion error when size is zero',
      (WidgetTester tester) async {
        expect(
          () {
            PulseRingLoader(
              size: 0,
              color: Colors.blueAccent,
            );
          },
          throwsAssertionError,
        );
      },
    );

    testWidgets(
      'PulseRingLoader displays with default color when color is not provided',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: PulseRingLoader(
            size: 20,
          ),
        ));

        final pulseRingLoader =
            tester.widget<PulseRingLoader>(find.byType(PulseRingLoader));
        expect(pulseRingLoader.color, Colors.blueAccent);
      },
    );

    testWidgets(
      'PulseRingLoader animation runs as expected',
      (WidgetTester tester) async {
        await tester.pumpWidget(const MaterialApp(
          home: PulseRingLoader(
            size: 20,
            color: Colors.blueAccent,
          ),
        ));

        final pulseRingLoader =
            tester.widget<PulseRingLoader>(find.byType(PulseRingLoader));
        expect(pulseRingLoader.size, 20);
        await tester.pump(const Duration(milliseconds: 500));
        expect(find.byType(PulseRingLoader), findsOneWidget);
      },
    );
  });
}
