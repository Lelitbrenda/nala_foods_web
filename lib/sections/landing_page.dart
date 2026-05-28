import 'dart:html' as html;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../nav_bar.dart';
import '../sections/hero_section.dart';
import '../sections/why_nala_section.dart';
import '../sections/customer_experience.dart';
import '../sections/seller_experience.dart';
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
                const CustomerExperience(),
                const SellerExperience(),
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
          child: _buildLinksColumn('Support', ['FAQ', 'Contact Us', 'Privacy Policy', 'Terms of Service']),
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
        _buildLinksColumn('Support', ['FAQ', 'Contact Us', 'Privacy Policy', 'Terms of Service']),
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

  Widget _buildLinksColumn(String title, List<String> links) {
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
        ...links.map((link) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            link,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 14,
            ),
          ),
        )),
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
