import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';

class HowItWorks extends StatelessWidget {
  final GlobalKey? sectionKey;
  const HowItWorks({super.key, this.sectionKey});

  static const List<_StepData> _steps = [
    _StepData(
      step: '01',
      icon: Icons.explore_rounded,
      title: 'Browse',
      description: 'Explore local restaurants and their menus to find what you crave.',
    ),
    _StepData(
      step: '02',
      icon: Icons.shopping_cart_rounded,
      title: 'Select',
      description: 'Choose your favorite dishes and customize your order.',
    ),
    _StepData(
      step: '03',
      icon: Icons.receipt_long_rounded,
      title: 'Order',
      description: 'Place your order securely and track it in real time.',
    ),
    _StepData(
      step: '04',
      icon: Icons.local_shipping_rounded,
      title: 'Enjoy',
      description: 'Get your food delivered hot and fresh right to your door.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      color: AppColors.surface,
      child: SectionContainer(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
        child: Column(
          children: [
            const SectionTitle(
              title: 'How It Works',
              subtitle: 'Getting your favorite food is just four simple steps.',
            ),
            const SizedBox(height: 56),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 768;
                return isWide ? _buildDesktopFlow() : _buildMobileFlow();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopFlow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StepCard(step: _steps[0]),
        _Connector(isVertical: false),
        _StepCard(step: _steps[1]),
        _Connector(isVertical: false),
        _StepCard(step: _steps[2]),
        _Connector(isVertical: false),
        _StepCard(step: _steps[3]),
      ],
    );
  }

  Widget _buildMobileFlow() {
    return Column(
      children: [
        _StepCard(step: _steps[0]),
        _Connector(isVertical: true),
        _StepCard(step: _steps[1]),
        _Connector(isVertical: true),
        _StepCard(step: _steps[2]),
        _Connector(isVertical: true),
        _StepCard(step: _steps[3]),
      ],
    );
  }
}

class _StepData {
  final String step;
  final IconData icon;
  final String title;
  final String description;
  const _StepData({
    required this.step,
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _StepCard extends StatelessWidget {
  final _StepData step;
  const _StepCard({required this.step});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 240),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.2),
                  AppColors.primary.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(step.icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            step.step,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            step.title,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            step.description,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textMuted,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _Connector extends StatelessWidget {
  final bool isVertical;
  const _Connector({required this.isVertical});

  @override
  Widget build(BuildContext context) {
    if (isVertical) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Container(
              width: 2,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withValues(alpha: 0.3),
                    AppColors.primary,
                  ],
                ),
              ),
            ),
            Icon(Icons.arrow_downward_rounded, color: AppColors.primary, size: 18),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.primary.withValues(alpha: 0.3),
                  AppColors.primary,
                  AppColors.primary.withValues(alpha: 0.3),
                ],
              ),
            ),
          ),
          const SizedBox(height: 4),
          Icon(Icons.arrow_forward_rounded, color: AppColors.primary, size: 18),
        ],
      ),
    );
  }
}
