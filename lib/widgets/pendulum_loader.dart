// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';

/// PendulumLoader is a custom loader with a series of pendulums swinging from side to side.
///
/// It is a stateful widget that takes the following parameters:
///
///  - **duration** : int - the duration of each pendulum's swing (in milliseconds)
///
///  - **size**: double - the size of pendulum's line (height of pendulum's line)
///
///  - **width**: double - the width of pendulum's line
///
///  - **color** : Color - the color of the pendulums
///
/// Example:
/// ```dart
/// PendulumLoader(
///   duration: 500,
///   size: 30,
///   width: 2,
///   color: Colors.white,
/// )
/// ```

class PendulumLoader extends StatefulWidget {
  const PendulumLoader({super.key, this.duration = 500, this.size = 30, this.width = 2, this.color = Colors.white})
      : assert(duration > 0 && size > 0 && width > 0,
            'duration must be greater than 0, size must be greater than 0, and width must be greater than 0');

  final int duration;
  final double size;
  final double width;
  final Color color;

  @override
  State<PendulumLoader> createState() => _PendulumLoaderState();
}

class _PendulumLoaderState extends State<PendulumLoader> with TickerProviderStateMixin {
  late final AnimationController _firstController;
  late final AnimationController _lastController;
  late final Animation<double> _firstRotationAnimation;
  late final Animation<double> _lastRotationAnimation;

  @override
  void initState() {
    super.initState();

    _firstController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    _lastController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    _firstRotationAnimation = Tween<double>(begin: 0, end: 30).animate(CurvedAnimation(
      parent: _firstController,
      curve: Curves.easeInOut,
    ));

    _lastRotationAnimation = Tween<double>(begin: 0, end: 30).animate(CurvedAnimation(
      parent: _lastController,
      curve: Curves.easeInOut,
    ));

    _startAnimationSequence();
  }

  void _startAnimationSequence() async {
    while (mounted) {
      await _firstController.forward();
      await _firstController.reverse();

      await _lastController.forward();
      await _lastController.reverse();
    }
  }

  @override
  void dispose() {
    _firstController.dispose();
    _lastController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        if (index == 0) {
          return AnimatedBuilder(
            animation: _firstRotationAnimation,
            builder: (context, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateZ(_firstRotationAnimation.value * 3.14 / 180),
                    alignment: Alignment.topCenter,
                    child: Pendulum(
                      color: widget.color,
                      lineWidth: widget.width,
                      lineHeight: widget.size,
                      circleSize: widget.size / 2,
                    ),
                  ),
                ],
              );
            },
          );
        } else if (index == 4) {
          return AnimatedBuilder(
            animation: _lastRotationAnimation,
            builder: (context, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..rotateZ(-_lastRotationAnimation.value * 3.14 / 180),
                    alignment: Alignment.topCenter,
                    child: Pendulum(
                      color: widget.color,
                      lineWidth: widget.width,
                      lineHeight: widget.size,
                      circleSize: widget.size / 2,
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          return Pendulum(
            color: widget.color,
            lineWidth: widget.width,
            lineHeight: widget.size,
            circleSize: widget.size / 2,
          );
        }
      }),
    );
  }
}

class Pendulum extends StatelessWidget {
  const Pendulum(
      {super.key, required this.color, required this.lineWidth, required this.lineHeight, required this.circleSize});

  final Color color;
  final double lineWidth;
  final double lineHeight;
  final double circleSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: lineWidth,
          height: lineHeight,
          color: color,
        ),
        Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ],
    );
  }
}
