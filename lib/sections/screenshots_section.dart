import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';
import '../widgets/modal.dart';

class ScreenshotsSection extends StatefulWidget {
  final GlobalKey? sectionKey;
  const ScreenshotsSection({super.key, this.sectionKey});

  @override
  State<ScreenshotsSection> createState() => _ScreenshotsSectionState();
}

class _ScreenshotsSectionState extends State<ScreenshotsSection> {
  static const List<String> _screenshots = [
    'assets/screenshots/Screenshot_20260604-143245.png',
    'assets/screenshots/Screenshot_20260604-143327.png',
    'assets/screenshots/Screenshot_20260604-143352.png',
    'assets/screenshots/Screenshot_20260604-143638.png',
  ];

  static List<_ScreenshotInfo> get _screenshotsInfo => [
    _ScreenshotInfo(
      image: _screenshots[0],
      title: 'Discover Restaurants',
      description: 'Browse through a curated list of local restaurants. Filter by cuisine, rating, or distance to find exactly what you are craving.',
    ),
    _ScreenshotInfo(
      image: _screenshots[1],
      title: 'Browse Menus',
      description: 'View detailed menus with prices, descriptions, and photos. Customize your order with special instructions.',
    ),
    _ScreenshotInfo(
      image: _screenshots[2],
      title: 'Track Your Order',
      description: 'Follow your order in real time from preparation to delivery. Know exactly when your food will arrive.',
    ),
    _ScreenshotInfo(
      image: _screenshots[3],
      title: 'Rate & Review',
      description: 'Share your experience by rating restaurants and dishes. Help others discover the best food in town.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      key: widget.sectionKey,
      color: AppColors.lightBackground,
      child: SectionContainer(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
        child: Column(
          children: [
            const SectionTitle(
              title: 'See the App in Action',
              subtitle: 'A clean, intuitive interface designed for speed and simplicity.',
              light: true,
            ),
            const SizedBox(height: 56),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 768;
                return isWide
                    ? _buildAlternatingLayout()
                    : _buildCarouselLayout();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlternatingLayout() {
    return Column(
      children: List.generate(_screenshotsInfo.length, (index) {
        final info = _screenshotsInfo[index];
        final isReversed = index.isOdd;
        return Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: _ScreenshotRow(
            info: info,
            isReversed: isReversed,
            onTap: () => _openPreview(info.image),
          ),
        );
      }),
    );
  }

  Widget _buildCarouselLayout() {
    final screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        SizedBox(
          height: (screenHeight * 0.6).clamp(400.0, 500.0),
          child: PageView.builder(
            itemCount: _screenshotsInfo.length,
            itemBuilder: (context, index) {
              final info = _screenshotsInfo[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: _ScreenshotCard(
                  info: info,
                  onTap: () => _openPreview(info.image),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_screenshotsInfo.length, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ],
    );
  }

  void _openPreview(String imagePath) {
    AppModal.show(
      context: context,
      title: 'Preview',
      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Container(
              height: 400,
              color: AppColors.surface,
              child: const Icon(Icons.broken_image, size: 64, color: AppColors.textMuted),
            ),
          ),
        ),
      ),
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

class _ScreenshotRow extends StatefulWidget {
  final _ScreenshotInfo info;
  final bool isReversed;
  final VoidCallback onTap;

  const _ScreenshotRow({
    required this.info,
    required this.isReversed,
    required this.onTap,
  });

  @override
  State<_ScreenshotRow> createState() => _ScreenshotRowState();
}

class _ScreenshotRowState extends State<_ScreenshotRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final content = [
      Expanded(
        child: _ScreenshotCard(
          info: widget.info,
          isHovered: _isHovered,
          onTap: widget.onTap,
        ),
      ),
      const SizedBox(width: 48),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.info.title,
              style: GoogleFonts.outfit(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.lightTextPrimary,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.info.description,
              style: GoogleFonts.inter(
                fontSize: 16,
                color: AppColors.lightTextSecondary,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    ];

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Row(
        children: widget.isReversed ? content.reversed.toList() : content,
      ),
    );
  }
}

class _ScreenshotCard extends StatefulWidget {
  final _ScreenshotInfo info;
  final bool isHovered;
  final VoidCallback onTap;

  const _ScreenshotCard({
    required this.info,
    this.isHovered = false,
    required this.onTap,
  });

  @override
  State<_ScreenshotCard> createState() => _ScreenshotCardState();
}

class _ScreenshotCardState extends State<_ScreenshotCard> {
  bool _localHovered = false;

  bool get _effectiveHovered => widget.isHovered || _localHovered;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _localHovered = true),
      onExit: (_) => setState(() => _localHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: _effectiveHovered
              ? (Matrix4.identity()..scale(1.03))
              : Matrix4.identity(),
          constraints: const BoxConstraints(maxWidth: 280),
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: AppColors.lightSurface,
            border: Border.all(
              color: AppColors.lightBorder.withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: _effectiveHovered
                    ? AppColors.primary.withValues(alpha: 0.12)
                    : Colors.black.withValues(alpha: 0.06),
                blurRadius: _effectiveHovered ? 40 : 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              widget.info.image,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.grey100,
                child: const Center(
                  child: Icon(Icons.phone_android_rounded, size: 64, color: AppColors.grey),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
