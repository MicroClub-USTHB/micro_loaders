import 'package:flutter/material.dart';
import 'dart:math';

/// RotatingArcLoader is a custom loader widget that displays a rotating arc animation.
///
/// This loader uses an arc with two colors and rotates it indefinitely. It can be customized
/// with different colors, sizes, stroke widths, and animation duration.
///
/// ### Parameters:
///
/// - **size** : `double` - Specifies the size (width and height) of the loader widget.
///
/// - **primaryColor** : `Color` - The main color of the loader's arc.
///
/// - **secondaryColor** : `Color` - The secondary color for the remaining portion of the arc.
///
/// - **strokeWidth** : `double` - The thickness of the loader arc.
///
/// - **duration** : `int` - The animation duration in milliseconds, determining the rotation speed.
///
/// Assertions:
/// - The loader's size must be greater than 0,
/// - The stroke width must be positive and less than size/12,
/// - The duration must be more than 1000 milliseconds.
///
/// ### Example:
/// ```dart
/// RotatingArcLoader(
///   size: 48,
///   primaryColor: Colors.white,
///   secondaryColor: Colors.red,
///   strokeWidth: 5,
///   duration: 1000,
/// )
/// ```
class RotatingArcLoader extends StatefulWidget {
  const RotatingArcLoader({
    super.key,
    this.size = 80,
    this.primaryColor = Colors.white,
    this.secondaryColor = Colors.red,
    this.strokeWidth = 6,
    this.duration = 1500,
  }) : assert(size > 0 && (strokeWidth < (size / 12) && strokeWidth > 0 && duration >= 1000),
            'Size must be greater than 0, strokeWidth must be positive and less than size/12, and duration must be more than 1000 milliseconds.');

  final double size;
  final Color primaryColor;
  final Color secondaryColor;
  final double strokeWidth;
  final int duration;

  @override
  State<RotatingArcLoader> createState() => _RotatingArcLoaderState();
}

class _RotatingArcLoaderState extends State<RotatingArcLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    )..repeat(); // Loop the animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * pi,
            child: CustomPaint(
              painter: LoaderPainter(
                primaryColor: widget.primaryColor,
                secondaryColor: widget.secondaryColor,
                strokeWidth: widget.strokeWidth,
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoaderPainter extends CustomPainter {
  LoaderPainter({
    required this.strokeWidth,
    required this.primaryColor,
    required this.secondaryColor,
  });

  final double strokeWidth;
  final Color primaryColor;
  final Color secondaryColor;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Paint for the primary color border
    final primaryPaint = Paint()
      ..color = primaryColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Paint for the secondary color border (bottom color)
    final secondaryPaint = Paint()
      ..color = secondaryColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Draw the primary border (270 degrees of the circle)
    double primaryArcAngle = 3 * pi / 2; // 270 degrees
    canvas.drawArc(rect, -pi / 2, primaryArcAngle, false, primaryPaint);

    // Draw the secondary border (remaining 90 degrees)
    double secondaryArcAngle = pi / 2; // 90 degrees
    canvas.drawArc(rect, primaryArcAngle - pi / 2, secondaryArcAngle, false, secondaryPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
