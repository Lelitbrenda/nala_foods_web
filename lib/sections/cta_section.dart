import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/buttons.dart';


class CtaSection extends StatelessWidget {
  final GlobalKey? sectionKey;
  const CtaSection({super.key, this.sectionKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Ready to Order?',
            style: GoogleFonts.outfit(
              fontSize: responsiveFontSize(context, 32, 48),
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Join thousands of happy customers. Download Nala Foods and start ordering today!',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.white.withValues(alpha: 0.85),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 36),
          CtaButton(
            label: 'Download for Android',
            icon: Icons.download_rounded,
            onPressed: () async {
              final uri = Uri.parse('/apk/app-release.apk');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
          ),
          const SizedBox(height: 16),
          GhostButton(
            label: 'Become a Partner',
            icon: Icons.store_rounded,
            onPressed: () async {
              final uri = Uri.parse('/apk/app-release.apk');
              if (await canLaunchUrl(uri)) {
                await launchUrl(uri);
              }
            },
          ),
        ],
      ),
    );
  }
}
