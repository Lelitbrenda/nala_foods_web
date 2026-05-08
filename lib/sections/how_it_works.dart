import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';

class HowItWorks extends StatelessWidget {
  const HowItWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: EdgeInsets.symmetric(vertical: 64),
      backgroundColor: AppColors.surfaceLight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "How It Works",
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 12),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Text(
              "Get your favorite food in just a few simple steps",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 40),
          _buildFlow(Icons.search_rounded, "Browse", "Explore", Icons.restaurant_rounded, "Select", "Choose meal", Icons.shopping_cart_rounded, "Order", "Add and pay", Icons.fastfood_rounded, "Enjoy", "Delivered"),
          SizedBox(height: 48),
          Divider(color: AppColors.border),
          SizedBox(height: 48),
          Text(
            "Become a Seller",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 32),
          _buildFlow(Icons.app_registration_rounded, "Register", "Create account", Icons.upload_file_rounded, "Upload Menu", "Add dishes", Icons.notifications_active_rounded, "Receive Orders", "Get notified", Icons.trending_up_rounded, "Grow", "Build audience"),
        ],
      ),
    );
  }

  Widget _buildFlow(IconData i1, String t1, String d1, IconData i2, String t2, String d2, IconData i3, String t3, String d3, IconData i4, String t4, String d4) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 500;
        if (isWide) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _stepCard(i1, t1, d1),
              Container(width: 40, height: 2, color: AppColors.primary.withAlpha(77)),
              _stepCard(i2, t2, d2),
              Container(width: 40, height: 2, color: AppColors.primary.withAlpha(77)),
              _stepCard(i3, t3, d3),
              Container(width: 40, height: 2, color: AppColors.primary.withAlpha(77)),
              _stepCard(i4, t4, d4),
            ],
          );
        }
        return Wrap(
          alignment: WrapAlignment.center,
          runSpacing: 24,
          spacing: 16,
          children: [_stepCard(i1, t1, d1), _stepCard(i2, t2, d2), _stepCard(i3, t3, d3), _stepCard(i4, t4, d4)],
        );
      },
    );
  }

  Widget _stepCard(IconData icon, String label, String desc) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withAlpha(77),
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Icon(icon, color: Colors.white, size: 32),
        ),
        SizedBox(height: 16),
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        SizedBox(height: 4),
        Text(desc, style: TextStyle(fontSize: 13, color: AppColors.textMuted)),
      ],
    );
  }
}