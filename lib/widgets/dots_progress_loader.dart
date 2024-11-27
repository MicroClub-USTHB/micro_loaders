import 'package:flutter/material.dart';

/// DotsProgressLoader is a custom loader that consists of four dots that change color in sequence to indicate loading progress.
///
/// It is a stateful widget that takes in the following parameters:
///
/// - **initialColor**: Color - the initial color of the dots before they change color in sequence.
///
/// - **secondColor**: Color - the color to which each dot changes as it progresses in the sequence.
///
/// - **duration**: int - the total duration of the loader cycle (in seconds).
///
/// - **size**: double - the size of each dot in the loader (width and height).
///
/// Example usage:
/// ```dart
/// DotsProgressLoader(
///   initialColor: Colors.grey,
///   secondColor: Colors.white,
///   duration: 2,
///   size: 17,
/// )
/// ```

class DotsProgressLoader extends StatefulWidget {
  const DotsProgressLoader(
      {super.key, this.initialColor = Colors.grey, this.secondColor = Colors.white, this.duration = 2, this.size = 17})
      : assert(size > 0 && duration > 0, 'Size and duration should be greater than 0');

  final Color initialColor;
  final Color secondColor;
  final int duration;
  final double size;

  @override
  State<DotsProgressLoader> createState() => _DotsProgressLoaderState();
}

class _DotsProgressLoaderState extends State<DotsProgressLoader> with SingleTickerProviderStateMixin {
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
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            double progress = (_controller.value * 4 - index).clamp(0, 1);
            Color color = progress > 0 ? widget.secondColor : widget.initialColor;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
