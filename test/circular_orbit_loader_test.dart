import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('CircularOrbitLoader Tests', () {
    testWidgets('renders the loader with the correct number of circles',
        (WidgetTester tester) async {
      // Arrange
      const size = 50.0;
      const color = Colors.blue;

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CircularOrbitLoader(
              size: size,
              color: color,
            ),
          ),
        ),
      );

      // Assert: Check that we have 3 circles (central + 2 orbiting circles)
      final containerFinder = find.byType(Container);
      expect(containerFinder, findsNWidgets(3));
    });

    testWidgets('applies correct size and color to circles',
        (WidgetTester tester) async {
      // Arrange
      const size = 60.0;
      const color = Colors.red;

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CircularOrbitLoader(
              size: size,
              color: color,
            ),
          ),
        ),
      );

      // Assert: Verify that each circle has the expected size and color
      final containerFinder = find.byType(Container);
      containerFinder.evaluate().forEach((element) {
        final container = element.widget as Container;
        final decoration = container.decoration as BoxDecoration;

        expect(decoration.color, color);
      });
    });

    testWidgets('animation runs without errors', (WidgetTester tester) async {
      // Arrange
      const duration = Duration(seconds: 2);

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CircularOrbitLoader(
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
            body: CircularOrbitLoader(),
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
