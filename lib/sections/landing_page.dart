import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../nav_bar.dart';
import '../widgets/modal.dart';
import 'hero_section.dart';
import 'features_section.dart';
import 'how_it_works.dart';
import 'screenshots_section.dart';
import 'restaurant_section.dart';
import 'customer_experience.dart';
import 'cta_section.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final ScrollController _scrollController = ScrollController();
  String _activeSection = 'home';

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _featuresKey = GlobalKey();
  final GlobalKey _howItWorksKey = GlobalKey();
  final GlobalKey _screenshotsKey = GlobalKey();
  final GlobalKey _restaurantsKey = GlobalKey();
  final GlobalKey _customerKey = GlobalKey();
  final GlobalKey _ctaKey = GlobalKey();

  late final Map<String, GlobalKey> _sectionKeys;

  @override
  void initState() {
    super.initState();
    _sectionKeys = {
      'home': _heroKey,
      'features': _featuresKey,
      'screenshots': _screenshotsKey,
      'restaurants': _restaurantsKey,
    };
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    final sections = [
      ('home', 0.0),
      ('features', 300.0),
      ('screenshots', 1300.0),
      ('restaurants', 2500.0),
      ('cta', 3800.0),
    ];

    String active = 'home';
    for (final section in sections) {
      if (offset >= section.$2) {
        active = section.$1;
      }
    }
    if (active != _activeSection) {
      setState(() => _activeSection = active);
    }
  }

  void _showPrivacyPolicy() {
    AppModal.show(
      context: context,
      title: 'Privacy Policy',
      body: _buildPrivacyContent(),
      primaryLabel: 'Close',
      onPrimary: () {},
    );
  }

  void _showTermsOfService() {
    AppModal.show(
      context: context,
      title: 'Terms of Service',
      body: _buildTermsContent(),
      requireScrollToBottom: true,
      primaryLabel: 'Agree & Continue',
      onPrimary: () {},
      secondaryLabel: 'Decline',
      onSecondary: () {},
    );
  }

  Widget _buildPrivacyContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _modalSection('Information We Collect',
          'When you use Nala Foods, we collect information you provide directly, such as your name, '
          'email address, phone number, delivery address, and payment details. We also collect order '
          'history, preferences, and device information to improve your experience.'),
        _modalSection('How We Use Your Information',
          'We use your information to process and deliver orders, communicate order status, provide '
          'customer support, personalize recommendations, and improve our services. With your consent, '
          'we may send promotional offers and updates about new restaurants and features.'),
        _modalSection('Information Sharing',
          'We share your information with restaurants and delivery partners to fulfill orders, with '
          'payment processors to complete transactions, and with service providers who assist our '
          'operations. We do not sell your personal information to third parties.'),
        _modalSection('Data Security',
          'We implement industry-standard security measures including encryption, secure servers, '
          'and regular security audits to protect your information. However, no method of transmission '
          'over the internet is 100% secure.'),
        _modalSection('Your Rights',
          'You have the right to access, correct, or delete your personal information. You can update '
          'your account details at any time or contact us to request data removal. You may also opt out '
          'of marketing communications.'),
        _modalSection('Contact Us',
          'For questions about this Privacy Policy or to exercise your data rights, contact us at '
          'privacy@nalafoods.com or write to Nala Foods, Nairobi, Kenya.'),
      ],
    );
  }

  Widget _buildTermsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _modalSection('Acceptance of Terms',
          'By downloading or using the Nala Foods application, you agree to be bound by these Terms of Service. '
          'If you do not agree to these terms, please do not use the application.'),
        _modalSection('Description of Service',
          'Nala Foods provides a platform that connects users with local restaurants for food ordering and delivery. '
          'We act as an intermediary between customers and restaurants, facilitating orders and payments.'),
        _modalSection('User Accounts',
          'You are responsible for maintaining the confidentiality of your account credentials and for all activities '
          'that occur under your account. You must notify us immediately of any unauthorized use of your account.'),
        _modalSection('Orders and Payments',
          'All orders placed through the platform are subject to restaurant availability and acceptance. '
          'Prices are set by restaurants and may change. Payments are processed securely through our payment partners.'),
        _modalSection('Delivery',
          'Delivery times are estimates and not guaranteed. Nala Foods is not responsible for delays caused by '
          'restaurants, traffic, weather, or other factors beyond our control.'),
        _modalSection('User Conduct',
          'You agree to use the platform responsibly and not for any unlawful purpose. You may not misuse the '
          'platform, interfere with its operation, or attempt to access it through unauthorized means.'),
        _modalSection('Limitation of Liability',
          'Nala Foods shall not be liable for any indirect, incidental, special, consequential, or punitive damages '
          'resulting from your use of the platform or any orders placed through it.'),
        _modalSection('Changes to Terms',
          'We reserve the right to modify these terms at any time. Users will be notified of material changes. '
          'Continued use of the platform after changes constitutes acceptance of the new terms.'),
        _modalSection('Contact',
          'For questions about these Terms of Service, please contact us at legal@nalafoods.com.'),
      ],
    );
  }

  Widget _modalSection(String title, String body) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textSecondary,
              height: 1.6,
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
                SizedBox(height: 90),
                HeroSection(heroKey: _heroKey),
                FeaturesSection(sectionKey: _featuresKey),
                HowItWorks(sectionKey: _howItWorksKey),
                ScreenshotsSection(sectionKey: _screenshotsKey),
                RestaurantSection(sectionKey: _restaurantsKey),
                CustomerExperience(sectionKey: _customerKey),
                CtaSection(sectionKey: _ctaKey),
                _buildFooter(),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              scrollController: _scrollController,
              sectionKeys: _sectionKeys,
              activeSection: _activeSection,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: const Color(0xFF0A0A0A),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;
          return Column(
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 1400),
                child: isWide ? _buildDesktopFooter() : _buildMobileFooter(),
              ),
              const SizedBox(height: 40),
              Divider(color: Colors.white.withValues(alpha: 0.08)),
              const SizedBox(height: 24),
              Text(
                '2026 Nala Foods. All rights reserved.',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.3),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/logo/logo19.png', height: 40, fit: BoxFit.contain),
              const SizedBox(height: 16),
              Text(
                'Discover local restaurants and order food with ease.',
                style: GoogleFonts.inter(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 1,
          child: _footerLinksColumn('Navigation', [
            _FooterLink('Home', () => _scrollToKey(_heroKey)),
            _FooterLink('Features', () => _scrollToKey(_featuresKey)),
            _FooterLink('Screenshots', () => _scrollToKey(_screenshotsKey)),
            _FooterLink('Restaurants', () => _scrollToKey(_restaurantsKey)),
            _FooterLink('Download', () => _scrollToKey(_ctaKey)),
          ]),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 1,
          child: _footerLinksColumn('Legal', [
            _FooterLink('Privacy Policy', _showPrivacyPolicy),
            _FooterLink('Terms of Service', _showTermsOfService),
          ]),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 1,
          child: _footerLinksColumn('Contact', [
            _FooterLink('hello@nalafoods.com', () {}),
            _FooterLink('+254 700 123 456', () {}),
          ]),
        ),
      ],
    );
  }

  Widget _buildMobileFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/logo/logo19.png', height: 40, fit: BoxFit.contain),
        const SizedBox(height: 24),
        _footerLinksColumn('Navigation', [
          _FooterLink('Home', () => _scrollToKey(_heroKey)),
          _FooterLink('Features', () => _scrollToKey(_featuresKey)),
          _FooterLink('Screenshots', () => _scrollToKey(_screenshotsKey)),
          _FooterLink('Restaurants', () => _scrollToKey(_restaurantsKey)),
          _FooterLink('Download', () => _scrollToKey(_ctaKey)),
        ]),
        const SizedBox(height: 24),
        _footerLinksColumn('Legal', [
          _FooterLink('Privacy Policy', _showPrivacyPolicy),
          _FooterLink('Terms of Service', _showTermsOfService),
        ]),
        const SizedBox(height: 24),
        _footerLinksColumn('Contact', [
          _FooterLink('hello@nalafoods.com', () {}),
          _FooterLink('+254 700 123 456', () {}),
        ]),
      ],
    );
  }

  Widget _footerLinksColumn(String title, List<_FooterLink> links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GestureDetector(
            onTap: link.onTap,
            child: Text(
              link.label,
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.5),
                fontSize: 14,
              ),
            ),
          ),
        )),
      ],
    );
  }

  void _scrollToKey(GlobalKey key) {
    if (key.currentContext == null) return;
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.1,
    );
  }
}

class _FooterLink {
  final String label;
  final VoidCallback onTap;
  const _FooterLink(this.label, this.onTap);
}
