import 'dart:math';
import 'package:flutter/material.dart';

/// DualExpandingArcLoader is a custom loader widget that displays two rotating arcs
/// that gradually expand until they complete a full circle. It supports custom
/// colors, sizes, stroke widths, and animation durations for rotation and expansion.
///
/// ### Parameters:
/// - **size**: The size (width and height) of the loader widget. Must be greater than 0.
/// - **strokeWidth**: The thickness of the arc stroke. Must be greater than 0 and less than size/3.
/// - **innerColor**: The color of the inner arc.
/// - **outerColor**: The color of the outer arc.
/// - **rotationDurationMs**: Duration of a complete rotation cycle, in milliseconds. Must be at least 500 ms.
/// - **animationDurationMs**: Duration for the arcs to expand from a small segment to a full circle, in milliseconds. Must be at least 1000 ms.
///
/// ### Example Usage:
/// ```dart
/// DualExpandingArcLoader(
///   size: 48.0,
///   strokeWidth: 5.0,
///   innerColor: Colors.white,
///   outerColor: Colors.red,
///   rotationDurationMs: 1000,
///   animationDurationMs: 2000,
/// )
/// ```
///
/// ### Assertions:
/// - **size**: Must be greater than 0.
/// - **strokeWidth**: Must be greater than 0 and less than size / 3.
/// - **rotationDurationMs**: Must be at least 500 milliseconds.
/// - **animationDurationMs**: Must be at least 1000 milliseconds.

class DualExpandingArcLoader extends StatefulWidget {
  const DualExpandingArcLoader({
    super.key,
    this.size = 48.0,
    this.strokeWidth = 5.0,
    this.innerColor = Colors.white,
    this.outerColor = Colors.red,
    this.rotationDurationMs = 1000,
    this.animationDurationMs = 2000,
  })  : assert(size > 0, 'Size must be greater than 0.'),
        assert(
            strokeWidth > 0 && strokeWidth < size / 3, 'Stroke width must be greater than 0 and less than size / 3.'),
        assert(rotationDurationMs >= 500, 'Rotation duration must be at least 500 milliseconds.'),
        assert(animationDurationMs >= 1000, 'Animation duration must be at least 1000 milliseconds.');

  final double size;
  final double strokeWidth;
  final Color innerColor;
  final Color outerColor;
  final int rotationDurationMs;
  final int animationDurationMs;

  @override
  State<DualExpandingArcLoader> createState() => _DualExpandingArcLoaderState();
}

class _DualExpandingArcLoaderState extends State<DualExpandingArcLoader> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _clipAnimationController;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: Duration(milliseconds: widget.rotationDurationMs),
      vsync: this,
    )..repeat();

    _clipAnimationController = AnimationController(
      duration: Duration(milliseconds: widget.animationDurationMs),
      vsync: this,
    )..repeat(); // Repeat for the clip animation
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _clipAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Outer rotating arc (inverted direction)
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: -_rotationController.value * 2 * pi, // Inverted rotation
                child: CustomPaint(
                  painter: ExpandedArcPainter(
                    color: widget.outerColor,
                    strokeWidth: widget.strokeWidth,
                    clipValue: _clipAnimationController.value,
                  ),
                ),
              );
            },
          ),
        ),
        // Inner rotating arc
        SizedBox(
          width: widget.size - 12, // Adjust inner size
          height: widget.size - 12,
          child: AnimatedBuilder(
            animation: _rotationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationController.value * 2 * pi, // Normal rotation
                child: CustomPaint(
                  painter: ExpandedArcPainter(
                    color: widget.innerColor,
                    strokeWidth: widget.strokeWidth,
                    clipValue: _clipAnimationController.value,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class ExpandedArcPainter extends CustomPainter {
  ExpandedArcPainter({
    required this.color,
    required this.strokeWidth,
    required this.clipValue,
  });

  final Color color;
  final double strokeWidth;
  final double clipValue;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Clip path animation
    Path path = Path();

    path.addArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      -pi / 2,
      2 * pi * clipValue,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
