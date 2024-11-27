import 'dart:math';
import 'package:flutter/material.dart';

/// CircleDualDotsLoader is a custom loader that consists of two dots rotating
/// around a central circular border. The dots move in opposite directions
/// and rotate continuously.
///
/// It is a stateful widget that takes in the following parameters:
///
///  - **size**: double - the size of the loader (width and height of the loader)
///  - **color**: Color - the color of the circular border
///  - **dotColor**: Color - the color of the rotating dots
///  - **dotSize**: double - the size of the rotating dots
///  - **duration**: int - the duration of the loader’s animation (in milliseconds)
///
/// assert: size > 0, duration > 0, dotSize > 0
///
///  Example:
///  ```dart
///  CircleDualDotsLoader(
///    size: 48,
///    color: Colors.white,
///    dotColor: Colors.orange,
///    dotSize: 6,
///    duration: 1000,
///  )
///  ```
class CircleDualDotsLoader extends StatefulWidget {
  const CircleDualDotsLoader({
    super.key,
    this.size = 48,
    this.color = Colors.white,
    this.dotColor = const Color(0xFFFF3D00),
    this.dotSize = 6.0,
    this.duration = 1000,
  }) : assert(size > 0 && duration > 0 && dotSize > 0);

  final double size;
  final Color color;
  final Color dotColor;
  final double dotSize;
  final int duration;

  @override
  State<CircleDualDotsLoader> createState() => _CircleDualDotsLoaderState();
}

class _CircleDualDotsLoaderState extends State<CircleDualDotsLoader> with SingleTickerProviderStateMixin {
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
            painter: CircleDualDotsLoaderPainter(
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

class CircleDualDotsLoaderPainter extends CustomPainter {
  final double rotation;
  final Color color;
  final Color dotColor;
  final double dotSize;

  CircleDualDotsLoaderPainter({
    required this.rotation,
    required this.color,
    required this.dotColor,
    required this.dotSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    // Draw the circular border
    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);

    final dotPaint = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;

    final radius = size.width / 2;
    final angle1 = rotation * 2 * pi;
    final angle2 = angle1 + pi; // 180-degree opposite for the second dot

    final dot1 = Offset(
      size.center(Offset.zero).dx + radius * 0.75 * cos(angle1),
      size.center(Offset.zero).dy + radius * 0.75 * sin(angle1),
    );

    final dot2 = Offset(
      size.center(Offset.zero).dx + radius * 0.75 * cos(angle2),
      size.center(Offset.zero).dy + radius * 0.75 * sin(angle2),
    );

    // Draw the two rotating dots
    canvas.drawCircle(dot1, dotSize / 2, dotPaint);
    canvas.drawCircle(dot2, dotSize / 2, dotPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
