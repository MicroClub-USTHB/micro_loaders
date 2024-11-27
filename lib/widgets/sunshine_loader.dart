import 'dart:math';

import 'package:flutter/material.dart';

/// SunchineLoader is a custom loader that consists of a series of rectangles that rotate around a center point.
///
/// It is a stateful widget that takes in the following parameters:
///
///  * [color] - the color of the loader
/// * [radius] - the radius of the loader
/// * [size] - the size of the loader
/// * [speed] - the speed of the loader
/// * [numPoints] - the number of points in the loader
///
///  example :
///  ```dart
/// SunchineLoader(
/// color: Colors.red,
/// radius: 25,
/// size: 150,
/// speed: 1,
/// numPoints: 16,
/// )
/// ```
class SunshineLoader extends StatefulWidget {
  const SunshineLoader(
      {super.key,
      this.size = 150,
      this.color = Colors.red,
      this.radius = 25,
      this.speed = 1,
      this.numRays = 16,
      this.duration = 1000})
      : assert(radius > 0 && size > 0 && duration > 0 && numRays > 0 && speed > 0);

  final Color color;
  final double radius;
  final double duration;
  final double size;
  final double speed;
  final double numRays;

  @override
  State<SunshineLoader> createState() => _SunchineLoaderState();
}

class _SunchineLoaderState extends State<SunshineLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration.toInt()),
      vsync: this,
      lowerBound: -1.0,
      upperBound: 1.0,
    )..repeat();

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
            painter: SunchineLoaderPainter(
              animationValue: _controller.value * widget.speed,
              color: widget.color,
              radius: widget.radius,
              numRays: widget.numRays,
            ), //
          );
        },
      ),
    );
  }
}

class SunchineLoaderPainter extends CustomPainter {
  const SunchineLoaderPainter(
      {required this.animationValue, required this.color, required this.radius, required this.numRays});
  final double animationValue;
  final Color color;
  final double radius;
  final double numRays;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    for (int i = 0; i < numRays; i++) {
      final angle = 2 * pi * i / numRays + animationValue * 2 * pi;
      final Offset offset = Offset(
        size.width / 2 + radius * cos(angle),
        size.height / 2 + radius * sin(angle),
      );

      canvas.save();
      canvas.translate(offset.dx, offset.dy);
      canvas.rotate(angle);
      canvas.drawRect(
        Rect.fromCenter(center: const Offset(0, 0), width: 60, height: 60),
        paint,
      );
      canvas.restore();

      canvas.drawCircle(
        offset,
        5,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
