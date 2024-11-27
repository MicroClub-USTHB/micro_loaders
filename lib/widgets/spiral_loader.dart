import 'dart:math';
import 'package:flutter/material.dart';

/// SpiralLoader is a custom loader this is made up of 8 circles that explode outwards from the center of the loader with a sin Spiral.
///
/// It is a stateful widget that takes in the following parameters:
///
///  - **color** : Color - the color of the loader
///  - **radius** : double - the radius of the circles
/// - **size**: double - the size of the loader (width and height of the loader)
/// - **duration** : int - the duration of the loader  (in milliseconds)
/// - **spiralLength** : int - the length of the spiral
/// assert: radius >= 0 && size > 0 && duration > 0 && spiralLength > 0
///
///  example :
///  ```dart
/// SpiralLoader(
/// color: Colors.deepPurple,
/// radius: 30,
/// size: 150,
/// duration: 1500,
/// spiralLength: 400,
/// )
/// ```
class SpiralLoader extends StatefulWidget {
  const SpiralLoader({
    super.key,
    this.size = 150,
    this.color = Colors.red,
    this.radius = 25,
    this.duration = 1000,
    this.spiralLength = 360,
  }) : assert(radius >= 0 && size >= 0 && duration >= 0 && spiralLength >= 0);

  final double size;
  final Color color;
  final double radius;
  final double spiralLength;
  final double duration;

  @override
  State<SpiralLoader> createState() => _SpiralLoaderState();
}

class _SpiralLoaderState extends State<SpiralLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration.toInt()),
      vsync: this,
      lowerBound: -1.0,
      upperBound: 1.0,
    )..reset();

    _controller.repeat(reverse: true);
    super.initState();
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
          return CustomPaint(
            painter: SpiralLoaderPainter(
              animationValue: _controller.value,
              color: widget.color,
              radius: widget.radius,
              duration: widget.duration,
              spiralLength: widget.spiralLength,
            ), //
          );
        },
      ),
    );
  }
}

class SpiralLoaderPainter extends CustomPainter {
  const SpiralLoaderPainter({
    required this.animationValue,
    required this.color,
    required this.radius,
    required this.duration,
    required this.spiralLength,
  });

  final double animationValue;
  final Color color;
  final double radius;
  final double duration;
  final double spiralLength;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.translate(size.width / 2, size.height / 2);

    final path = Path();
    int maxSteps = (animationValue * spiralLength).toInt();

    for (int i = 0; i < maxSteps; i++) {
      double angle = 0.1 * i;
      double x = cos(angle) * (angle + 1);
      double y = sin(angle) * (angle + 1);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
