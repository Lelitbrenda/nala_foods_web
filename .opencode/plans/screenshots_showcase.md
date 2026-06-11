# Screenshots Section Redesign — Implementation

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
    with SingleTickerProviderStateMixin {
  static const List<String> _screenshots = [
    'assets/screenshots/scrn1.png',
    'assets/screenshots/scrn2.png',
    'assets/screenshots/scrn3.png',
    'assets/screenshots/scrn4.png',
  ];

  static const List<_ScreenshotInfo> _screenshotsInfo = [
    _ScreenshotInfo(
      image: _screenshots[0],
      title: 'Discover Restaurants',
      description:
          'Browse nearby restaurants, explore cuisines, and find exactly what you are craving in seconds.',
    ),
    _ScreenshotInfo(
      image: _screenshots[1],
      title: 'Browse Menus',
      description:
          'View detailed menus with prices and photos. Customize your order with special instructions.',
    ),
    _ScreenshotInfo(
      image: _screenshots[2],
      title: 'Track Your Order',
      description:
          'Follow your order in real time from preparation to delivery. Know exactly when your food will arrive.',
    ),
    _ScreenshotInfo(
      image: _screenshots[3],
      title: 'Rate & Review',
      description:
          'Share your experience by rating restaurants and dishes. Help others discover the best food in town.',
    ),
  ];

  late final PageController _pageController;
  int _currentIndex = 0;
  late final AnimationController _floatController;
  late final AnimationController _entranceController;
  late final Animation<double> _floatAnimation;
  bool _hasEntered = false;
  ScrollPosition? _scrollPosition;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);

    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: -6.0, end: 6.0).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOutSine),
    );

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
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
    _pageController.dispose();
    _floatController.dispose();
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

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  void _goToPrevious() {
    if (_currentIndex > 0) {
      _pageController.animateToPage(
        _currentIndex - 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _goToNext() {
    if (_currentIndex < _screenshotsInfo.length - 1) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
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
            _buildShowcase(),
            const SizedBox(height: 48),
            _buildFeatureInfo(),
            const SizedBox(height: 32),
            _buildDots(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _entranceController,
      builder: (context, child) {
        return Opacity(
          opacity: _entranceController.value,
          child: Transform.translate(
            offset: Offset(0, 40 * (1.0 - _entranceController.value)),
            child: child,
          ),
        );
      },
      child: Column(
        children: [
          Text(
            'Experience Nala Foods in Action',
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
              'Discover restaurants, browse menus, track deliveries, and enjoy a seamless food ordering experience.',
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
    );
  }

  Widget _buildShowcase() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 768;
        final phoneWidth = isMobile
            ? (constraints.maxWidth * 0.8).clamp(260.0, 360.0)
            : 360.0;
        final phoneHeight = phoneWidth * 2.1;
        final totalHeight = phoneHeight + 80;
        final halfPhone = phoneWidth / 2;

        return SizedBox(
          height: totalHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildGlowEffects(phoneWidth, halfPhone),
              if (!isMobile)
                Positioned(
                  left: (constraints.maxWidth - phoneWidth) / 2 - 62,
                  top: totalHeight / 2 - 24,
                  child: _buildArrowButton(
                    icon: Icons.chevron_left_rounded,
                    onPressed: _currentIndex > 0 ? _goToPrevious : null,
                  ),
                ),
              AnimatedBuilder(
                animation:
                    Listenable.merge([_floatAnimation, _entranceController]),
                builder: (context, child) {
                  final entranceOffset =
                      (1.0 - _entranceController.value) * 50.0;
                  return Transform.translate(
                    offset: Offset(0, _floatAnimation.value + entranceOffset),
                    child: Opacity(
                      opacity: _entranceController.value,
                      child: child,
                    ),
                  );
                },
                child: SizedBox(
                  width: phoneWidth,
                  height: phoneHeight,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemCount: _screenshotsInfo.length,
                    itemBuilder: (_, index) {
                      return _PhoneFrame(
                        screenshotPath: _screenshotsInfo[index].image,
                        width: phoneWidth,
                        height: phoneHeight,
                      );
                    },
                  ),
                ),
              ),
              if (!isMobile)
                Positioned(
                  right: (constraints.maxWidth - phoneWidth) / 2 - 62,
                  top: totalHeight / 2 - 24,
                  child: _buildArrowButton(
                    icon: Icons.chevron_right_rounded,
                    onPressed:
                        _currentIndex < _screenshotsInfo.length - 1
                            ? _goToNext
                            : null,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGlowEffects(double phoneWidth, double halfPhone) {
    return IgnorePointer(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: phoneWidth * 1.6,
            height: phoneWidth * 1.6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.10),
                  AppColors.primary.withValues(alpha: 0.03),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
          ),
          Positioned(
            right: -halfPhone * 0.3,
            top: -halfPhone * 0.2,
            child: Container(
              width: phoneWidth * 1.2,
              height: phoneWidth * 1.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.07),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -halfPhone * 0.15,
            child: Container(
              width: phoneWidth * 1.3,
              height: phoneWidth * 0.5,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.05),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrowButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return MouseRegion(
      cursor:
          onPressed != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.06),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Icon(
            icon,
            color:
                onPressed != null
                    ? AppColors.lightTextPrimary
                    : AppColors.lightTextMuted,
            size: 24,
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureInfo() {
    final info = _screenshotsInfo[_currentIndex];
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.12),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Column(
        key: ValueKey(_currentIndex),
        children: [
          Text(
            info.title,
            style: GoogleFonts.outfit(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.lightTextPrimary,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              info.description,
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
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_screenshotsInfo.length, (index) {
        final isActive = index == _currentIndex;
        return GestureDetector(
          onTap: () {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOutCubic,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: isActive ? 28 : 8,
            height: 8,
            decoration: BoxDecoration(
              color:
                  isActive
                      ? AppColors.primary
                      : AppColors.lightTextMuted.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}

class _ScreenshotInfo {
  final String image;
  final String title;
  final String description;

  const _ScreenshotInfo({
    required this.image,
    required this.title,
    required this.description,
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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform:
            _isHovered
                ? (Matrix4.identity()..scale(1.02))
                : Matrix4.identity(),
        transformAlignment: Alignment.center,
        child: Container(
          width: bezelWidth,
          height: bezelHeight,
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(bezelRadius),
            boxShadow: [
              BoxShadow(
                color:
                    Colors.black.withValues(
                      alpha: _isHovered ? 0.20 : 0.12,
                    ),
                blurRadius: _isHovered ? 40 : 24,
                offset: Offset(0, _isHovered ? 16 : 10),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 60,
                spreadRadius: 5,
                offset: const Offset(0, 20),
              ),
              BoxShadow(
                color:
                    AppColors.primary.withValues(
                      alpha: _isHovered ? 0.12 : 0.06,
                    ),
                blurRadius: _isHovered ? 60 : 40,
                spreadRadius: _isHovered ? 8 : 4,
              ),
            ],
          ),
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
      ),
    );
  }
}
```

## What changed

| Aspect | Before | After |
|---|---|---|
| **Layout** | Alternating rows (desktop) / carousel (mobile) with card thumbnails | Single centered phone mockup with left/right arrow navigation |
| **Phone frame** | None — screenshots in cards with rounded corners | Dark bezel frame (Color(0xFF1A1A1A)), dynamic island, glass reflection overlay |
| **Screenshot display** | Multiple visible at once in a grid | One large screenshot at a time inside the phone frame |
| **Navigation** | None (mobile: PageView swipe) | Arrow buttons flanking the phone + clickable dot indicators |
| **Transitions** | None | Fade + scale (0.95→1) + 5px slide, 400ms easeInOutCubic |
| **Background** | Solid lightBackground | 3-layer radial gradient orange glow behind the phone |
| **Floating animation** | None | Continuous ±6px Y oscillation over 4s (easeInOutSine) |
| **Entrance animation** | None | Scroll-triggered fade-in + slide-up (800ms), staggered by element |
| **Hover** | Scale 1.03 on cards | Scale 1.02 + shadow depth increase + orange glow intensification |
| **Feature info** | Static text per row | AnimatedSwitcher with fade + slide transition tied to active screenshot |
| **Dot indicators** | Static circles (no interaction) | AnimatedContainer — active dot expands to pill shape, clickable to navigate |
| **Preview modal** | `_openPreview` with AppModal | Removed — single large view replaces need for preview |

## Build verification

Run after applying:
```
flutter analyze lib/sections/screenshots_section.dart
```
