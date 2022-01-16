import 'package:flutter/material.dart';

class FadedScaleAnimation extends StatefulWidget {
  final Widget child;
  final int durationInMilliseconds;
  final Curve curve;

  const FadedScaleAnimation(this.child,
      {Key? key,
      this.durationInMilliseconds = 400,
      this.curve = Curves.decelerate})
      : super(key: key);

  @override
  _FadedScaleAnimationState createState() => _FadedScaleAnimationState();
}

class _FadedScaleAnimationState extends State<FadedScaleAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  late CurvedAnimation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(milliseconds: widget.durationInMilliseconds),
      vsync: this,
    )..addListener(() {
        setState(() {});
      });
    animation = CurvedAnimation(parent: controller!, curve: widget.curve);
    controller!.forward();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: widget.child,
      ),
    );
  }
}
