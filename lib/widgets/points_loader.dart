import 'package:flutter/material.dart';
import 'dart:math';

/// PointsLoader is a custom loader that is made up of 16 points that rotate around a circle.
///
/// It is a stateful widget that takes in the following parameters:
///
///  - **color** : Color - the color of the loader
///
///  - **size**: double - the size of the loader (width and height of the loader)
///
///
///  - **duration** : int - the duration of the loader  (in milliseconds)
///
///  - **strokeWidth** : double - the width of the loader (thickness of the points )
///
///  assert: strokeWidth < (size / 13)
///
///  example :
///  ```dart
///  PointsLoader(
///  size: 80,
///  color: Colors.deepPurple,
///  duration: 1500,
///  strokeWidth: 6
///  )
/// ```

class PointsLoader extends StatefulWidget {
  const PointsLoader({super.key, this.size = 80, this.color = Colors.white, this.duration = 1500, this.strokeWidth = 6})
      : assert(size > 0 && (strokeWidth < (size / 12) && strokeWidth > 0 && duration > 1000));
  final double size;
  final Color color;
  final double strokeWidth;
  final int duration;
  @override
  State<PointsLoader> createState() => _PointsLoaderState();
}

class _PointsLoaderState extends State<PointsLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
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
              angle: (_controller.value * 2 * pi),
              child: CustomPaint(
                painter: FirstLoaderPainter(
                  color: widget.color,
                  strokeWidth: widget.strokeWidth,
                ),
              ),
            );
          }),
    );
  }
}

class FirstLoaderPainter extends CustomPainter {
  const FirstLoaderPainter({required this.strokeWidth, required this.color});
  final double strokeWidth;
  final Color color;
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;
    double startOfArcInDegree = 90;
    canvas.drawArc(rect, (3 * pi) / 2, pi, false, paint);

    for (var i = 0; i < 16; i++) {
      canvas.drawArc(rect, inRads(startOfArcInDegree), inRads(1), false, paint);
      startOfArcInDegree += 12;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

double inRads(double degree) {
  return (degree * pi) / 180;
}
