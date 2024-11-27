import 'package:flutter/material.dart';

/// FadeScaleLoader is a circular loader that animates by scaling up and fading out.
///
/// This widget is useful for displaying a simple loading indicator with a fade and scale effect.
///
/// - **duration**: int - duration of each animation cycle in seconds.
/// - **color**: Color - color of the loader.
/// - **size**: double - size of the loader in pixels.
///
/// ### Example:
/// ```dart
/// FadeScaleLoader(
///   duration: 1,
///   color: Colors.white,
///   size: 60,
/// )
/// ```

class FadeScaleLoader extends StatefulWidget {
  const FadeScaleLoader({super.key, this.duration = 1, this.color = Colors.white, this.size = 60})
      : assert(duration > 0 && size > 0, 'Duration and size must be greater than 0');

  final int duration;
  final Color color;
  final double size;

  @override
  State<FadeScaleLoader> createState() => _FadeScaleLoaderState();
}

class _FadeScaleLoaderState extends State<FadeScaleLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    )..repeat(reverse: false);

    _scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
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
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                color: widget.color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }
}
