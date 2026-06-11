import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';
import '../widgets/phone_frame.dart';

class ScreenshotsSection extends StatelessWidget {
  final GlobalKey? sectionKey;
  const ScreenshotsSection({super.key, this.sectionKey});

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

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      color: AppColors.lightBackground,
      child: SectionContainer(
        padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 24),
        child: Column(
          children: [
            _buildHeader(context),
            const SizedBox(height: 60),
            _buildShowcaseGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
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
    );
  }

  Widget _buildShowcaseGrid(BuildContext context) {
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PhoneFrame(
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
