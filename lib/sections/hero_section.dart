import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';
import '../widgets/buttons.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: const EdgeInsets.symmetric(vertical: 64),
      backgroundColor: AppColors.background,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          return isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _buildTextContent(),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: _buildPhoneMockup(),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildTextContent(),
                    const SizedBox(height: 40),
                    _buildPhoneMockup(),
                  ],
                );
        },
      ),
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primarySoft,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                '🍽️ Now Available',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryDark,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Text(
            'Order From Your Favorite Restaurants in One Place',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontSize: 32,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Text(
            'Discover meals, snacks, and drinks from multiple local restaurants with a seamless ordering experience.',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            PrimaryButton(
              label: 'Download App',
              icon: Icons.download_rounded,
              onPressed: () {},
            ),
            SecondaryButton(
              label: 'Join as a Seller',
              icon: Icons.store_rounded,
              isOutlined: true,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhoneMockup() {
    return AnimatedBuilder(
      animation: _floatAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _floatAnimation.value),
          child: child,
        );
      },
      child: Container(
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.2),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: AspectRatio(
            aspectRatio: 0.65,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/Images/promo1.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) {
                      return Container(
                        color: AppColors.surfaceLight,
                        child: const Center(
                          child: Icon(
                            Icons.restaurant_menu,
                            size: 64,
                            color: AppColors.primary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.6),
                        ],
                      ),
                    ),
                    child: const SafeArea(
                      top: false,
                      child: Text(
                        'Nala Foods',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
    );
  }
}