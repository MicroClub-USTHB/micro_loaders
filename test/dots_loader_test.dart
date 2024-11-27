import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('DotsLoaderView Tests', () {
    testWidgets('renders the correct number of dots',
        (WidgetTester tester) async {
      // Arrange
      const dotCount = 5;
      const dotSize = 12.0;

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DotsLoaderView(
              dotCount: dotCount,
              dotSize: dotSize,
            ),
          ),
        ),
      );

      // Assert
      final dotFinder =
          find.byType(Container); // The dot is rendered using a Container.
      expect(dotFinder, findsNWidgets(dotCount));
    });

    testWidgets('animation is running correctly', (WidgetTester tester) async {
      // Arrange
      const duration = Duration(milliseconds: 800);

      // Act
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DotsLoaderView(
              duration: duration,
            ),
          ),
        ),
      );

      final animatedFinder = find.byType(AnimatedBuilder);

      // Assert
      expect(animatedFinder, findsWidgets);

      // Pump the widget to simulate animation progress
      await tester.pump(duration ~/ 2);
      await tester.pump(duration ~/ 2);

      // Verify no errors occurred during animation progress
    });

    testWidgets('disposes the AnimationController properly',
        (WidgetTester tester) async {
      // Arrange
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DotsLoaderView(),
          ),
        ),
      );

      // Act
      await tester.pumpWidget(const SizedBox.shrink());

      // Assert
      expect(tester.takeException(), isNull);
    });
  });
}
