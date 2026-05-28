import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HowItWorks extends StatelessWidget {
  const HowItWorks({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: AppColors.accent,
      child: Column(
        children: [
          const Text(
            'How It Works',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Get your favorite food in three simple steps',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 48),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 700;
              return isWide ? _buildDesktopFlow() : _buildMobileFlow();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopFlow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StepCard(
          step: '01',
          icon: Icons.search_rounded,
          title: 'Choose Restaurant',
          description: 'Browse restaurants and pick your favorite cuisine',
        ),
        _buildConnector(),
        _StepCard(
          step: '02',
          icon: Icons.shopping_cart_rounded,
          title: 'Place Order',
          description: 'Select your meals and customize your order',
        ),
        _buildConnector(),
        _StepCard(
          step: '03',
          icon: Icons.local_shipping_rounded,
          title: 'Fast Delivery',
          description: 'Get your food delivered hot and fresh to your door',
        ),
      ],
    );
  }

  Widget _buildMobileFlow() {
    return Column(
      children: [
        _StepCard(
          step: '01',
          icon: Icons.search_rounded,
          title: 'Choose Restaurant',
          description: 'Browse restaurants and pick your favorite cuisine',
        ),
        _buildVerticalConnector(),
        _StepCard(
          step: '02',
          icon: Icons.shopping_cart_rounded,
          title: 'Place Order',
          description: 'Select your meals and customize your order',
        ),
        _buildVerticalConnector(),
        _StepCard(
          step: '03',
          icon: Icons.local_shipping_rounded,
          title: 'Fast Delivery',
          description: 'Get your food delivered hot and fresh to your door',
        ),
      ],
    );
  }

  Widget _buildConnector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
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
          Icon(Icons.arrow_forward_rounded, color: AppColors.primary, size: 20),
        ],
      ),
    );
  }

  Widget _buildVerticalConnector() {
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
          Icon(Icons.arrow_downward_rounded, color: AppColors.primary, size: 20),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final String step;
  final IconData icon;
  final String title;
  final String description;

  const _StepCard({
    required this.step,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 260),
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: AppColors.primary, size: 28),
          ),
          const SizedBox(height: 16),
          Text(
            step,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.7),
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
