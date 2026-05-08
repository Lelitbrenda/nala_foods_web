import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../sections/hero_section.dart';
import '../sections/why_nala_section.dart';
import '../sections/customer_experience.dart';
import '../sections/seller_experience.dart';
import '../sections/how_it_works.dart';
import '../sections/app_gallery.dart';
import '../sections/cta_section.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            HeroSection(),
            WhyNalaSection(),
            CustomerExperience(),
            SellerExperience(),
            HowItWorks(),
            AppGallery(),
            CtaSection(),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Image.asset(
            "assets/Images/logo1.png",
            height: 36,
            errorBuilder: (context, error, stack) {
              return Text(
                "Nala Foods",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
              );
            },
          ),
          Spacer(),
          PrimaryButton(
            label: "Download",
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: EdgeInsets.all(24),
      color: AppColors.textPrimary,
      child: Center(
        child: Text(
          "2026 Nala Foods. All rights reserved.",
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  const PrimaryButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18),
            SizedBox(width: 8),
          ],
          Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}