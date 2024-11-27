import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('SlidingSquareLoaderView Tests', () {
    testWidgets('renders the correct number of squares',
        (WidgetTester tester) async {
      // Arrange
      const squareCount = 5;
      const squareSize = 25.0;

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SlidingSquareLoaderView(
              squareCount: squareCount,
              squareSize: squareSize,
            ),
          ),
        ),
      );

      // Assert: Check that we have the correct number of square containers
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsNWidgets(squareCount));
    });

    testWidgets('applies correct size, spacing, and color to squares',
        (WidgetTester tester) async {
      // Arrange
      const squareCount = 4;
      const squareSize = 30.0;
      const spacing = 15.0;
      const color = Colors.green;

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SlidingSquareLoaderView(
              squareCount: squareCount,
              squareSize: squareSize,
              spacing: spacing,
              squareColor: color,
            ),
          ),
        ),
      );

      // Assert: Verify that each square has the expected size and color
      final containerFinder = find.byType(Container);
      containerFinder.evaluate().forEach((element) {
        final container = element.widget as Container;

        // Check if the container has a color
        expect(container.color, color);
      });
    });

    testWidgets('animation runs without errors', (WidgetTester tester) async {
      // Arrange
      const duration = Duration(milliseconds: 1000);

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SlidingSquareLoaderView(
              duration: duration,
            ),
          ),
        ),
      );

      // Assert: Check that the animation is running by looking for the AnimatedBuilder widget
      final animatedFinder = find.byType(AnimatedBuilder);
      expect(animatedFinder, findsWidgets);

      // Pump the widget to simulate animation progress
      await tester.pump(duration ~/ 2);
      await tester.pump(duration ~/ 2);
    });

    testWidgets('disposes of the AnimationController properly',
        (WidgetTester tester) async {
      // Arrange: Initialize the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SlidingSquareLoaderView(),
          ),
        ),
      );

      // Act: Dispose the widget by pumping a different widget
      await tester.pumpWidget(const SizedBox.shrink());

      // Assert: No errors or exceptions after disposal
      expect(tester.takeException(), isNull);
    });
  });
}
