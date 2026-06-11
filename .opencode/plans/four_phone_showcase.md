# Four-Phone Showcase Redesign

## File to replace
`lib/sections/screenshots_section.dart`

## Replace entire contents with:

```dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';

class ScreenshotsSection extends StatefulWidget {
  final GlobalKey? sectionKey;
  const ScreenshotsSection({super.key, this.sectionKey});

  @override
  State<ScreenshotsSection> createState() => _ScreenshotsSectionState();
}

class _ScreenshotsSectionState extends State<ScreenshotsSection>
    with TickerProviderStateMixin {
  static const List<_ScreenshotInfo> _screenshotsInfo = [
    _ScreenshotInfo(
      image: 'assets/screenshots/scrn1.png',
      title: 'Discover Restaurants',
    ),
    _ScreenshotInfo(
      image: 'assets/screenshots/scrn2.png',
      title: 'Browse Menus',
    ),
    _ScreenshotInfo(
      image: 'assets/screenshots/scrn3.png',
      title: 'Track Orders',
    ),
    _ScreenshotInfo(
      image: 'assets/screenshots/scrn4.png',
      title: 'Leave Reviews',
    ),
  ];

  late final AnimationController _entranceController;
  double _entranceValue = 0.0;
  bool _hasEntered = false;
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _entranceController.addListener(_onEntranceTick);
  }

  void _onEntranceTick() {
    if (mounted) {
      _entranceValue = _entranceController.value;
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollPosition?.removeListener(_onScroll);
    final scrollable = Scrollable.maybeOf(context);
    if (scrollable != null) {
      _scrollPosition = scrollable.position;
      _scrollPosition!.addListener(_onScroll);
      _checkVisibility();
    }
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_onScroll);
    _entranceController.removeListener(_onEntranceTick);
    _entranceController.dispose();
    super.dispose();
  }

  void _onScroll() {
    _checkVisibility();
  }

  void _checkVisibility() {
    if (_hasEntered) return;
    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    final position = renderBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;
    if (position.dy < screenHeight - 80) {
      _hasEntered = true;
      _entranceController.forward();
      _scrollPosition?.removeListener(_onScroll);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.sectionKey,
      color: AppColors.lightBackground,
      child: SectionContainer(
        padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 24),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 60),
            _buildShowcaseGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Opacity(
      opacity: _entranceValue,
      child: Transform.translate(
        offset: Offset(0, 40 * (1.0 - _entranceValue)),
        child: Column(
          children: [
            Text(
              'See Nala Foods in Action',
              style: GoogleFonts.outfit(
                fontSize: responsiveFontSize(context, 24, 48),
                fontWeight: FontWeight.bold,
                color: AppColors.lightTextPrimary,
                height: 1.1,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Text(
                'Discover restaurants, order food, track deliveries, and leave reviews.',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.lightTextSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShowcaseGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 900;
        final phoneWidth = isMobile ? 240.0 : 220.0;
        final phoneHeight = phoneWidth * 2.1;

        final glow = SizedBox(
          width: isMobile ? phoneWidth + 80 : constraints.maxWidth * 0.9,
          height: phoneHeight + 80,
          child: _buildBackgroundGlow(constraints.maxWidth),
        );

        if (isMobile) {
          return SizedBox(
            height: phoneHeight + 100,
            child: Stack(
              alignment: Alignment.center,
              children: [
                glow,
                ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _screenshotsInfo.length,
                  itemExtent: phoneWidth + 40,
                  itemBuilder: (_, index) {
                    return _buildPhoneCard(
                      index: index,
                      phoneWidth: phoneWidth,
                      phoneHeight: phoneHeight,
                    );
                  },
                ),
              ],
            ),
          );
        }

        return SizedBox(
          height: phoneHeight + 100,
          child: Stack(
            alignment: Alignment.center,
            children: [
              glow,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_screenshotsInfo.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 0 : 48,
                    ),
                    child: _buildPhoneCard(
                      index: index,
                      phoneWidth: phoneWidth,
                      phoneHeight: phoneHeight,
                    ),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPhoneCard({
    required int index,
    required double phoneWidth,
    required double phoneHeight,
  }) {
    final staggerFactor = index * 0.14;
    final progress = ((_entranceValue - staggerFactor) / (1.0 - staggerFactor))
        .clamp(0.0, 1.0);

    return Opacity(
      opacity: progress,
      child: Transform.translate(
        offset: Offset(0, 30 * (1.0 - progress)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PhoneFrame(
              screenshotPath: _screenshotsInfo[index].image,
              width: phoneWidth,
              height: phoneHeight,
            ),
            const SizedBox(height: 16),
            Text(
              _screenshotsInfo[index].title,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.lightTextPrimary,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundGlow(double areaWidth) {
    return IgnorePointer(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: areaWidth * 0.7,
              height: areaWidth * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.08),
                    AppColors.primary.withValues(alpha: 0.03),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
            Positioned(
              right: areaWidth * 0.05,
              top: -20,
              child: Container(
                width: areaWidth * 0.35,
                height: areaWidth * 0.35,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.06),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
              ),
            ),
            Positioned(
              left: areaWidth * 0.05,
              bottom: 10,
              child: Container(
                width: areaWidth * 0.3,
                height: areaWidth * 0.3,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.04),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 1.0],
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

class _ScreenshotInfo {
  final String image;
  final String title;

  const _ScreenshotInfo({
    required this.image,
    required this.title,
  });
}

class _PhoneFrame extends StatefulWidget {
  final String screenshotPath;
  final double width;
  final double height;

  const _PhoneFrame({
    required this.screenshotPath,
    required this.width,
    required this.height,
  });

  @override
  State<_PhoneFrame> createState() => _PhoneFrameState();
}

class _PhoneFrameState extends State<_PhoneFrame> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final bezelWidth = widget.width;
    final bezelHeight = widget.height;
    final bezelRadius = (bezelWidth * 0.105).clamp(28.0, 44.0);
    final screenRadius = (bezelRadius - 4).clamp(24.0, 40.0);
    final dynamicIslandWidth = bezelWidth * 0.22;
    final bezelInset = bezelWidth * 0.022;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -8.0 : 0.0, 0.0)
          ..scale(_isHovered ? 1.04 : 1.0),
        transformAlignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(bezelRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: _isHovered ? 0.22 : 0.12,
              ),
              blurRadius: _isHovered ? 44 : 24,
              offset: Offset(0, _isHovered ? 18 : 10),
            ),
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 60,
              spreadRadius: 5,
              offset: const Offset(0, 20),
            ),
            BoxShadow(
              color: AppColors.primary.withValues(
                alpha: _isHovered ? 0.14 : 0.06,
              ),
              blurRadius: _isHovered ? 60 : 40,
              spreadRadius: _isHovered ? 8 : 4,
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
```

## Key changes from previous version

| Aspect | Before (carousel) | After (four-phone row) |
|---|---|---|
| **Layout** | Single phone + arrows + dots | 4 phones in a horizontal row (desktop) / scrollable (mobile) |
| **Heading** | "Experience Nala Foods in Action" | "See Nala Foods in Action" |
| **Subtitle** | Long paragraph | Short: "Discover restaurants, order food, track deliveries, and leave reviews." |
| **Feature info** | Active feature text below phone | Static labels below each phone (no description) |
| **Navigation** | `PageController`, arrows, dots, `_currentIndex` | None — all 4 visible at once |
| **Floating** | ±6px Y oscillation on single phone | Removed |
| **Entrance stagger** | Uniform entrance for all elements | Each phone enters with `index * 0.14` stagger delay |
| **Glow** | Centered behind single phone | Wide glow spanning the full row width |
| **`_PhoneFrame` hover** | `Transform.scale` (jumpy) | `AnimatedContainer.transform` with translate(-8px) + scale(1.04) — smooth |

## `_PhoneFrame` widget — untouched core design

The phone mockup (dark bezel, dynamic island, glass reflection, screen clip, shadows) remains **identical**.
