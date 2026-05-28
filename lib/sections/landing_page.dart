import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../nav_bar.dart';
import '../sections/hero_section.dart';
import '../sections/why_nala_section.dart';
import '../sections/how_it_works.dart';
import '../sections/app_gallery.dart';
import '../sections/cta_section.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _showPrivacyPolicy() {
    showDialog(
      context: context,
      builder: (dialogContext) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    icon: const Icon(Icons.close_rounded),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.grey100,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Last updated: May 2026',
                style: TextStyle(fontSize: 13, color: AppColors.textMuted),
              ),
              const Divider(height: 32),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _privacySection('Information We Collect',
                        'When you use Nala Foods, we collect information you provide directly, such as your name, '
                        'email address, phone number, delivery address, and payment details. We also collect order '
                        'history, preferences, and device information to improve your experience.'),
                      _privacySection('How We Use Your Information',
                        'We use your information to process and deliver orders, communicate order status, provide '
                        'customer support, personalize recommendations, and improve our services. With your consent, '
                        'we may send promotional offers and updates about new restaurants and features.'),
                      _privacySection('Information Sharing',
                        'We share your information with restaurants and delivery partners to fulfill orders, with '
                        'payment processors to complete transactions, and with service providers who assist our '
                        'operations. We do not sell your personal information to third parties.'),
                      _privacySection('Data Security',
                        'We implement industry-standard security measures including encryption, secure servers, '
                        'and regular security audits to protect your information. However, no method of transmission '
                        'over the internet is 100% secure.'),
                      _privacySection('Your Rights',
                        'You have the right to access, correct, or delete your personal information. You can update '
                        'your account details at any time or contact us to request data removal. You may also opt out '
                        'of marketing communications.'),
                      _privacySection('Contact Us',
                        'For questions about this Privacy Policy or to exercise your data rights, contact us at '
                        'privacy@nalafoods.com or write to Nala Foods, Nairobi, Kenya.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                  ),
                  child: const Text('Close', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _privacySection(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary.withValues(alpha: 0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(height: 80),
                const HeroSection(),
                const WhyNalaSection(),
                const HowItWorks(),
                const AppGallery(),
                const CtaSection(),
                _buildFooter(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(scrollController: _scrollController),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: const Color(0xFF0F172A),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          return Column(
            children: [
              isWide ? _buildDesktopFooter() : _buildMobileFooter(),
              const SizedBox(height: 40),
              Divider(color: Colors.white.withValues(alpha: 0.1)),
              const SizedBox(height: 24),
              Text(
                '2026 Nala Foods. All rights reserved.',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.4),
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDesktopFooter() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: _buildBrandColumn(),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 1,
          child: _buildLinksColumn('Quick Links', ['Home', 'Restaurants', 'Categories', 'About Us']),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 1,
          child: _buildLinksColumn('Support', ['FAQ', 'Contact Us', 'Privacy Policy', 'Terms of Service'],
            onLinkTap: {'Privacy Policy': _showPrivacyPolicy},
          ),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 2,
          child: _buildNewsletterColumn(),
        ),
      ],
    );
  }

  Widget _buildMobileFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildBrandColumn(),
        const SizedBox(height: 32),
        _buildLinksColumn('Quick Links', ['Home', 'Restaurants', 'Categories', 'About Us']),
        const SizedBox(height: 24),
        _buildLinksColumn('Support', ['FAQ', 'Contact Us', 'Privacy Policy', 'Terms of Service'],
          onLinkTap: {'Privacy Policy': _showPrivacyPolicy},
        ),
        const SizedBox(height: 24),
        _buildNewsletterColumn(),
      ],
    );
  }

  Widget _buildBrandColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/logo/logo19.png', height: 48, fit: BoxFit.contain),
        const SizedBox(height: 16),
        Text(
          'Order from your favorite restaurants\nand enjoy seamless food delivery.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 14,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            _buildSocialIcon(Icons.facebook),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.camera_alt_outlined),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.alternate_email_rounded),
            const SizedBox(width: 12),
            _buildSocialIcon(Icons.chat_bubble_outline_rounded),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon, size: 20, color: Colors.white.withValues(alpha: 0.6)),
        padding: EdgeInsets.zero,
      ),
    );
  }

  Widget _buildLinksColumn(String title, List<String> links, {Map<String, VoidCallback>? onLinkTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map((link) {
          final tap = onLinkTap?[link];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: tap != null
                ? GestureDetector(
                    onTap: tap,
                    child: Text(
                      link,
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.white.withValues(alpha: 0.3),
                      ),
                    ),
                  )
                : Text(
                    link,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 14,
                    ),
                  ),
          );
        }),
      ],
    );
  }

  Widget _buildNewsletterColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Stay Updated',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Get the latest updates on new restaurants and offers.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.5),
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 14),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                  padding: const EdgeInsets.all(10),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
