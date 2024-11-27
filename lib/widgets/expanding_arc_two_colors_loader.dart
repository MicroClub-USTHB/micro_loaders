import 'dart:math';
import 'package:flutter/material.dart';

/// ExpandingArcTwoColorsLoader is a custom loader widget that displays two expanding
/// arcs with different colors. The arcs gradually
/// expand and contract in a smooth, continuous animation loop, while the loader itself
/// rotates around its center, creating a dynamic visual effect.
///
/// ### Parameters:
/// - **size**: The size (width and height) of the loader widget. Must be greater than 0.
/// - **strokeWidth**: The thickness of the arcs' strokes. Must be greater than 0 and less than size / 3.
/// - **color1**: The color of the first arc. Default is `Colors.blue`.
/// - **color2**: The color of the second arc. Default is `Colors.red`.
/// - **rotationDurationMs**: Duration (in milliseconds) for a full rotation. Must be at least 500 ms. Default is 1000 ms.
/// - **expansionDurationMs**: Duration (in milliseconds) for the arcs to expand and contract. Must be at least 1000 ms. Default is 2000 ms.
///
/// ### Example Usage:
/// ```dart
/// ExpandingArcTwoColorsLoader(
///   size: 48.0,
///   strokeWidth: 5.0,
///   color1: Colors.blue,
///   color2: Colors.red,
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

class ExpandingArcTwoColorsLoader extends StatefulWidget {
  const ExpandingArcTwoColorsLoader({
    super.key,
    this.size = 48.0,
    this.strokeWidth = 5.0,
    this.color1 = Colors.blue,
    this.color2 = Colors.red,
    this.rotationDurationMs = 1000,
    this.expansionDurationMs = 2000,
  })  : assert(size > 0, 'Size must be greater than 0.'),
        assert(strokeWidth > 0 && strokeWidth < size / 3, 'Stroke width must be greater than 0 and less than size/3.'),
        assert(rotationDurationMs >= 500, 'Rotation duration must be at least 500 ms.'),
        assert(expansionDurationMs >= 1000, 'Expansion duration must be at least 1000 ms.');

  final double size;
  final double strokeWidth;
  final Color color1;
  final Color color2;
  final int rotationDurationMs;
  final int expansionDurationMs;

  @override
  State<ExpandingArcTwoColorsLoader> createState() => _ExpandingArcTwoColorsLoaderState();
}

class _ExpandingArcTwoColorsLoaderState extends State<ExpandingArcTwoColorsLoader> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _expansionController;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: Duration(milliseconds: widget.rotationDurationMs),
      vsync: this,
    )..repeat();

    _expansionController = AnimationController(
      duration: Duration(milliseconds: widget.expansionDurationMs),
      vsync: this,
    )..repeat();
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
              painter: ExpandingDualColorArcPainter(
                color1: widget.color1,
                color2: widget.color2,
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

class ExpandingDualColorArcPainter extends CustomPainter {
  ExpandingDualColorArcPainter({
    required this.color1,
    required this.color2,
    required this.strokeWidth,
    required this.expansionValue,
  });

  final Color color1;
  final Color color2;
  final double strokeWidth;
  final double expansionValue;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()
      ..color = color1
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final Paint paint2 = Paint()
      ..color = color2
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startAngle1 = -pi / 2;
    double sweepAngleHalf = expansionValue * pi * 1.08;

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      startAngle1,
      sweepAngleHalf,
      false,
      paint1,
    );

    double startAngle2 = startAngle1 + sweepAngleHalf;
    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      startAngle2,
      sweepAngleHalf,
      false,
      paint2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
