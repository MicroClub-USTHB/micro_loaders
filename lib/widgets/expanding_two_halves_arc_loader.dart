import 'dart:math';
import 'package:flutter/material.dart';

/// A custom Flutter widget that displays a rotating loading indicator with two expanding arcs in contrasting colors.
///
/// The `ExpandingTwoHalvesArcLoader` widget animates two arcs that rotate continuously while expanding and contracting
/// to create a dynamic loading effect. The widget supports customizable properties for size, stroke width, colors,
/// rotation speed, and expansion speed.
///
/// Key properties include:
/// - `size`: The diameter of the loader in logical pixels.
/// - `strokeWidth`: The width of each arc's stroke, which should be less than one-third of the size.
/// - `color1` and `color2`: Colors for each of the two arcs.
/// - `rotationDurationMs`: Duration of one full rotation cycle in milliseconds (minimum of 500).
/// - `expansionDurationMs`: Duration of one full expansion and contraction cycle in milliseconds (minimum of 500).
///
/// This widget uses two `AnimationController`s:
/// - One for the rotation animation, which rotates the arcs indefinitely.
/// - One for the expansion animation, which expands and contracts the arcs in a repeating pattern.
///
/// The `DualArcPainter` class is used to paint the arcs onto the canvas, where each arc's angle and sweep are
/// controlled by the expansion value.
///
/// Usage example:
/// ```dart
/// ExpandingTwoHalvesArcLoader(
///   size: 48.0,
///   strokeWidth: 5.0,
///   color1: Colors.blue,
///   color2: Colors.red,
///   rotationDurationMs: 1000,
///   expansionDurationMs: 2000,
/// )
/// ```

class ExpandingTwoHalvesArcLoader extends StatefulWidget {
  const ExpandingTwoHalvesArcLoader({
    super.key,
    this.size = 48.0,
    this.strokeWidth = 5.0,
    this.color1 = Colors.blue,
    this.color2 = Colors.red,
    this.rotationDurationMs = 1000,
    this.expansionDurationMs = 2000,
  })  : assert(size > 0, 'Size must be greater than 0.'),
        assert(strokeWidth > 0 && strokeWidth < size / 3, 'Stroke width must be greater than 0 and less than size/3.'),
        assert(rotationDurationMs >= 500, 'Rotation duration must be at least 500 milliseconds.'),
        assert(expansionDurationMs >= 500, 'Expansion duration must be at least 500 milliseconds.');

  final double size;
  final double strokeWidth;
  final Color color1;
  final Color color2;
  final int rotationDurationMs;
  final int expansionDurationMs;

  @override
  State<ExpandingTwoHalvesArcLoader> createState() => _ExpandingTwoHalvesArcLoaderState();
}

class _ExpandingTwoHalvesArcLoaderState extends State<ExpandingTwoHalvesArcLoader> with TickerProviderStateMixin {
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
    )..repeat(reverse: true);
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
              painter: DualArcPainter(
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

class DualArcPainter extends CustomPainter {
  DualArcPainter({
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
    double sweepAngle1 = expansionValue * pi;
    double startAngle2 = startAngle1 + pi;
    double sweepAngle2 = expansionValue * pi;

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      startAngle1,
      sweepAngle1,
      false,
      paint1,
    );

    canvas.drawArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      startAngle2,
      sweepAngle2,
      false,
      paint2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
