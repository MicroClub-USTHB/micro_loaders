import 'dart:math';
import 'package:flutter/material.dart';

/// CircleDotsLoader is a custom loader that displays 8 dots rotating around a central point.
///
/// It is a stateful widget that takes in the following parameters:
///
/// - **size**: double - the overall size of the loader (width and height).
/// - **color**: Color - the color of the dots.
/// - **duration**: int - the duration of the animation cycle (in seconds).
///
/// Example:
/// ```dart
/// CircleDotsLoader(
///   size: 100,
///   color: Colors.blue,
///   duration: 1,
/// )
///

class CircleDotsLoader extends StatefulWidget {
  const CircleDotsLoader({
    super.key,
    this.size = 100,
    this.color = Colors.white,
    this.duration = 1,
  }) : assert(size > 0 && duration > 0, 'Size and duration must be greater than 0.');

  final double size;
  final Color color;
  final int duration;

  @override
  State<CircleDotsLoader> createState() => _DotsLoaderState();
}

class _DotsLoaderState extends State<CircleDotsLoader> with SingleTickerProviderStateMixin {
  late AnimationController _dotsController;
  late List<Animation<double>> _opacities;

  @override
  void initState() {
    super.initState();
    _dotsController = AnimationController(
      duration: Duration(seconds: widget.duration),
      vsync: this,
    )..repeat();

    _opacities = List.generate(8, (index) {
      final start = index / 8;
      final end = (index + 1) / 8;
      return Tween<double>(begin: 0.2, end: 0.7).animate(CurvedAnimation(
        parent: _dotsController,
        curve: Interval(start, end, curve: Curves.easeInOut),
      ));
    });
  }

  @override
  void dispose() {
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _dotsController,
        builder: (context, child) {
          return SizedBox(
            width: widget.size,
            height: widget.size,
            child: Stack(
              children: List.generate(8, (index) {
                final angle = (index * pi / 4) - (pi / 2);
                final x = cos(angle) * (widget.size / 3.0);
                final y = sin(angle) * (widget.size / 3.0);

                return Positioned(
                  left: (widget.size / 2) + x - 6,
                  top: (widget.size / 2) + y - 6,
                  child: FadeTransition(
                    opacity: _opacities[index],
                    child: Dot(color: widget.color),
                  ),
                );
              }),
            ),
          );
        });
  }
}

class Dot extends StatelessWidget {
  final Color color;
  const Dot({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
