import 'dart:math';

import 'package:flutter/material.dart';

/// ExplosionLoader is a custom loader this is made up of 8 circles that explode outwards from the center of the loader with a sin Spiral.
///
/// It is a stateful widget that takes in the following parameters:
///
///  - **color** : Color - the color of the loader
///  - **radius** : double - the radius of the circles
/// - **size**: double - the size of the loader (width and height of the loader)
/// - **duration** : int - the duration of the loader  (in milliseconds)
/// - **xInterval** : double - the interval of the x-axis (-xInterval, xInterval)
/// - **yMax** : double - the maximum value of the y-axis
/// assert: radius >= 0 && size > 0 && duration > 0
///
///  example :
///  ```dart
/// ExplosionLoader(
/// color: Colors.deepPurple,
/// radius: 30,
/// size: 150,
/// duration: 1500,
/// xInterval: 20,
/// yMax: 10,
/// )
/// ```
class ExplosionLoader extends StatefulWidget {
  const ExplosionLoader(
      {super.key,
      this.size = 150,
      this.color = Colors.red,
      this.radius = 25,
      this.duration = 1000,
      this.xInterval = 20,
      this.yMax = 5})
      : assert(radius >= 0 && size >= 0 && duration >= 0 && xInterval >= 0 && yMax > 0);

  final double size;
  final Color color;
  final double radius;
  final double xInterval;
  final double yMax;
  final double duration;

  @override
  State<ExplosionLoader> createState() => _ExplosionLoaderState();
}

class _ExplosionLoaderState extends State<ExplosionLoader> with SingleTickerProviderStateMixin {
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
            painter: ExplosionLoaderPainter(
              animationValue: _controller.value,
              color: widget.color,
              radius: widget.radius,
              duration: widget.duration,
              xInterval: widget.xInterval,
              yMax: widget.yMax,
            ), //
          );
        },
      ),
    );
  }
}

class ExplosionLoaderPainter extends CustomPainter {
  const ExplosionLoaderPainter(
      {required this.animationValue,
      required this.color,
      required this.radius,
      required this.duration,
      required this.xInterval,
      required this.yMax});
  final double animationValue;
  final Color color;
  final double radius;
  final double duration;
  final double xInterval;
  final double yMax;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    double x = animationValue * xInterval;
    double y = sin(x / 2) * yMax;

    final circles = [
      [x, y],
      [y, x],
      [-x, -y],
      [-y, -x],
      [x, -y],
      [y, -x],
      [-x, y],
      [-y, x],
    ];

    for (var i = 0; i < circles.length; i++) {
      final [x, y] = circles[i];
      final centredX = size.width / 2 + x;
      final centredY = size.height / 2 - y;
      canvas.drawCircle(Offset(centredX, centredY), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
