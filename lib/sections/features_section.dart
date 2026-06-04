import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';

class FeaturesSection extends StatelessWidget {
  final GlobalKey? sectionKey;
  const FeaturesSection({super.key, this.sectionKey});

  static const List<_FeatureData> _features = [
    _FeatureData(
      icon: Icons.explore_rounded,
      title: 'Discover Restaurants',
      description: 'Explore a wide variety of local restaurants and cuisines near you.',
    ),
    _FeatureData(
      icon: Icons.menu_book_rounded,
      title: 'Browse Menus',
      description: 'View detailed menus, prices, and descriptions before you order.',
    ),
    _FeatureData(
      icon: Icons.update_rounded,
      title: 'Real-Time Updates',
      description: 'Track your order status from preparation to delivery in real time.',
    ),
    _FeatureData(
      icon: Icons.chat_rounded,
      title: 'Direct Communication',
      description: 'Chat directly with restaurants for special requests and questions.',
    ),
    _FeatureData(
      icon: Icons.lock_rounded,
      title: 'Secure Ordering',
      description: 'Pay securely through the app with multiple payment options.',
    ),
    _FeatureData(
      icon: Icons.store_rounded,
      title: 'Restaurant Support',
      description: 'Tools and analytics to help restaurants grow their business.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      color: AppColors.lightBackground,
      child: SectionContainer(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
        child: Column(
          children: [
            SectionTitle(
              title: 'Everything You Need',
              subtitle: 'Designed to make food discovery and ordering effortless.',
              light: true,
            ),
            const SizedBox(height: 56),
            LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 1024
                    ? 4
                    : constraints.maxWidth > 600
                        ? 2
                        : 1;
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: crossAxisCount == 1 ? 2.5 : 1.0,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _features.length,
                  itemBuilder: (context, index) => _FeatureCard(
                    feature: _features[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureData {
  final IconData icon;
  final String title;
  final String description;
  const _FeatureData({
    required this.icon,
    required this.title,
    required this.description,
  });
}

class _FeatureCard extends StatefulWidget {
  final _FeatureData feature;
  const _FeatureCard({required this.feature});

  @override
  State<_FeatureCard> createState() => _FeatureCardState();
}

class _FeatureCardState extends State<_FeatureCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: _isHovered
            ? (Matrix4.identity()..translate(0.0, -8.0))
            : Matrix4.identity(),
        padding: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: AppColors.lightSurface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isHovered
                ? AppColors.primary.withValues(alpha: 0.3)
                : AppColors.lightBorder,
          ),
          boxShadow: [
            BoxShadow(
              color: _isHovered
                  ? AppColors.primary.withValues(alpha: 0.08)
                  : Colors.black.withValues(alpha: 0.04),
              blurRadius: _isHovered ? 30 : 10,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: _isHovered
                    ? AppColors.primary.withValues(alpha: 0.12)
                    : AppColors.lightSurfaceLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                widget.feature.icon,
                color: _isHovered ? AppColors.primary : AppColors.lightTextMuted,
                size: 28,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.feature.title,
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: _isHovered ? AppColors.primary : AppColors.lightTextPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.feature.description,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: AppColors.lightTextMuted,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
