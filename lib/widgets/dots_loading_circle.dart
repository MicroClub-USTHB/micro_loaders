import 'package:flutter/material.dart';

/// A playful loader widget that animates a series of bouncing dots.
///
/// The `DotsLoaderView` animates black dots that bounce in and out,
/// providing a fun and engaging way to indicate loading. This loader
/// is particularly suited for applications or websites with a casual
/// or playful aesthetic.
///
/// ### Features:
/// - Configurable number of dots.
/// - Customizable size and color of dots.
/// - Adjustable animation duration.
///
/// Example usage:
/// ```dart
/// DotsLoaderView(
///   dotCount: 5,
///   dotSize: 12.0,
///   duration: Duration(milliseconds: 1200),
///   dotColor: Colors.red,
/// );
/// ```
class DotsLoaderView extends StatefulWidget {
  const DotsLoaderView({
    super.key,
    this.dotCount = 4,
    this.dotSize = 10.0,
    this.duration = const Duration(milliseconds: 800),
    this.dotColor = Colors.white,
  });

  /// The number of dots in the loader animation. Default is 3.
  final int dotCount;

  /// The diameter of each dot. Default is 10.0.
  final double dotSize;

  /// The duration of the animation cycle. Default is 800 milliseconds.
  final Duration duration;

  /// The color of the dots. Default is [Colors.black].
  final Color dotColor;

  /// Creates a new instance of [DotsLoaderView].
  ///
  /// All parameters are optional and have default values.

  @override
  _DotsLoaderViewState createState() => _DotsLoaderViewState();
}

class _DotsLoaderViewState extends State<DotsLoaderView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.dotCount, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final animationValue = (_controller.value + index / widget.dotCount) % 1;
            final bounce = Tween<double>(begin: 0.0, end: -widget.dotSize * 2)
                .transform(Curves.easeInOut.transform(animationValue));

            return Transform.translate(
              offset: Offset(0, bounce),
              child: Container(
                width: widget.dotSize,
                height: widget.dotSize,
                margin: EdgeInsets.symmetric(horizontal: widget.dotSize / 2),
                decoration: BoxDecoration(
                  color: widget.dotColor,
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
