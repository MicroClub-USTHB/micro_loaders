import 'package:flutter/material.dart';

/// ScaleDotsLoader is a row of animated dots that scale sequentially, creating a pulsing effect.
///
/// This is a stateful widget that takes the following parameters:
///
/// - **duration** : int - duration of each dot animation in milliseconds.
/// - **color** : Color - color of the dots.
/// - **size** : double - size of each dot (width and height).
///
/// ### Example:
/// ```dart
/// ScaleDotsLoader(
///   duration: 150,
///   color: Colors.black,
///   size: 12,
/// )
/// ```

class ScaleDotsLoader extends StatefulWidget {
  const ScaleDotsLoader({super.key, this.duration = 150, this.color = Colors.white, this.size = 12})
      : assert(size > 0 && duration > 0, 'Size and duration must be greater than 0');

  final int duration;
  final Color color;
  final double size;

  @override
  State<ScaleDotsLoader> createState() => _ScaleDotsLoaderState();
}

class _ScaleDotsLoaderState extends State<ScaleDotsLoader> with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();

    _controllers = List.generate(4, (index) {
      return AnimationController(
        duration: Duration(milliseconds: widget.duration),
        vsync: this,
      );
    });

    _animations = _controllers.map((controller) {
      return Tween<double>(begin: 0.8, end: 1.3).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInOut),
      );
    }).toList();

    _startSequentialAnimation();
  }

  void _startSequentialAnimation() async {
    while (true) {
      for (int i = 0; i < _controllers.length; i++) {
        await _controllers[i].forward();
        await _controllers[i].reverse();
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(4, (index) {
        return AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Transform.scale(
              scale: _animations[index].value,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.5),
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
      }),
    );
  }
}
