import 'package:flutter/material.dart';
import 'dart:math';

/// GrowingArcLoader is a custom animated loader consisting of a static circle and a rotating arc.
///
/// It is a stateful widget that takes in the following parameters:
///
/// - **primaryColor** : Color - the color of the static background circle.
///
/// - **arcColor** : Color - the color of the animated arc.
///
/// - **size** : double - the diameter of the loader widget (both width and height).
///
/// - **strokeWidth** : double - the width of the arc and circle stroke (thickness).
///
/// - **duration** : int - the animation duration in milliseconds.
///
/// ### Assertions:
/// - The loader's size must be greater than 0,
/// - The stroke width must be positive and less than size/12,
/// - The duration must be greater than 1000 milliseconds.
///
/// ### Example:
/// ```dart
/// GrowingArcLoader(
///   size: 80,
///   primaryColor: Colors.white,
///   arcColor: Colors.red,
///   strokeWidth: 6,
///   duration: 1500,
/// )
/// ```

class GrowingArcLoader extends StatefulWidget {
  const GrowingArcLoader({
    super.key,
    this.size = 80,
    this.primaryColor = Colors.white,
    this.arcColor = Colors.red,
    this.strokeWidth = 6,
    this.duration = 1500,
  }) : assert(size > 0 && strokeWidth > 0 && strokeWidth < (size / 12) && duration > 1000,
            'Size must be greater than 0, strokeWidth must be positive and less than size / 12, and duration must be greater than 1000.');

  final double size;
  final Color primaryColor;
  final Color arcColor;
  final double strokeWidth;
  final int duration;

  @override
  State<GrowingArcLoader> createState() => _GrowingArcLoaderState();
}

class _GrowingArcLoaderState extends State<GrowingArcLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _arcAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller and set it to repeat indefinitely
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    )..repeat();

    // Animation controlling the arc's sweep angle from 0 to 2π (full circle)
    _arcAnimation = Tween<double>(begin: 0.0, end: 2 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Size constraints for the loader based on the provided size
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: CustomPaint(
        painter: ArcPainter(
          arcAnimation: _arcAnimation,
          primaryColor: widget.primaryColor,
          arcColor: widget.arcColor,
          strokeWidth: widget.strokeWidth,
        ),
      ),
    );
  }
}

class ArcPainter extends CustomPainter {
  ArcPainter({
    required this.arcAnimation,
    required this.primaryColor,
    required this.arcColor,
    required this.strokeWidth,
  }) : super(repaint: arcAnimation);

  final Animation<double> arcAnimation;
  final Color primaryColor;
  final Color arcColor;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for the static background circle
    final circlePaint = Paint()
      ..color = primaryColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Calculate center and radius of the circle
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Draw the static circle with primaryColor
    canvas.drawCircle(center, radius, circlePaint);

    // Paint for the rotating arc
    final arcPaint = Paint()
      ..color = arcColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    // Draw the arc with dynamic sweep angle based on animation progress
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2, // Start angle at the top of the circle
      arcAnimation.value, // Dynamic sweep angle controlled by the animation
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
