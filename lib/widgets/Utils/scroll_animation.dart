import 'package:flutter/material.dart';

class ScrollAnimationWidget extends StatefulWidget {
  const ScrollAnimationWidget({
    Key? key,
    this.duration = const Duration(milliseconds: 1500),
    this.deltaY = 20,
    this.curve = Curves.fastOutSlowIn,
    required this.child,
  }) : super(key: key);

  final Duration duration;
  final double deltaY;
  final Widget child;
  final Curve curve;

  @override
  ScrollAnimationWidgetState createState() => ScrollAnimationWidgetState();
}

class ScrollAnimationWidgetState extends State<ScrollAnimationWidget>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (controller!.isCompleted) {
          controller!.repeat();
        }
      });
  }

  @override
  void dispose() {
    controller!.dispose();

    super.dispose();
  }

  /// convert 0-1 to 0-1-0
  double scrollAnimation(double value) =>
      2.5 * (0.5 - (0.5 - widget.curve.transform(value)).abs());

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller!,
      builder: (context, child) => Transform.translate(
        offset: Offset(0, widget.deltaY * scrollAnimation(controller!.value)),
        child: Transform.scale(
          scale: (1-controller!.value),
          child: child,
        ),
      ),
      child: widget.child,
    );
  }
}
