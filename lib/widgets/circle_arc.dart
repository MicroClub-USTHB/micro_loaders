import 'package:flutter/material.dart';
import 'dart:math';

/// CircleArc is a custom animated loader that consists of a rotating line within a circular border.
///
/// It is a stateful widget with the following configurable parameters:
///
/// - **circleColor** : Color - the color of the circular border.
///
/// - **lineColor**: Color - the color of the rotating line.
///
/// The animation duration is set to 2 seconds by default, and the loader repeats indefinitely.
///
/// ### Example:
/// ```dart
/// CircleArc(
///   circleColor: Colors.grey,
///   lineColor: Colors.blue,
/// )
/// ```
///
/// This widget creates a circular loader with a fixed size of 100x100 pixels.

class CircleArc extends StatefulWidget {
  final Color circleColor;
  final Color lineColor;
  const CircleArc({
    super.key,
    required this.circleColor,
    required this.lineColor,
  });

  @override
  State<CircleArc> createState() => _CircleArcState();
}

class _CircleArcState extends State<CircleArc> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: CircleArcPainter(
              _controller.value,
              widget.circleColor,
              widget.lineColor,
            ),
            size: const Size(100, 100),
          );
        });
  }
}

class CircleArcPainter extends CustomPainter {
  final double rotation;
  final Color circleColor;
  final Color lineColor;
  CircleArcPainter(this.rotation, this.circleColor, this.lineColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    // circle
    paint.color = circleColor;
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    // half diametre
    paint.color = lineColor;
    final radius = size.width / 2.15;
    final angle = 2 * pi * rotation;

    // Calculate end point of the rotating line
    final x = size.width / 2 + radius * cos(angle);
    final y = size.height / 2 + radius * sin(angle);

    // Draw line from center to the edge of the circle
    canvas.drawLine(size.center(Offset.zero), Offset(x, y), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
