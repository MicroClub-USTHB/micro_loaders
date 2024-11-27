import 'dart:math';

import 'package:flutter/material.dart';

/// EdgeLoader is a custom loader that consists of a series of rectangles that rotate around a center point.
///
/// It is a stateful widget that takes in the following parameters:
///
///  * [color] - the color of the loader
/// * [radius] - the radius of the loader
/// * [duration] - the duration of the loader
/// * [size] - the size of the loader
/// * [speed] - the speed of the loader
/// * [numEdges] - the number of edges in the loader
///
///  example :
///  ```dart
/// EdgeLoader(
/// color: Colors.red,
/// radius: 25,
/// duration: 1000,
/// size: 150,
/// speed: 1,
/// numEdges: 16,
/// )
/// ```
class EdgeLoader extends StatefulWidget {
  const EdgeLoader(
      {super.key,
      this.size = 150,
      this.color = Colors.red,
      this.radius = 25,
      this.speed = 1,
      this.numEdges = 16,
      this.duration = 1000})
      : assert(radius > 0 && size > 0 && duration > 0 && numEdges > 0 && speed > 0);

  final Color color;
  final double radius;
  final double duration;
  final double size;
  final double speed;
  final double numEdges;

  @override
  State<EdgeLoader> createState() => _EdgeLoaderState();
}

class _EdgeLoaderState extends State<EdgeLoader> with SingleTickerProviderStateMixin {
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
              painter: EdgeLoaderPainter(
                animationValue: _controller.value * widget.speed,
                color: widget.color,
                radius: widget.radius,
                duration: widget.duration,
                numEdges: widget.numEdges,
              ), //
            ),
          );
        },
      ),
    );
  }
}

class EdgeLoaderPainter extends CustomPainter {
  const EdgeLoaderPainter(
      {required this.animationValue,
      required this.color,
      required this.radius,
      required this.numEdges,
      required this.duration});
  final double animationValue;
  final Color color;
  final double radius;
  final double duration;
  final double numEdges;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    Offset center = Offset(size.width / 2, size.height / 2);

    final List<List<double>> rectangles = [
      for (int i = 0; i < 32; i++)
        [
          center.dx + radius * cos(animationValue * pi * 2 + i * pi / 4),
          center.dy + radius * sin(animationValue * pi * 2 + i * pi / 4),
          center.dx + radius * cos(animationValue * pi * 2 + i * pi / 4) * (1 + i * 0.1),
          center.dy + radius * sin(animationValue * pi * 2 + i * pi / 4) * (1 + i * 0.1),
        ]
    ];

    for (int i = 0; i < rectangles.length; i++) {
      final [x, y, w, h] = rectangles[i];
      canvas.drawRect(
          Rect.fromLTRB(
            x,
            y,
            w,
            h,
          ),
          paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
