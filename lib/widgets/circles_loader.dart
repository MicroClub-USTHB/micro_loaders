import 'dart:math';

import 'package:flutter/material.dart';

/// CirclesLoader is a custom loader that is made up of 8 circles that rotate around a square.
///
/// It is a stateful widget that takes in the following parameters:
///
///  - **color** : Color - the color of the loader
///  - **radius** : double - the radius of the circles
/// - **size**: double - the size of the loader (width and height of the loader)
/// - **duration** : int - the duration of the loader  (in milliseconds)
/// assert: radius >= 0 && size > 0 && duration > 0
///
///  example :
///  ```dart
/// CirclesLoader(
/// color: Colors.deepPurple,
/// radius: 30,
/// size: 150,
/// duration: 1500,
/// )
/// ```
class CirclesLoader extends StatefulWidget {
  const CirclesLoader({super.key, this.size = 150, this.color = Colors.red, this.radius = 25, this.duration = 1000})
      : assert(radius >= 0 && size > 0 && duration > 0);

  final double size;
  final Color color;
  final double radius;
  final double duration;

  @override
  State<CirclesLoader> createState() => _CirclesLoaderState();
}

class _CirclesLoaderState extends State<CirclesLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration.toInt()),
      vsync: this,
    )..reverse();

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
          return Transform.rotate(
            angle: _controller.value * pi,
            child: CustomPaint(
              painter: CirclesLoaderPainter(
                animationValue: _controller.value,
                color: widget.color,
                radius: widget.radius,
                duration: widget.duration,
              ), //
            ),
          );
        },
      ),
    );
  }
}

class CirclesLoaderPainter extends CustomPainter {
  const CirclesLoaderPainter(
      {required this.animationValue, required this.color, required this.radius, required this.duration});
  final double animationValue;
  final Color color;
  final double radius;
  final double duration;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    final points = [
      Offset(size.width / 2 - radius / 2, size.height / 2 + radius / 2),
      Offset(size.width / 2 - radius / 2, size.height / 2 - radius / 2),
      Offset(size.width / 2 + radius / 2, size.height / 2 - radius / 2),
      Offset(size.width / 2 + radius / 2, size.height / 2 + radius / 2),
      Offset(size.width / 2 - radius / 2, size.height / 2 + radius / 2),
      Offset(size.width / 2, size.height / 2),
      Offset(size.width / 2 - radius / 2, size.height / 2 - radius / 2),
      Offset(size.width / 2, size.height / 2),
    ];

    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], radius * (animationValue), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
