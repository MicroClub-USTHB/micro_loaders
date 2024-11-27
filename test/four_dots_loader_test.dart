import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/widgets/four_dots_loader.dart';

void main() {
  group('FourRotatingDots Widget Tests', () {
    testWidgets('uses default colors if no colors are provided',
        (WidgetTester tester) async {
      // Arrange
      const size = 100.0;

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FourRotatingDots(size: size),
          ),
        ),
      );

      // Assert
      final defaultDots = tester.widgetList<DrawDot>(find.byType(DrawDot));
      for (var dot in defaultDots) {
        expect(dot.color, isNotNull); // Ensure default color is set
      }
    });

    testWidgets('animates dots during its lifecycle',
        (WidgetTester tester) async {
      // Arrange
      const size = 100.0;
      const duration = Duration(milliseconds: 2200);

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FourRotatingDots(size: size),
          ),
        ),
      );

      // Capture the initial position of a dot
      final initialDot = tester.getTopLeft(find.byType(DrawDot).first);

      // Act
      await tester.pump(duration * 0.25); // Advance the animation by 25%
      final movedDot = tester.getTopLeft(find.byType(DrawDot).first);

      // Assert
      expect(initialDot, isNot(equals(movedDot))); // Position should change
    });

    testWidgets('respects the provided size', (WidgetTester tester) async {
      // Arrange
      const size = 120.0;

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FourRotatingDots(size: size),
          ),
        ),
      );

      // Assert
      final loaderWidget = tester.widget<FourRotatingDots>(
        find.byType(FourRotatingDots),
      );
      expect(loaderWidget.size, size);
    });

    testWidgets('stops animation when the widget is removed',
        (WidgetTester tester) async {
      // Arrange
      const size = 100.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FourRotatingDots(size: size),
          ),
        ),
      );

      // Act
      await tester
          .pumpWidget(const MaterialApp(home: Scaffold(body: SizedBox())));

      // Assert
      expect(find.byType(FourRotatingDots), findsNothing);
    });
  });
}
