import 'package:flutter/material.dart';

/// RotatingLoader is a custom loader that consists of three points rotating in a triangle formation.
///
/// It is a stateful widget that accepts the following parameters:
///
/// - **color** : Color - the color of the rotating points
///
/// - **radius** : double - the radius of each point
///
/// - **size** : double - the size of the loader (overall width and height)
///
/// - **duration** : int - the rotation duration in seconds
///
///
/// example:
/// ```dart
/// RotatingLoader(
///   color: Colors.white,
///   radius: 7,
///   size: 50,
///   duration: 1,
/// )
/// ```

class RotatingLoader extends StatefulWidget {
  const RotatingLoader({super.key, this.color = Colors.white, this.radius = 7, this.size = 50, this.duration = 1})
      : assert(size > 0 && radius > 0 && radius < (size / 6) && duration > 0);

  final Color color;
  final double radius;
  final double size;
  final int duration;

  @override
  State<RotatingLoader> createState() => _RotatingLoaderState();
}

class _RotatingLoaderState extends State<RotatingLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: widget.duration),
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
        return Transform.rotate(
          angle: _controller.value * 2 * 3.14,
          child: child,
        );
      },
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          children: [
            Positioned(
              left: 6,
              top: 10,
              child: CircleAvatar(
                radius: widget.radius,
                backgroundColor: widget.color,
              ),
            ),
            Positioned(
              left: 31,
              top: 12,
              child: CircleAvatar(
                radius: widget.radius,
                backgroundColor: widget.color,
              ),
            ),
            Positioned(
              left: 16,
              top: 32,
              child: CircleAvatar(
                radius: widget.radius,
                backgroundColor: widget.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
