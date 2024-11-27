import 'package:flutter/material.dart';

/// CrlMugLoader is a custom animated loader that consists of a static circle
/// and an animated filling arc water filling.
///
/// It is a stateful widget that takes in the following parameters:
///
/// - **primaryColor** : Color - the color of the static background circle.
///
/// - **secondaryColor** : Color - the color of the animated filling arc.
///
/// - **backgroundColor** : Color - the color of your background that you will put on this loader.
///
/// - **size** : double - the diameter of the loader widget (both width and height).
///
/// - **strokeWidth** : double - the width of the arc and circle stroke (thickness).
///
/// - **duration** : int - the animation duration in milliseconds.
///
/// ### Assertions:
/// - The loader's size must be greater than 0,
/// - The stroke width must be positive and less than size/3,
/// - The duration must be greater than 1000 milliseconds.
///
/// ### Example:
/// ```dart
/// CrlMugLoader(
///   size: 80,
///   primaryColor: Colors.white,
///   secondaryColor: Colors.red,
///   backgroundColor: Colors.black,
///   strokeWidth: 20,
///   duration: 1500,
/// )
/// ```

class CrlMugLoader extends StatefulWidget {
  const CrlMugLoader({
    super.key,
    this.size = 80,
    this.primaryColor = Colors.white,
    this.secondaryColor = Colors.red,
    this.backgroundColor = Colors.black,
    this.duration = 1500,
    this.strokeWidth = 6,
  }) : assert(size > 0 && (strokeWidth < size / 3 && strokeWidth > 0 && duration > 1000));

  final double size;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final double strokeWidth;
  final int duration;

  @override
  State<CrlMugLoader> createState() => _CrlMugLoaderState();
}

class _CrlMugLoaderState extends State<CrlMugLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Stack(
          children: [
            CustomPaint(
              painter: ArcMugPainter(
                strokeWidth: widget.strokeWidth,
                primaryColor: widget.primaryColor,
              ),
              size: Size(widget.size, widget.size),
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return ClipOval(
                  child: Container(
                    height: widget.size,
                    width: widget.size,
                    color: widget.secondaryColor,
                    alignment: Alignment.bottomCenter,
                    transform: Matrix4.translationValues(0, (1 - _animation.value) * widget.size, 0),
                  ),
                );
              },
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                      child: Container(
                        height: widget.size - widget.strokeWidth,
                        width: widget.size - widget.strokeWidth,
                        color: widget.backgroundColor,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ArcMugPainter extends CustomPainter {
  final double strokeWidth;
  final Color primaryColor;

  ArcMugPainter({required this.strokeWidth, required this.primaryColor});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;

    Paint arcPaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(radius, radius), radius: radius - strokeWidth / 2),
      0,
      2 * 3.15,
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
