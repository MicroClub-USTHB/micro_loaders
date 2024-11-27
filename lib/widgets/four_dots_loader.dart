import 'dart:math' as math;
import 'package:flutter/material.dart';

/// A customizable loader widget featuring dots that rotate, grow, and shrink
/// in synchronized transitions. Ideal for indicating loading states.
///
/// Example usage:
/// ```dart
/// FourRotatingDots(
///   size: 100.0, // Total size of the loader
///   colors: [Colors.blue, Colors.red, Colors.green, Colors.yellow], // Custom colors
///   dotCount: 4, // Number of rotating dots
/// )
/// ```

class FourRotatingDots extends StatefulWidget {
  final double size;
  final List<Color>? colors;
  final int dotCount;

  const FourRotatingDots({
    super.key,
    required this.size,
    this.colors,
    this.dotCount = 4,
  });

  @override
  _FourRotatingDotsState createState() => _FourRotatingDotsState();
}

class _FourRotatingDotsState extends State<FourRotatingDots> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat();
  }

  Widget _rotatingDots({
    required List<Color> colors,
    required double dotSize,
    required double offset,
    required double initialAngle,
    required double finalAngle,
    required Interval interval,
  }) {
    final double angle = _animationController.eval(
      Tween<double>(begin: initialAngle, end: finalAngle),
      curve: interval,
    );

    return Transform.rotate(
      angle: angle,
      child: Stack(
        alignment: Alignment.center,
        children: List.generate(
          widget.dotCount,
          (index) {
            final angleOffset = (2 * math.pi / widget.dotCount) * index;
            final color = colors[index % colors.length];
            return Transform.translate(
              offset: Offset(
                offset * math.cos(angleOffset),
                offset * math.sin(angleOffset),
              ),
              child: DrawDot.circular(
                dotSize: dotSize,
                color: color,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _animatingDots({
    required List<Color> colors,
    required double initialSize,
    required double finalSize,
    required double initialOffset,
    required double finalOffset,
    required Interval interval,
  }) {
    final double dotSize = _animationController.eval(
      Tween<double>(begin: initialSize, end: finalSize),
      curve: interval,
    );

    return Stack(
      alignment: Alignment.center,
      children: List.generate(
        widget.dotCount,
        (index) {
          final angleOffset = (2 * math.pi / widget.dotCount) * index;
          final color = colors[index % colors.length];
          final offset = _animationController.eval(
            Tween<double>(begin: initialOffset, end: finalOffset),
            curve: interval,
          );
          return Transform.translate(
            offset: Offset(
              offset * math.cos(angleOffset),
              offset * math.sin(angleOffset),
            ),
            child: DrawDot.circular(
              dotSize: dotSize,
              color: color,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double size = widget.size;
    final double maxDotSize = size * 0.30;
    final double minDotSize = size * 0.14;
    final double maxOffset = size * 0.35;

    final List<Color> colors = widget.colors ?? [Theme.of(context).primaryColor];

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[
              // Phase 1: Dots move inward and shrink
              _animatingDots(
                colors: colors,
                initialSize: maxDotSize,
                finalSize: minDotSize,
                initialOffset: maxOffset,
                finalOffset: 0,
                interval: const Interval(0.0, 0.3, curve: Curves.easeInOut),
              ),
              // Phase 2: Rotating dots
              _rotatingDots(
                colors: colors,
                dotSize: minDotSize,
                offset: maxOffset,
                initialAngle: 0,
                finalAngle: 2 * math.pi,
                interval: const Interval(0.3, 0.7, curve: Curves.linear),
              ),
              // Phase 3: Dots move outward and grow
              _animatingDots(
                colors: colors,
                initialSize: minDotSize,
                finalSize: maxDotSize,
                initialOffset: 0,
                finalOffset: maxOffset,
                interval: const Interval(0.7, 1.0, curve: Curves.easeInOut),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

extension LoadingAnimationControllerX on AnimationController {
  T eval<T>(Tween<T> tween, {Curve curve = Curves.linear}) => tween.transform(curve.transform(value));
}

class DrawDot extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const DrawDot.circular({
    super.key,
    required double dotSize,
    required this.color,
  })  : width = dotSize,
        height = dotSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
