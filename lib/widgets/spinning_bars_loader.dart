import 'package:flutter/material.dart';

/// SpinningBarsLoader is a custom loader made up of 12 bars that fade in and out as they rotate around a circle.
///
/// It is a stateful widget with the following parameters:
///
/// - **size**: double - the size of the loader (width and height of the loader).
///
/// - **barHeight**: double - the height of each bar in the loader.
///
/// - **color**: Color - the color of the loader bars.
///
/// - **duration**: int - the duration of the animation (in seconds).
///
/// Example:
/// ```dart
/// SpinningBarsLoader(
/// size: 50,
/// barHeight: 14,
/// color: Colors.white,
/// duration: 1
/// )
/// ```

class SpinningBarsLoader extends StatefulWidget {
  const SpinningBarsLoader(
      {super.key, this.size = 50, this.barHeight = 14, this.color = Colors.white, this.duration = 1})
      : assert(size > 0 && barHeight > 0 && barHeight < size && duration > 0,
            'Size must be greater than 0, bar height must be greater than 0 and less than size, and duration must be greater than 0.');

  final double size;
  final double barHeight;
  final Color color;
  final int duration;

  @override
  State<SpinningBarsLoader> createState() => _SpinningBarsLoaderState();
}

class _SpinningBarsLoaderState extends State<SpinningBarsLoader> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          children: List.generate(12, (index) {
            final double angle = (index * 30) * 3.14 / 180;

            return AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                double barOffset = index / 12;
                double progress = (_controller.value - barOffset) % 1;

                double opacity;
                if (progress < 0.5) {
                  opacity = progress * 2;
                } else {
                  opacity = (1 - progress) * 2;
                }

                opacity = opacity.clamp(0.0, 1.0);

                return Transform.rotate(
                  angle: angle,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 4,
                      height: widget.barHeight,
                      decoration: BoxDecoration(
                        color: widget.color.withOpacity(opacity),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
