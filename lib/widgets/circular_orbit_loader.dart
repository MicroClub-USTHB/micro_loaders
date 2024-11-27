import 'package:flutter/material.dart';
import 'dart:math';

/// The `Circular Orbit Loader` animates black dots,
/// providing a fun and engaging way to indicate loading. This loader
/// is particularly suited for applications or websites with a casual
/// or playful aesthetic.
///
/// ### Features:
/// - Customizable size and color.
/// - Adjustable animation duration.
///
/// Example usage:
/// ```dart
/// DotsLoaderView(
///   size: 12.0,
///   color: Colors.red,
///   duration: Duration(milliseconds: 1200),
/// );
/// ```

class CircularOrbitLoader extends StatefulWidget {
  final double size; // Diameter of the loader
  final Color color; // Color of the circles
  final Duration duration; // Animation duration

  const CircularOrbitLoader({
    super.key,
    this.size = 100.0,
    this.color = Colors.white,
    this.duration = const Duration(seconds: 2),
  });

  @override
  State<CircularOrbitLoader> createState() => _CircularOrbitLoaderState();
}

class _CircularOrbitLoaderState extends State<CircularOrbitLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(); // Infinite animation loop
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
            angle: _controller.value * 2 * pi, // Rotate the loader
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Central circle
                _buildCircle(widget.size / 2, widget.color),
                // Orbiting circle 1
                _buildOrbitingCircle(
                  widget.size / 2 * 0.6, // Offset from the center
                  widget.color,
                  0, // No delay for the first circle
                ),
                // Orbiting circle 2
                _buildOrbitingCircle(
                  widget.size / 2 * 0.6,
                  widget.color,
                  0.5, // Half a cycle delay for the second circle
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCircle(double diameter, Color color) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }

  Widget _buildOrbitingCircle(double offset, Color color, double delay) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angle = (2 * pi * (_controller.value + delay)) % (2 * pi);
        return Transform.translate(
          offset: Offset(cos(angle) * offset, sin(angle) * offset),
          child: _buildCircle(widget.size * 0.15, color), // Smaller orbiting circle
        );
      },
    );
  }
}
