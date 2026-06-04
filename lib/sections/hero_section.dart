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

class _HeroSectionState extends State<HeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _floatController;
  late Animation<double> _floatAnimation;
  bool _isPhoneHovered = false;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);
    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  Future<void> _downloadApk() async {
    final uri = Uri.parse('/apk/app-release.apk');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
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
        Expanded(flex: 4, child: _buildPhoneMockup(mobile: false)),
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
            _buildPhoneMockup(mobile: true),
          ],
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

  Widget _buildPhoneMockup({bool mobile = false}) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isPhoneHovered = true),
      onExit: (_) => setState(() => _isPhoneHovered = false),
      child: AnimatedBuilder(
        animation: _floatAnimation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _floatAnimation.value),
            child: child,
          );
        },
        child: Container(
          constraints: BoxConstraints(maxWidth: mobile ? 220 : 280),
          height: mobile ? 400 : 560,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(mobile ? 28 : 40),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(
                  alpha: _isPhoneHovered ? 0.3 : 0.15,
                ),
                blurRadius: _isPhoneHovered ? 80 : 40,
                spreadRadius: _isPhoneHovered ? 20 : 10,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(mobile ? 28 : 40),
              border: Border.all(
                color: AppColors.surfaceBorder.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(mobile ? 26 : 38),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/screenshots/Screenshot_20260604-143245.png',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.surface,
                      child: const Center(
                        child: Icon(
                          Icons.phone_android_rounded,
                          size: 64,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 28,
                      decoration: const BoxDecoration(
                        color: AppColors.background,
                      ),
                      child: Center(
                        child: Container(
                          width: 100,
                          height: 6,
                          decoration: BoxDecoration(
                            color: AppColors.textMuted.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
