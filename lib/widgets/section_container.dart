import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class SectionContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const SectionContainer({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.symmetric(vertical: isMobile ? 48 : 80, horizontal: 24),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: isMobile ? 480 : 1400),
          child: child,
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool light;

  const SectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.light = false,
  });

  @override
  Widget build(BuildContext context) {
    final fontSize = responsiveFontSize(context, 22, 48);
    final titleColor = light ? AppColors.lightTextPrimary : AppColors.textPrimary;
    final subtitleColor = light ? AppColors.lightTextSecondary : AppColors.textSecondary;
    return Column(
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: titleColor,
            height: 1.1,
          ),
          textAlign: TextAlign.center,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(
            subtitle!,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: subtitleColor,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

class GradientDivider extends StatelessWidget {
  const GradientDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.primary.withValues(alpha: 0.3),
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
