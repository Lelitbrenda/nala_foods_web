import 'package:flutter/material.dart';

class ScrollAnimation extends StatefulWidget {
  final Widget child;
  final Curve curve;
  final Duration duration;
  final double offsetY;
  final bool triggerOnce;

  const ScrollAnimation({
    super.key,
    required this.child,
    this.curve = Curves.easeOutCubic,
    this.duration = const Duration(milliseconds: 600),
    this.offsetY = 40,
    this.triggerOnce = true,
  });

  @override
  State<ScrollAnimation> createState() => _ScrollAnimationState();
}

class _ScrollAnimationState extends State<ScrollAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  bool _hasTriggered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, widget.offsetY / 100),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void trigger() {
    if (!_hasTriggered || !widget.triggerOnce) {
      _hasTriggered = true;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Transform.translate(
            offset: Offset(0, _slideAnimation.value.dy * 100),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
