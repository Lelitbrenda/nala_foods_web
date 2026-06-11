import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import '../theme/app_theme.dart';

class PhoneFrame extends StatefulWidget {
  final String screenshotPath;
  final double width;
  final double height;

  const PhoneFrame({
    super.key,
    required this.screenshotPath,
    required this.width,
    required this.height,
  });

  @override
  State<PhoneFrame> createState() => _PhoneFrameState();
}

class _PhoneFrameState extends State<PhoneFrame>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late final AnimationController _hoverController;
  late final Animation<double> _hoverAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _hoverAnimation = CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    );
    _hoverController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = _hoverAnimation.value;
    final bezelWidth = widget.width;
    final bezelHeight = widget.height;
    final bezelRadius = (bezelWidth * 0.105).clamp(28.0, 44.0);
    final screenRadius = (bezelRadius - 4).clamp(24.0, 40.0);
    final dynamicIslandWidth = bezelWidth * 0.22;
    final bezelInset = bezelWidth * 0.022;

    final offsetY = -(8.0 * h);
    final scale = 1.0 + (0.04 * h);

    return MouseRegion(
      onEnter: (_) {
        if (!_isHovered) {
          _isHovered = true;
          _hoverController.forward();
        }
      },
      onExit: (_) {
        if (_isHovered) {
          _isHovered = false;
          _hoverController.reverse();
        }
      },
      child: Container(
        transform: Matrix4.identity()
          ..translateByVector3(Vector3(0.0, offsetY, 0.0))
          ..scaleByVector3(Vector3(scale, scale, 1.0)),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(bezelRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.12 + (0.10 * h),
              ),
              blurRadius: 24 + (20 * h),
              offset: Offset(0, 10 + (8 * h)),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 60,
              spreadRadius: 5,
              offset: const Offset(0, 20),
            ),
            BoxShadow(
              color: AppColors.primary.withValues(
                alpha: 0.06 + (0.08 * h),
              ),
              blurRadius: 40 + (20 * h),
              spreadRadius: 4 + (4 * h),
            ),
          ],
        ),
        width: bezelWidth,
        height: bezelHeight,
        child: Stack(
          children: [
            Positioned(
              left: bezelInset,
              top: bezelInset,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(screenRadius),
                child: SizedBox(
                  width: bezelWidth - bezelInset * 2,
                  height: bezelHeight - bezelInset * 2,
                  child: Image.asset(
                    widget.screenshotPath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.surface,
                      child: const Center(
                        child: Icon(
                          Icons.broken_image,
                          size: 48,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: bezelInset + 6,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: dynamicIslandWidth,
                  height: 22,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(11),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(bezelRadius),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withValues(alpha: 0.04),
                        Colors.transparent,
                        Colors.transparent,
                        Colors.white.withValues(alpha: 0.02),
                      ],
                      stops: const [0.0, 0.3, 0.7, 1.0],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
