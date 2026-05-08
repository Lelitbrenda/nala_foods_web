import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final bool useMaxWidth;

  const SectionContainer({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.useMaxWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      child: useMaxWidth
          ? Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
                  child: child,
                ),
              ),
            )
          : Padding(
              padding: padding ?? const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
              child: child,
            ),
    );
  }
}

class AnimatedSection extends StatefulWidget {
  final Widget child;
  final double fadeOffset;

  const AnimatedSection({
    super.key,
    required this.child,
    this.fadeOffset = 30,
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slideAnimation = Tween<Offset>(begin: Offset(0, 0.1), end: Offset.zero).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: widget.child,
      ),
    );
  }
}