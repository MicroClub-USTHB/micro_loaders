import 'package:flutter/material.dart';

/// ProgressLoader is a custom horizontal loader with a sliding progress indicator.
///
/// It is a stateful widget that takes in the following parameters:
///
///  - **width**: double - the width of the loader container
///
///  - **height**: double - the height of the loader container
///
///  - **duration**: int - the animation duration in seconds
///
///  - **borderColor**: Color - the color of the loader's border
///
///  - **progressColor**: Color - the color of the progress indicator
///
/// Example:
/// ```dart
/// ProgressLoader(
///   width: 120,
///   height: 22,
///   duration: 2,
///   borderColor: Colors.white,
///   progressColor: Colors.white,
/// )
/// ```

class ProgressLoader extends StatefulWidget {
  const ProgressLoader(
      {super.key,
      this.width = 120,
      this.height = 22,
      this.duration = 2,
      this.borderColor = Colors.white,
      this.progressColor = Colors.white})
      : assert(width > 0 && height > 0 && duration > 0);

  final double width;
  final double height;
  final int duration;
  final Color borderColor;
  final Color progressColor;

  @override
  State<ProgressLoader> createState() => _ProgressLoaderState();
}

class _ProgressLoaderState extends State<ProgressLoader> with SingleTickerProviderStateMixin {
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
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: widget.borderColor, width: 4),
      ),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                left: -widget.width + _controller.value * (widget.width * 2),
                child: Container(
                  width: widget.width,
                  height: widget.height + 2,
                  decoration: BoxDecoration(
                    color: widget.progressColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
