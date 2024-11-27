import 'dart:math';

import 'package:flutter/material.dart';

/// DualRotatingExpandingArcLoader is a custom loader widget that displays two rotating arcs
/// that gradually expand and contract. The outer arc rotates faster than the inner arc,
/// and both arcs expand and contract in a loop.
///
/// ### Parameters:
/// - **size**: The size (width and height) of the loader widget. Must be greater than 0.
/// - **strokeWidth**: The thickness of the arc stroke. Must be greater than 0 and less than size / 3.
/// - **innerColor**: The color of the inner arc.
/// - **outerColor**: The color of the outer arc.
/// - **rotationDurationMs**: Duration of a complete rotation cycle for the outer arc, in milliseconds. Must be at least 500 ms.
/// - **animationDurationMs**: Duration for the arcs to expand from a small segment to a full half-circle and contract back, in milliseconds. Must be at least 1000 ms.
///
/// ### Example Usage:
/// ```dart
/// DualRotatingExpandingArcLoader(
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

class DualRotatingExpandingArcLoader extends StatefulWidget {
  const DualRotatingExpandingArcLoader({
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
  State<DualRotatingExpandingArcLoader> createState() => _DualRotatingExpandingArcLoaderState();
}

class _DualRotatingExpandingArcLoaderState extends State<DualRotatingExpandingArcLoader> with TickerProviderStateMixin {
  late AnimationController _rotationControllerOuter;
  late AnimationController _rotationControllerInner;
  late AnimationController _clipAnimationController;
  late Animation<double> _clipAnimationOuter;
  late Animation<double> _clipAnimationInner;

  @override
  void initState() {
    super.initState();

    _rotationControllerOuter = AnimationController(
      duration: Duration(milliseconds: widget.rotationDurationMs),
      vsync: this,
    );

    _rotationControllerInner = AnimationController(
      duration: Duration(milliseconds: widget.rotationDurationMs + 500),
      vsync: this,
    );

    _clipAnimationController = AnimationController(
      duration: Duration(milliseconds: widget.animationDurationMs),
      vsync: this,
    );

    _clipAnimationOuter = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _clipAnimationController, curve: Curves.easeInOut));

    _clipAnimationInner = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _clipAnimationController, curve: Curves.easeInOut));

    _rotationControllerOuter.repeat();
    _rotationControllerInner.repeat();
    _clipAnimationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _rotationControllerOuter.dispose();
    _rotationControllerInner.dispose();
    _clipAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: AnimatedBuilder(
            animation: Listenable.merge([_rotationControllerOuter, _clipAnimationOuter]),
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationControllerOuter.value * 2 * pi,
                child: CustomPaint(
                  painter: RotatingExpandingArcPainter(
                    color: widget.outerColor,
                    strokeWidth: widget.strokeWidth,
                    clipValue: _clipAnimationOuter.value,
                    offsetAngle: -pi / 2,
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(
          width: widget.size - 12,
          height: widget.size - 12,
          child: AnimatedBuilder(
            animation: Listenable.merge([_rotationControllerInner, _clipAnimationInner]),
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationControllerInner.value * 2 * pi,
                child: CustomPaint(
                  painter: RotatingExpandingArcPainter(
                    color: widget.innerColor,
                    strokeWidth: widget.strokeWidth,
                    clipValue: _clipAnimationInner.value,
                    offsetAngle: -pi / 2,
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

class RotatingExpandingArcPainter extends CustomPainter {
  RotatingExpandingArcPainter({
    required this.color,
    required this.strokeWidth,
    required this.clipValue,
    required this.offsetAngle,
  });

  final Color color;
  final double strokeWidth;
  final double clipValue;
  final double offsetAngle;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.addArc(
      Rect.fromLTWH(0, 0, size.width, size.height),
      offsetAngle,
      pi * clipValue,
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
