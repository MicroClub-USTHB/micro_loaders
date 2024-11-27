import 'dart:math';

import 'package:flutter/material.dart';

/// SunLoader is a custom loader that consists of a series of rectangles that rotate around a center point.
///
/// It is a stateful widget that takes in the following parameters:
///
///  * [color] - the color of the loader
/// * [radius] - the radius of the loader
/// * [duration] - the duration of the loader
/// * [size] - the size of the loader
/// * [speed] - the speed of the loader
/// * [numPoints] - the number of points in the loader
///
///  example :
///  ```dart
/// SunLoader(
/// color: Colors.red,
/// radius: 25,
/// duration: 1000,
/// size: 150,
/// speed: 1,
/// numPoints: 16,
/// )
/// ```
class SunLoader extends StatefulWidget {
  const SunLoader(
      {super.key,
      this.size = 150,
      this.color = Colors.red,
      this.radius = 25,
      this.speed = 1,
      this.numPoints = 16,
      this.duration = 1000})
      : assert(radius > 0 && size > 0 && duration > 0 && numPoints > 0 && speed > 0);

  final Color color;
  final double radius;
  final double duration;
  final double size;
  final double speed;
  final double numPoints;

  @override
  State<SunLoader> createState() => _SunLoaderState();
}

class _SunLoaderState extends State<SunLoader> with SingleTickerProviderStateMixin {
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
          return Transform.rotate(
            angle: _controller.value * pi,
            child: CustomPaint(
              painter: SunLoaderPainter(
                animationValue: _controller.value * widget.speed,
                color: widget.color,
                radius: widget.radius,
                duration: widget.duration,
                numPoints: widget.numPoints,
              ), //
            ),
          );
        },
      ),
    );
  }
}

class SunLoaderPainter extends CustomPainter {
  const SunLoaderPainter(
      {required this.animationValue,
      required this.color,
      required this.radius,
      required this.numPoints,
      required this.duration});
  final double animationValue;
  final Color color;
  final double radius;
  final double duration;
  final double numPoints;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final double step = 2 * pi / numPoints;

    for (int i = 0; i < numPoints; i++) {
      final double x1 = size.width / 2 + radius * cos(i * step);
      final double y1 = size.height / 2 + radius * sin(i * step);
      final double x2 = size.width / 2 + radius * cos(i * step + animationValue);
      final double y2 = size.height / 2 + radius * sin(i * step + animationValue);

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    }

    for (int i = 0; i < numPoints; i++) {
      final double x = size.width / 2 + radius * cos(i * step / 2);
      final double y = size.height / 2 + radius * sin(i * step);

      canvas.drawCircle(Offset(x, y), 5, paint);
    }

    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 10, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
