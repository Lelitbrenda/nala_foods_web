import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';
import '../widgets/buttons.dart';

class RestaurantSection extends StatelessWidget {
  final GlobalKey? sectionKey;
  const RestaurantSection({super.key, this.sectionKey});

  static const List<_BenefitData> _benefits = [
    _BenefitData(
      icon: Icons.trending_up_rounded,
      title: 'Increase Visibility',
      description: 'Get your restaurant in front of thousands of hungry customers looking for their next meal.',
    ),
    _BenefitData(
      icon: Icons.analytics_rounded,
      title: 'Smart Analytics',
      description: 'Access detailed insights on orders, customer preferences, and peak hours to optimize your menu.',
    ),
    _BenefitData(
      icon: Icons.speed_rounded,
      title: 'Easy Management',
      description: 'Manage orders, update menus, and communicate with customers from a single dashboard.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      color: AppColors.surface,
      child: SectionContainer(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 768;
            return isWide ? _buildDesktopLayout() : _buildMobileLayout();
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(flex: 5, child: _buildBenefitsContent()),
        const SizedBox(width: 60),
        Expanded(flex: 4, child: _buildDashboardPreview()),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        _buildBenefitsContent(),
        const SizedBox(height: 40),
        _buildDashboardPreview(),
      ],
    );
  }

  Widget _buildBenefitsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Built for\nRestaurants',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            height: 1.1,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Powerful tools to help you manage orders, reach more customers, and grow your business.',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 36),
        ..._benefits.map((benefit) => Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _BenefitRow(benefit: benefit),
        )),
        const SizedBox(height: 16),
        CtaButton(
          label: 'Become a Partner',
          icon: Icons.store_rounded,
          onPressed: () async {
            final uri = Uri.parse('/apk/app-release.apk');
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
        ),
      ],
    );
  }

  Widget _buildDashboardPreview() {
    return _DashboardPreview();
  }
}

class _BenefitData {
  final IconData icon;
  final String title;
  final String description;
  const _BenefitData({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _BenefitRow extends StatelessWidget {
  final _BenefitData benefit;
  const _BenefitRow({required this.benefit});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(benefit.icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                benefit.title,
                style: GoogleFonts.outfit(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                benefit.description,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textMuted,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DashboardPreview extends StatefulWidget {
  @override
  State<_DashboardPreview> createState() => _DashboardPreviewState();
}

class _DashboardPreviewState extends State<_DashboardPreview> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        transform: _isHovered
            ? (Matrix4.identity()..scale(1.02))
            : Matrix4.identity(),
        constraints: const BoxConstraints(maxWidth: 500),
        height: 400,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.surfaceBorder),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(
                alpha: _isHovered ? 0.15 : 0.05,
              ),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(23),
          child: Image.asset(
            'assets/screenshots/Screenshot_20260604-143638.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.surfaceLight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.dashboard_rounded, size: 64, color: AppColors.textMuted),
                  const SizedBox(height: 16),
                  Text(
                    'Restaurant Dashboard',
                    style: GoogleFonts.inter(color: AppColors.textMuted),
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
