import 'dart:math';
import 'package:flutter/material.dart';

/// CircleRotatingDotsLoader is a custom loader made up of two dots that rotate around a circular border.
///
/// It is a stateful widget that takes in the following parameters:
///
///  - **color** : Color - the color of the loader's circular border
///  - **dotColor** : Color - the color of the rotating dots
///  - **dotSize** : double - the size of the rotating dots
///  - **size** : double - the size of the loader (width and height of the loader)
///  - **duration** : int - the duration of the loader's rotation animation (in milliseconds)
/// assert: dotSize > 0 && size > 0 && duration > 0
///
///  example:
///  ```dart
/// CircleRotatingDotsLoader(
/// color: Colors.white,
/// dotColor: Colors.orange,
/// dotSize: 6.0,
/// size: 48,
/// duration: 1000,
/// )
/// ```

class CircleRotatingDotsLoader extends StatefulWidget {
  const CircleRotatingDotsLoader({
    super.key,
    this.size = 48,
    this.color = Colors.white,
    this.dotColor = const Color(0xFFFF3D00),
    this.dotSize = 6.0,
    this.duration = 1000,
  }) : assert(size > 0 && dotSize > 0 && duration > 0);

  final double size;
  final Color color;
  final Color dotColor;
  final double dotSize;
  final int duration;

  @override
  _CircleRotatingDotsLoaderState createState() => _CircleRotatingDotsLoaderState();
}

class _CircleRotatingDotsLoaderState extends State<CircleRotatingDotsLoader> with SingleTickerProviderStateMixin {
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
          return CustomPaint(
            painter: CircleRotatingDotsLoaderPainter(
              rotation: _controller.value,
              color: widget.color,
              dotColor: widget.dotColor,
              dotSize: widget.dotSize,
            ),
          );
        },
      ),
    );
  }
}

class CircleRotatingDotsLoaderPainter extends CustomPainter {
  final double rotation;
  final Color color;
  final Color dotColor;
  final double dotSize;

  CircleRotatingDotsLoaderPainter({
    required this.rotation,
    required this.color,
    required this.dotColor,
    required this.dotSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = color;

    // Draw the circular border
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    // Draw the rotating dots outside the circle
    final dotPaint = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;

    final radius = size.width / 2 + dotSize / 2 + 4; // Dots placed outside the circle

    final angle1 = rotation * 2 * pi;
    final angle2 = angle1 + pi;

    // Position the dots outside the circle
    final dot1 = Offset(
      size.center(Offset.zero).dx + radius * cos(angle1),
      size.center(Offset.zero).dy + radius * sin(angle1),
    );

    final dot2 = Offset(
      size.center(Offset.zero).dx + radius * cos(angle2),
      size.center(Offset.zero).dy + radius * sin(angle2),
    );

    // Draw the dots
    canvas.drawCircle(dot1, dotSize / 2, dotPaint);
    canvas.drawCircle(dot2, dotSize / 2, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
