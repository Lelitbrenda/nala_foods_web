import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/buttons.dart';

class HeroSection extends StatefulWidget {
  final GlobalKey? heroKey;
  const HeroSection({super.key, this.heroKey});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  static const List<String> _mockups = [
    'assets/mockups/photo1.png',
    'assets/mockups/photo2.png',
  ];
  int _currentMockup = 0;

  Future<void> _downloadApk() async {
    final uri = Uri.parse('/apk/app-release.apk');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _switchMockup() {
    setState(() {
      _currentMockup = (_currentMockup + 1) % _mockups.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      key: widget.heroKey,
      height: screenHeight * 0.9,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.background,
            const Color(0xFF0A0A0A),
            AppColors.background,
          ],
        ),
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;
            return Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isWide ? 48 : 16,
              ),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: isWide
                      ? _buildDesktopLayout()
                      : _buildMobileLayout(screenHeight * 0.85),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(flex: 5, child: _buildTextContent()),
        const SizedBox(width: 60),
        Expanded(
          flex: 5,
          child: Row(
            children: [
              Expanded(child: _buildMockupImage(_mockups[0])),
              const SizedBox(width: 24),
              Expanded(child: _buildMockupImage(_mockups[1])),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(double availableHeight) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: availableHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTextContent(),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _switchMockup,
              child: _buildMockupImage(_mockups[_currentMockup]),
            ),
            const SizedBox(height: 12),
            Text(
              'Tap to switch view',
              style: GoogleFonts.inter(
                fontSize: 12,
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMockupImage(String path) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 520),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          path,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => Container(
            height: 400,
            color: AppColors.surface,
            child: const Center(
              child: Icon(Icons.phone_android_rounded, size: 64, color: AppColors.textMuted),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.restaurant, size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Discover & Order',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Text(
          'Discover Local\nRestaurants and\nOrder with Ease',
          style: GoogleFonts.outfit(
            fontSize: responsiveFontSize(context, 40, 72),
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: 1.05,
            letterSpacing: -1.5,
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            'Browse menus, connect with restaurants, and enjoy a smarter food ordering experience.',
            style: GoogleFonts.inter(
              fontSize: 18,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            CtaButton(
              label: 'Download for Android',
              icon: Icons.download_rounded,
              onPressed: _downloadApk,
            ),
            GhostButton(
              label: 'See Features',
              icon: Icons.explore_rounded,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
