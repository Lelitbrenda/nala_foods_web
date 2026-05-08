import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';

class SellerExperience extends StatelessWidget {
  const SellerExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Seller Experience',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Text(
              'Powerful tools to manage and grow your restaurant',
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
                          flex: 3,
                          child: _buildFeaturesList(),
                        ),
                        const SizedBox(width: 40),
                        Expanded(
                          flex: 2,
                          child: _buildDashboard(),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        _buildDashboard(),
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

  Widget _buildDashboard() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.12),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/Images/image3.png',
          fit: BoxFit.cover,
          height: 320,
          errorBuilder: (context, error, stack) {
            return Container(
              height: 320,
              color: AppColors.grey100,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.dashboard_rounded, size: 56, color: AppColors.grey600),
                    SizedBox(height: 12),
                    Text('Seller Dashboard', style: TextStyle(color: AppColors.textMuted)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      {'icon': Icons.menu_book_rounded, 'title': 'Manage Menu', 'desc': 'Add, edit, and organize your dishes easily'},
      {'icon': Icons.inventory_2_rounded, 'title': 'Update Products', 'desc': 'Keep your menu items in stock and up to date'},
      {'icon': Icons.notifications_rounded, 'title': 'Receive Live Orders', 'desc': 'Get instant notifications for new orders'},
      {'icon': Icons.analytics_rounded, 'title': 'Track Growth', 'desc': 'View sales analytics and grow your business'},
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
              color: AppColors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.accent, size: 24),
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