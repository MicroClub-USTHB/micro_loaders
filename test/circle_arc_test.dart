import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/widgets/circle_arc.dart';

void main() {
  testWidgets('CircleArc widget exists in widgets tree',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircleArc(
              circleColor: Colors.white,
              lineColor: Colors.orange,
            ),
          ),
        ),
      ),
    );
    expect(find.byType(CircleArc), findsOneWidget);
  });

  testWidgets('CircleArc widget animates rotation value',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: CircleArc(
              circleColor: Colors.white,
              lineColor: Colors.orange,
            ),
          ),
        ),
      ),
    );
    final initialPainter = (tester
                .widgetList(find.byType(CustomPaint))
                .firstWhere((element) =>
                    (element as CustomPaint).painter is CircleArcPainter)
            as CustomPaint)
        .painter as CircleArcPainter;

    final initialRotation = initialPainter.rotation;
    await tester.pump(const Duration(milliseconds: 500));
    final updatedPainter = (tester
                .widgetList(find.byType(CustomPaint))
                .firstWhere((element) =>
                    (element as CustomPaint).painter is CircleArcPainter)
            as CustomPaint)
        .painter as CircleArcPainter;

    final updatedRotation = updatedPainter.rotation;
    expect(updatedRotation, isNot(equals(initialRotation)));
  });
}
