import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';
import '../widgets/value_card.dart';

class WhyNalaSection extends StatelessWidget {
  const WhyNalaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Why Nala Foods?',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Text(
              'The all-in-one platform for food lovers and restaurant owners',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          LayoutBuilder(
            builder: (context, constraints) {
              final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
              return GridView.count(
                crossAxisCount: crossAxisCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.3,
                children: const [
                  ValueCard(
                    icon: Icons.restaurant_menu_rounded,
                    title: 'Multiple Restaurants',
                    description: 'Browse from hundreds of local restaurants in one app',
                    iconColor: AppColors.primary,
                  ),
                  ValueCard(
                    icon: Icons.shopping_cart_rounded,
                    title: 'Easy Ordering',
                    description: 'Order your favorite meals with just a few taps',
                    iconColor: AppColors.accent,
                  ),
                  ValueCard(
                    icon: Icons.search_rounded,
                    title: 'Fast Discovery',
                    description: 'Find exactly what you crave with smart search & categories',
                    iconColor: AppColors.success,
                  ),
                  ValueCard(
                    icon: Icons.trending_up_rounded,
                    title: 'Seller Growth',
                    description: 'Grow your restaurant business with powerful tools',
                    iconColor: AppColors.warning,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}