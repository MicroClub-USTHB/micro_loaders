import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/widgets/spinning_loader.dart';

void main() {
  testWidgets('SpinningLoader widget renders successfully',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: SpinningLoader())));

    final customPaintFinder = find.byKey(const Key('main_custom_paint'));
    expect(customPaintFinder, findsOneWidget);
  });

  testWidgets('SpinningLoader animation progresses',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Center(child: SpinningLoader()),
      ),
    ));

    final Transform initialTransform =
        tester.firstWidget(find.byType(Transform));
    final Matrix4 initialMatrix = initialTransform.transform;

    await tester.pump(const Duration(milliseconds: 500));

    final Transform halfwayTransform =
        tester.firstWidget(find.byType(Transform));
    final Matrix4 halfwayMatrix = halfwayTransform.transform;
    expect(halfwayMatrix, isNot(equals(initialMatrix)));

    await tester.pump(const Duration(seconds: 1));

    final Transform endTransform = tester.firstWidget(find.byType(Transform));
    final Matrix4 endMatrix = endTransform.transform;
    expect(endMatrix, isNot(equals(initialMatrix)));
  });

  testWidgets('LoaderPainter paints correctly', (WidgetTester tester) async {
    await tester
        .pumpWidget(const MaterialApp(home: Scaffold(body: SpinningLoader())));

    final customPaintFinder = find.byKey(const Key('main_custom_paint'));
    final customPaintWidget = tester.widget<CustomPaint>(customPaintFinder);

    final loaderPainter = customPaintWidget.painter as SpinningLoaderPainter;
    expect(loaderPainter, isNotNull);
  });
}
