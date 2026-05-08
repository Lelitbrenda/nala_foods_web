import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';

class CustomerExperience extends StatelessWidget {
  const CustomerExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: const EdgeInsets.symmetric(vertical: 64),
      backgroundColor: AppColors.surfaceLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Customer Experience',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Text(
              'Everything you need to find and enjoy your favorite food',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              return isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildAppScreenshot(),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          flex: 3,
                          child: _buildFeaturesList(),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _buildAppScreenshot(),
                        const SizedBox(height: 24),
                        _buildFeaturesList(),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAppScreenshot() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 260),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.15),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: AspectRatio(
          aspectRatio: 0.7,
          child: Image.asset(
            'assets/Images/image1.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stack) {
              return Container(
                color: AppColors.grey100,
                child: const Center(
                  child: Icon(
                    Icons.phone_android,
                    size: 64,
                    color: AppColors.grey600,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      {'icon': Icons.category_rounded, 'title': 'Browse Categories', 'desc': 'Explore restaurants by cuisine, price, and ratings'},
      {'icon': Icons.compare_rounded, 'title': 'Compare Restaurants', 'desc': 'View menus, prices, and reviews all in one place'},
      {'icon': Icons.add_shopping_cart_rounded, 'title': 'Add to Cart', 'desc': 'Build your perfect meal with easy customization'},
      {'icon': Icons.credit_card_rounded, 'title': 'Checkout Smoothly', 'desc': 'Pay securely with multiple payment options'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: features.map((f) => _buildFeatureItem(
        f['icon'] as IconData,
        f['title'] as String,
        f['desc'] as String,
      )).toList(),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primary, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text(desc, style: const TextStyle(fontSize: 14, color: AppColors.textMuted)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}