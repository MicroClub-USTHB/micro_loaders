import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:micro_loaders/micro_loaders.dart';

void main() {
  group('FileDownloadLoader Widget Tests', () {
    testWidgets('renders the progress bar and text elements',
        (WidgetTester tester) async {
      // Build the widget with a total size of 100 MB and a download speed of 10 MB/s
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FileDownloadLoader(
              totalSize: 100.0,
              downloadSpeed: 10.0,
              color: Colors.blue,
              size: 50.0,
            ),
          ),
        ),
      );

      // Check if the specific CustomPaint with key 'progressBar' exists
      expect(find.byKey(const Key('progressBar')), findsOneWidget);

      // Check if progress text and time left text are rendered
      expect(find.textContaining('Progress:'), findsOneWidget);
      expect(find.textContaining('Time left:'), findsOneWidget);
    });

    testWidgets('updates progress over time', (WidgetTester tester) async {
      const double totalSize = 100.0;
      const double downloadSpeed = 10.0;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: FileDownloadLoader(
              totalSize: totalSize,
              downloadSpeed: downloadSpeed,
              color: Colors.blue,
              size: 12,
            ),
          ),
        ),
      );

      // Initial state check - Progress should be 0% and Time Left should be totalSize / downloadSpeed
      expect(find.text('Progress: 0.0%'), findsOneWidget);
      expect(find.text('Time left: 10.0 s'), findsOneWidget);

      // Simulate a 1-second interval and pump to update widget state
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('Progress: 10.0%'), findsOneWidget);
      expect(find.text('Time left: 9.0 s'), findsOneWidget);

      // Simulate another second
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('Progress: 20.0%'), findsOneWidget);
      expect(find.text('Time left: 8.0 s'), findsOneWidget);

      // Complete the download
      await tester.pump(const Duration(seconds: 8));
      expect(find.text('Progress: 100.0%'), findsOneWidget);
      expect(find.text('Time left: 0.0 s'), findsOneWidget);
    });
  });
}
