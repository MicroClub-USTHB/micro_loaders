import 'package:flutter/material.dart';

/// A customizable loader widget that animates a series of sliding squares.
///
/// This widget creates a visually engaging loader by animating squares
/// that slide horizontally in a looping motion. It is designed to keep
/// users entertained while waiting for an action to complete.
///
/// ### Features:
/// - Adjustable number of squares.
/// - Customizable size, spacing, and color of squares.
/// - Configurable animation duration.
///
/// Example usage:
/// ```dart
/// SlidingSquareLoaderView(
///   squareCount: 5,
///   squareSize: 25.0,
///   spacing: 12.0,
///   duration: Duration(milliseconds: 1000),
///   squareColor: Colors.red,
/// );
/// ```

class SlidingSquareLoaderView extends StatefulWidget {
  final int squareCount;
  final double squareSize;
  final double spacing;
  final Duration duration;
  final Color squareColor;

  const SlidingSquareLoaderView({
    super.key,
    this.squareCount = 4,
    this.squareSize = 20.0,
    this.spacing = 10.0,
    this.duration = const Duration(milliseconds: 800),
    this.squareColor = Colors.white,
  });

  @override
  _SlidingSquareLoaderViewState createState() => _SlidingSquareLoaderViewState();
}

class _SlidingSquareLoaderViewState extends State<SlidingSquareLoaderView> with SingleTickerProviderStateMixin {
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
      children: List.generate(widget.squareCount, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final animationValue = (_controller.value + index / widget.squareCount) % 1;
            final offset =
                Tween<double>(begin: 0.0, end: widget.spacing * widget.squareCount).transform(animationValue);
            return Transform.translate(
              offset: Offset(offset, 0),
              child: Container(
                width: widget.squareSize,
                height: widget.squareSize,
                margin: EdgeInsets.only(right: widget.spacing),
                color: widget.squareColor,
              ),
            );
          },
        );
      }),
    );
  }
}
