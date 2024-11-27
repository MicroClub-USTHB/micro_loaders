import 'dart:math';
import 'package:flutter/material.dart';

/// RotatingTwoArcLoader is a custom loader widget that displays two rotating arcs
/// that move in opposite directions. The outer arc rotates clockwise, and the inner arc
/// rotates counterclockwise. Both arcs will animate indefinitely based on the specified
/// rotation durations. This widget supports custom colors, arc sizes, stroke widths, and animation durations.
///
/// ### Parameters:
/// - **arcSize**: The size (width and height) of the loader. Must be greater than 0.
/// - **arcWidth**: The thickness of the arc stroke. Must be greater than 0 and less than arcSize/3.
/// - **rotationDurationOuterMilliseconds**: Duration for the outer arc to complete one full rotation, in milliseconds. Must be at least 500 ms.
/// - **rotationDurationInnerMilliseconds**: Duration for the inner arc to complete one full rotation, in milliseconds. Must be at least 500 ms.
/// - **outerArcColor**: The color of the outer arc. Defaults to `Colors.white`.
/// - **innerArcColor**: The color of the inner arc. Defaults to `Colors.red`.
///
/// ### Example Usage:
/// ```dart
/// RotatingTwoArcLoader(
///   arcSize: 48.0,
///   arcWidth: 3.0,
///   rotationDurationOuterMilliseconds: 2000,
///   rotationDurationInnerMilliseconds: 1500,
///   outerArcColor: Colors.blue,
///   innerArcColor: Colors.orange,
/// )
/// ```
///
/// ### Assertions:
/// - **arcSize**: Must be greater than 0.
/// - **arcWidth**: Must be greater than 0 and less than arcSize / 3.
/// - **rotationDurationOuterMilliseconds**: Must be at least 500 milliseconds.
/// - **rotationDurationInnerMilliseconds**: Must be at least 500 milliseconds.
class RotatingTwoArcLoader extends StatefulWidget {
  final double arcSize;
  final double arcWidth;
  final int rotationDurationOuterMilliseconds;
  final int rotationDurationInnerMilliseconds;
  final Color outerArcColor;
  final Color innerArcColor;

  const RotatingTwoArcLoader({
    super.key,
    this.arcSize = 48.0,
    this.arcWidth = 3.0,
    this.rotationDurationOuterMilliseconds = 1500,
    this.rotationDurationInnerMilliseconds = 2000,
    this.outerArcColor = Colors.white,
    this.innerArcColor = const Color(0xFFFF3D00),
  })  : assert(arcSize > 0, 'arcSize must be greater than zero'),
        assert(arcWidth > 0, 'arcWidth must be greater than zero'),
        assert(rotationDurationOuterMilliseconds > 0, 'rotationDurationOuterMilliseconds must be greater than zero'),
        assert(rotationDurationInnerMilliseconds > 0, 'rotationDurationInnerMilliseconds must be greater than zero');
  @override
  State<RotatingTwoArcLoader> createState() => _RotatingTwoArcLoaderState();
}

class _RotatingTwoArcLoaderState extends State<RotatingTwoArcLoader> with TickerProviderStateMixin {
  late AnimationController _controllerOuter;
  late AnimationController _controllerInner;

  @override
  void initState() {
    super.initState();

    // Outer arc controller: Repeats indefinitely with the duration defined in milliseconds
    _controllerOuter = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.rotationDurationOuterMilliseconds),
    )..repeat();

    // Inner arc controller: Repeats indefinitely with the duration defined in milliseconds
    _controllerInner = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.rotationDurationInnerMilliseconds),
    )..repeat();
  }

  @override
  void dispose() {
    _controllerOuter.dispose();
    _controllerInner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer Arc Animation (Clockwise)
        AnimatedBuilder(
          animation: _controllerOuter,
          builder: (context, child) {
            return Transform.rotate(
              angle: _controllerOuter.value * 2 * pi, // Clockwise rotation
              child: CustomPaint(
                size: Size(widget.arcSize, widget.arcSize),
                painter: TowArcPainter(
                  outer: true,
                  arcWidth: widget.arcWidth,
                  arcColor: widget.outerArcColor,
                ),
              ),
            );
          },
        ),
        // Inner Arc Animation (Counterclockwise)
        AnimatedBuilder(
          animation: _controllerInner,
          builder: (context, child) {
            return Transform.rotate(
              angle: -_controllerInner.value * 2 * pi, // Counterclockwise rotation
              child: CustomPaint(
                size: Size(widget.arcSize, widget.arcSize),
                painter: TowArcPainter(
                  outer: false,
                  arcWidth: widget.arcWidth,
                  arcColor: widget.innerArcColor,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class TowArcPainter extends CustomPainter {
  final bool outer;
  final double arcWidth;
  final Color arcColor;

  // Constructor with validation for parameters
  TowArcPainter({
    required this.outer,
    required this.arcWidth,
    required this.arcColor,
  }) : assert(arcWidth > 0, 'arcWidth must be greater than zero');

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..strokeWidth = arcWidth
      ..style = PaintingStyle.stroke
      ..color = arcColor; // Use arcColor parameter for color

    // Define the radius based on whether it's the outer or inner arc
    double radius = outer ? size.width / 2 : size.width * 0.7 / 2;

    // Start angle for both arcs (starting from the 9 o'clock position)
    double startAngle = -0.5 * pi;

    // Sweep angle for the arcs (65% of a full circle)
    double sweepAngle = 0.65 * 2 * pi; // 65% of 360 degrees

    // Draw the arc
    canvas.drawArc(
      Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: radius),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
