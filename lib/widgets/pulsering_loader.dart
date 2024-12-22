import 'dart:math' as math;

import 'package:flutter/material.dart';

/// PulseRingLoader is a circular loader with a gradient effect that rotates around the center.
///
/// It is a stateful widget that takes in the following parameters:
///
/// - **color** : Color - the primary color of the loader gradient.
///
/// - **size**: double - the size of the loader (width and height).
///
/// - **duration** : Duration - the duration of the loader animation (default is 1 second).
///
/// ### Assertions:
/// - **size**: Must be greater than zero.
///
/// ### Example:
/// ```dart
/// PulseRingLoader(
///   size: 40,
///   color: Colors.blueAccent,
///   duration: const Duration(seconds: 1),
/// )
/// ```

class PulseRingLoader extends StatefulWidget {
  const PulseRingLoader(
      {super.key,
      this.size = 20,
      this.color = Colors.blueAccent,
      this.duration = const Duration(seconds: 1)})
      : assert(size > 0, 'Size must be greater than zero.');

  final double size;
  final Color color;
  final Duration duration;

  @override
  _PulseRingLoaderState createState() => _PulseRingLoaderState();
}

class _PulseRingLoaderState extends State<PulseRingLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double get size => widget.size;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) => SizedBox(
          height: size,
          width: size,
          child: CustomPaint(
            painter: CustomCircularLoader(
                controller: _controller, color: widget.color),
          )),
    );
  }
}

class CustomCircularLoader extends CustomPainter {
  CustomCircularLoader({
    required this.controller,
    required this.color,
  })  : animation = Tween(begin: 0.0, end: 1.0).animate(controller),
        super(repaint: controller);

  final AnimationController controller;
  final Animation<double> animation;
  final Color color;

  final double pi = math.pi;
  final double _epsilon = 0.000001;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final gradient = SweepGradient(
      startAngle: 0,
      endAngle: pi + (2 * pi),
      colors: [
        color,
        color.withValues(alpha: 0.9),
        color.withValues(alpha: 0.8),
        color.withValues(alpha: 0.7),
        color.withValues(alpha: 0.6),
        color.withValues(alpha: 0.5),
        color.withValues(alpha: 0.3),
        color.withValues(alpha: 0.2),
        color.withValues(alpha: 0.2),
        color.withValues(alpha: 0.1),
        const Color(0xffEAEFF5),
      ],
      stops: const [
        0.0,
        0.1,
        0.2,
        0.3,
        0.4,
        0.5,
        0.6,
        0.7,
        0.8,
        0.9,
        1.0,
      ],
      transform: GradientRotation(((2 * pi) - _epsilon) * animation.value),
    );
    final backgroundGradient = SweepGradient(
        tileMode: TileMode.decal,
        startAngle: 0,
        endAngle: 2 * pi,
        colors: [
          const Color(0xffEAEFF5),
          const Color.fromRGBO(0, 0, 0, 1).withValues(alpha: 0.1),
          color.withValues(alpha: 0.2),
          color.withValues(alpha: 0.4),
          color.withValues(alpha: 0.5),
          color.withValues(alpha: 0.6),
          color.withValues(alpha: 0.7),
          color.withValues(alpha: 0.8),
          color.withValues(alpha: 0.9),
        ],
        stops: const [
          0.0,
          0.1,
          0.2,
          0.3,
          0.4,
          0.5,
          0.6,
          0.7,
          0.8,
        ],
        transform: GradientRotation(((2 * pi)) * animation.value));
    final backgroundPaint = Paint()
      ..shader = backgroundGradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width / 5
      ..strokeCap = StrokeCap.round;
    final paint = Paint()
      ..strokeWidth = size.width / 5
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(rect)
      ..strokeCap = StrokeCap.round
      ..color = color
      ..strokeJoin = StrokeJoin.round;
    canvas.drawArc(
      rect,
      0,
      pi * 2,
      false,
      backgroundPaint,
    );
    canvas.drawArc(
      rect,
      animation.value * 2 * pi,
      0.72,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomCircularLoader oldDelegate) => false;
}
