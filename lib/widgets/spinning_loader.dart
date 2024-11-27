import 'dart:math';
import 'package:flutter/material.dart';

/// SpinningLoader is a custom animated loader widget that spins a series of colored dots
/// arranged in a circular pattern.
///
/// This loader widget uses an `AnimationController` to rotate a series of dots around the center,
/// giving a spinning effect.
///
/// ### Example:
/// ```dart
/// const SpinningLoader();
/// ```
///
/// - The loader is visually composed of eight dots arranged in a circular pattern,
///   alternating in color between orange and red.
/// - It animates continuously, providing a visual indication of loading activity.

class SpinningLoader extends StatefulWidget {
  const SpinningLoader({super.key});

  @override
  State<SpinningLoader> createState() => _SpinningLoaderState();
}

class _SpinningLoaderState extends State<SpinningLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.rotate(
          angle: _animation.value,
          child: CustomPaint(
            size: const Size(48, 48),
            key: const Key('main_custom_paint'),
            painter: SpinningLoaderPainter(),
          ),
        );
      },
    );
  }
}

class SpinningLoaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final double radius = size.width / 2;

    canvas.drawCircle(Offset(radius, radius), radius, paint);

    for (int i = 0; i < 8; i++) {
      double angle = pi / 4 * i;
      double x = radius + radius * cos(angle);
      double y = radius + radius * sin(angle);
      canvas.drawCircle(
        Offset(x, y),
        4,
        paint..color = (i.isEven) ? Colors.orange : Colors.red,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
