import 'package:flutter/material.dart';

/// ColorfulDotsLoader is a loading animation widget that displays colorful dots sliding horizontally.
///
/// The dots move back and forth within a container, with each dot following a staggered animation pattern.
/// The animation loops infinitely, creating a smooth and dynamic effect.
///
/// ### Parameters:
///
/// - **colors** : List<Color> - the colors of the dots in the loader (required).
/// - **duration** : int - the duration of the animation cycle in milliseconds (default is 1500).
/// - **loadingColor** : Color - the color of the "Loading" text (default is white).
/// - **dotSize** : double - the size of each dot in the animation (default is 27).
/// - **borderColor** : Color - the color of the border around each dot (default is white).
/// - **height** : double - the height of the entire loader container (default is 40).
/// - **width** : double - the width of the entire loader container (default is 260).
/// - **fontSize** : double - the font size of the "Loading" text (default is 20).
///
/// ### Example:
/// ```dart
/// ColorfulDotsLoader(
///   colors: [Colors.red, Colors.green, Colors.blue, Colors.yellow, Colors.pink, Colors.purple],
///   duration: 1500,
///   loadingColor: Colors.blue,
///   dotSize: 27,
///   borderColor: Colors.red,
///   height: 40,
///   width: 260,
///   fontSize: 20,
/// )
/// ```

class ColorfulDotsLoader extends StatefulWidget {
  const ColorfulDotsLoader({
    super.key,
    required this.colors,
    this.duration = 1500,
    this.loadingColor = Colors.white,
    this.dotSize = 27,
    this.borderColor = Colors.white,
    this.height = 40,
    this.width = 260,
    this.fontSize = 20,
  }) : assert(duration > 0 && dotSize > 0 && height > 0 && width > 0,
            'Duration, dot size, height, and width must be greater than 0');

  final int duration;
  final Color loadingColor;
  final double dotSize;
  final Color borderColor;
  final double height;
  final double width;
  final double fontSize;
  final List<Color> colors;

  @override
  State<ColorfulDotsLoader> createState() => _ColorfulDotsLoaderState();
}

class _ColorfulDotsLoaderState extends State<ColorfulDotsLoader> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late List<Animation<double>> _dotAnimations;
  List<Animation<double>> generateAnimationsDots() {
    return List.generate(widget.colors.length, (index) {
      final start = index * 0.05;
      final end = start + 0.4;
      return Tween<double>(begin: 0, end: widget.width - 30).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            start.clamp(0.0, 1.0),
            end.clamp(0.0, 1.0),
            curve: Curves.easeInOut,
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: widget.duration),
      vsync: this,
    )..repeat(reverse: true);
    _dotAnimations = generateAnimationsDots();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ColorfulDotsLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    _dotAnimations = generateAnimationsDots();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: Stack(
          children: List.generate(widget.colors.length, (index) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Positioned(
                  left: _dotAnimations[index].value,
                  child: Container(
                    height: widget.dotSize,
                    width: widget.dotSize,
                    decoration: BoxDecoration(
                      color: widget.colors[index],
                      shape: BoxShape.circle,
                      border: Border.all(color: widget.borderColor, width: 2),
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
