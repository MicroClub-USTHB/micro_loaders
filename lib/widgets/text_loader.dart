import 'package:flutter/material.dart';

/// TextLoader is a text-based loader that animates letters appearing sequentially.
///
/// The animation loops infinitely, progressively revealing the text one letter at a time.
/// The animation reverses direction at the end, creating a continuous back-and-forth effect.
///
/// ### Parameters:
///
/// - **duration** : int - the duration of the forward-and-reverse animation cycle in seconds (default is 2 seconds).
/// - **textStyle** : TextStyle? - the text style applied to the animated text (default is the app's headline style).
/// - **text** : String - the text to be animated (default is "Loading...").
///
/// ### Example:
/// ```dart
/// TextLoader(
///   duration: 3,
///   text: "Processing...",
///   textStyle: TextStyle(
///     fontWeight: FontWeight.bold,
///     fontSize: 30,
///     color: Colors.blueAccent,
///   ),
/// )
/// ```

class TextLoader extends StatefulWidget {
  const TextLoader({super.key, this.duration = 2, this.textStyle, this.text = 'Loading...'})
      : assert(duration > 0, 'Duration must be greater than 0');

  final int duration;
  final TextStyle? textStyle;
  final String text;

  @override
  State<TextLoader> createState() => _TextLoaderState();
}

class _TextLoaderState extends State<TextLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _letterAnimation;

  Animation<int> _stepTween(controller) {
    return StepTween(begin: 0, end: widget.text.length).animate(
      CurvedAnimation(parent: controller, curve: Curves.linear),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.duration),
    )..repeat(reverse: true);

    _letterAnimation = _stepTween(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TextLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    _letterAnimation = _stepTween(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _letterAnimation,
        builder: (context, child) {
          final text = widget.text;
          final visibleText = text.substring(0, _letterAnimation.value);
          return Text(visibleText, style: widget.textStyle ?? Theme.of(context).textTheme.headlineMedium);
        },
      ),
    );
  }
}
