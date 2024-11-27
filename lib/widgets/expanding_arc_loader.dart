import 'dart:math';
import 'package:flutter/material.dart';

/// ExpandingArcLoader is a custom loader widget that displays a rotating arc
/// that gradually expands until it completes a full circle. It supports custom
/// colors, sizes, stroke widths, and animation durations for rotation and expansion.
///
/// ### Parameters:
/// - **size**: The size (width and height) of the loader widget. Must be greater than 0.
/// - **color**: The color of the loader's arc.
/// - **strokeWidth**: The thickness of the arc stroke. Must be greater than 0 and less than size/3.
/// - **rotationDurationMs**: Duration of a complete rotation cycle, in milliseconds. Must be at least 500 ms.
/// - **expansionDurationMs**: Duration for the arc to expand from a small segment to a full circle, in milliseconds. Must be at least 1000 ms.
///
/// ### Example Usage:
/// ```dart
/// ExpandingArcLoader(
///   size: 48.0,
///   strokeWidth: 5.0,
///   color: Colors.blue,
///   rotationDurationMs: 1000,
///   expansionDurationMs: 2000,
/// )
/// ```
///
/// ### Assertions:
/// - **size**: Must be greater than 0.
/// - **strokeWidth**: Must be greater than 0 and less than size / 3.
/// - **rotationDurationMs**: Must be at least 500 milliseconds.
/// - **expansionDurationMs**: Must be at least 1000 milliseconds.
class ExpandingArcLoader extends StatefulWidget {
  const ExpandingArcLoader({
    super.key,
    this.size = 48.0,
    this.strokeWidth = 5.0,
    this.color = Colors.blue,
    this.rotationDurationMs = 1000,
    this.expansionDurationMs = 2000,
  })  : assert(size > 0, 'Size must be greater than 0.'),
        assert(strokeWidth > 0 && strokeWidth < size / 3, 'Stroke width must be greater than 0 and less than size/3.'),
        assert(rotationDurationMs >= 500, 'Rotation duration must be at least 500 ms.'),
        assert(expansionDurationMs >= 1000, 'Expansion duration must be at least 1000 ms.');

  final double size;
  final double strokeWidth;
  final Color color;
  final int rotationDurationMs;
  final int expansionDurationMs;

  @override
  State<ExpandingArcLoader> createState() => _ExpandingArcLoaderState();
}

class _ExpandingArcLoaderState extends State<ExpandingArcLoader> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _expansionController;

  @override
  void initState() {
    super.initState();

    // Controller for rotation animation
    _rotationController = AnimationController(
      duration: Duration(milliseconds: widget.rotationDurationMs),
      vsync: this,
    )..repeat(); // Loop the rotation indefinitely

    // Controller for arc expansion animation
    _expansionController = AnimationController(
      duration: Duration(milliseconds: widget.expansionDurationMs),
      vsync: this,
    )..repeat(); // Loop the expansion indefinitely
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _expansionController.dispose();
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
              painter: ExpandingArcPainter(
                color: widget.color,
                strokeWidth: widget.strokeWidth,
                expansionValue: _expansionController.value,
              ),
            ),
          );
        },
      ),
    );
  }
}

class ExpandingArcPainter extends CustomPainter {
  ExpandingArcPainter({
    required this.color,
    required this.strokeWidth,
    required this.expansionValue,
  });

  final Color color;
  final double strokeWidth;
  final double expansionValue;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Start with a small angle and expand to a full circle over time
    double startAngle = -pi / 2;
    double sweepAngle = expansionValue * 2 * pi;

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      startAngle,
      sweepAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
