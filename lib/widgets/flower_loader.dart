import 'dart:math';
import 'package:flutter/material.dart';

/// FlowerLoader is a custom animated loader widget with a flower-like rotating effect.
///
/// It accepts the following parameters:
///  - **color**: Color - the color of the rotating flower petals
///  - **size**: double - the size of the loader (width and height of each petal)
///  - **duration**: int - the duration of one full rotation (in milliseconds)
///
/// Example usage:
/// ```dart
/// FlowerLoader(
///   color: Colors.blue,
///   size: 60,
///   duration: 2000,
/// )
/// ```

class FlowerLoader extends StatefulWidget {
  const FlowerLoader(
      {super.key, this.color = const Color.fromARGB(255, 251, 103, 152), this.size = 40.0, this.duration = 2000})
      : assert(size > 0 && duration > 0, 'Size and duration must be greater than 0.');

  final Color color;
  final double size;
  final int duration;

  @override
  State<FlowerLoader> createState() => _FlowerLoaderState();
}

class _FlowerLoaderState extends State<FlowerLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    )..repeat();
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
      builder: (context, child) {
        return SizedBox(
          width: widget.size * 2,
          height: widget.size * 2,
          child: Stack(
            children: _buildShadows(),
          ),
        );
      },
    );
  }

  List<Widget> _buildShadows() {
    List<Widget> shadows = [];
    double radius = widget.size;
    double shadowOffset = 1.005;

    for (int i = 0; i < 5; i++) {
      double angle = (i * (360 / 5) + (_controller.value * 360)) * (pi / 180);
      double xOffset = shadowOffset * cos(angle);
      double yOffset = shadowOffset * sin(angle);

      shadows.add(
        Positioned(
          left: (widget.size / 2) + xOffset * (widget.size / 2),
          top: (widget.size / 2) + yOffset * (widget.size / 2),
          child: Container(
            width: radius,
            height: radius,
            decoration: BoxDecoration(
              color: widget.color.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }

    return shadows;
  }
}
