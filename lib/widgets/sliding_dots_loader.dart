import 'package:flutter/material.dart';

/// SlidingDotsLoader is a custom loader that displays a series of animated dots moving
/// from left to center and then to the right. The dots animate in a sequence based on
/// the provided duration and other parameters.
///
/// It is a stateful widget that takes in the following parameters:
///
/// - **duration** : int - The duration (in seconds) for the entire animation cycle (default is 3 seconds).
///
/// - **size** : double - The size (width and height) of each dot in the loader (default is 10).
///
/// - **color** : Color - The color of the dots (default is white).
///
/// ### Example:
/// ```dart
/// SlidingDotsLoader(
///   size: 15,
///   color: Colors.blue,
///   duration: 4,
/// )
/// ```
///

class SlidingDotsLoader extends StatefulWidget {
  const SlidingDotsLoader({super.key, this.duration = 3, this.size = 10, this.color = Colors.white})
      : assert(size > 0 && duration > 0, 'Size and duration must be greater than 0');

  final int duration;
  final double size;
  final Color color;

  @override
  State<SlidingDotsLoader> createState() => _SlidingDotsLoaderState();
}

class _SlidingDotsLoaderState extends State<SlidingDotsLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _animationsLeftToCenter;
  late List<Animation<double>> _animationsCenterToRight;
  double screenWidth = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    )..repeat();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        screenWidth = MediaQuery.of(context).size.width;
        _initializeAnimations();
      });
    });
  }

  void _initializeAnimations() {
    if (screenWidth == 0) return;

    double movementDistance = screenWidth * 0.6;

    _animationsLeftToCenter = List.generate(4, (index) {
      return Tween<double>(begin: -movementDistance, end: 0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.125, (index + 1) * 0.125, curve: Curves.linear),
        ),
      );
    });

    _animationsCenterToRight = List.generate(4, (index) {
      return Tween<double>(begin: 0, end: movementDistance).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.5 + (index * 0.125), 0.625 + (index * 0.125), curve: Curves.linear),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return screenWidth == 0
        ? const SizedBox()
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(4, (index) => _buildDot(index)),
          );
  }

  Widget _buildDot(int index) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double offset = _animationsLeftToCenter[index].value;

        if (_controller.value >= 0.5) {
          offset = _animationsCenterToRight[index].value;
        }

        return Transform.translate(
          offset: Offset(offset, 0),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              color: widget.color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
