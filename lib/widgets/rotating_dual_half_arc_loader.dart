import 'dart:math';
import 'package:flutter/material.dart';

/// A custom rotating loader with two opposite arcs.
///
/// The `RotatingDualHalfArcLoader` widget displays two red arcs rotating
/// continuously around a center. The arcs each span 30% of a full circle (108 degrees)
/// and are positioned 180 degrees apart to form a balanced, rotating design.
///
/// ### Customizable Parameters:
/// - **size**: The overall size (width and height) of the loader widget.
/// - **strokeWidth**: Thickness of the arcs. It should be less than a third of the size for best visuals.
/// - **color**: Color of the arcs, set to red by default.
/// - **rotationDurationMs**: Duration in milliseconds for a complete rotation of the loader.
///
/// ### Example Usage:
/// ```dart
/// RotatingDualHalfArcLoader(
///   size: 48.0,
///   strokeWidth: 5.0,
///   color: Colors.red,
///   rotationDurationMs: 1000,
/// )
/// ```
///
/// ### Assertions:
/// - **size**: Must be greater than 0.
/// - **strokeWidth**: Must be greater than 0 and less than a third of the size.
/// - **rotationDurationMs**: Must be at least 500 milliseconds
class RotatingDualHalfArcLoader extends StatefulWidget {
  const RotatingDualHalfArcLoader({
    super.key,
    this.size = 48.0,
    this.strokeWidth = 5.0,
    this.color = Colors.red,
    this.rotationDurationMs = 1000,
  })  : assert(size > 0, 'Size must be greater than 0.'),
        assert(strokeWidth > 0 && strokeWidth < size / 3, 'Stroke width must be greater than 0 and less than size/3.'),
        assert(rotationDurationMs >= 500, 'Rotation duration must be at least 500 milliseconds.');

  final double size;
  final double strokeWidth;
  final Color color;
  final int rotationDurationMs;

  @override
  State<RotatingDualHalfArcLoader> createState() => _RotatingDualHalfArcLoaderState();
}

class _RotatingDualHalfArcLoaderState extends State<RotatingDualHalfArcLoader> with TickerProviderStateMixin {
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: Duration(milliseconds: widget.rotationDurationMs),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _rotationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationController.value * 2 * pi,
            child: CustomPaint(
              painter: HalfArcPainter(
                color: widget.color,
                strokeWidth: widget.strokeWidth,
              ),
            ),
          );
        },
      ),
    );
  }
}

class HalfArcPainter extends CustomPainter {
  const HalfArcPainter({
    required this.color,
    required this.strokeWidth,
  });

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = size.width / 2;

    double sweepAngle = 108 * pi / 180;

    double startAngle1 = -pi / 2;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle1,
      sweepAngle,
      false,
      paint,
    );

    double startAngle2 = startAngle1 + pi;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle2,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
