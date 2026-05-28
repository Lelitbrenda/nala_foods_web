import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

class NavBar extends StatefulWidget {
  final ScrollController scrollController;

  const NavBar({super.key, required this.scrollController});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isScrolled = false;
  bool _isMobileOpen = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 40;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  void _downloadApk() {
    final anchor = html.AnchorElement(href: '/apk/app-release.apk')
      ..download = 'NalaFoods.apk';
    anchor.click();
  }

  void _scrollTo(String section) {
    setState(() => _isMobileOpen = false);
    final offsets = {
      'home': 0.0,
      'restaurants': 800.0,
      'categories': 1600.0,
      'download': 2400.0,
      'contact': 3200.0,
    };
    final target = offsets[section] ?? 0.0;
    widget.scrollController.animateTo(
      target,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _isScrolled
            ? Colors.white.withValues(alpha: 0.85)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _isScrolled ? AppColors.border.withValues(alpha: 0.3) : Colors.transparent,
          ),
        ),
      ),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: _isScrolled ? 10 : 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 768;
              return isWide ? _buildDesktopNav() : _buildMobileNav();
            },
        ),
      ),
    );
  }

  Widget _buildDesktopNav() {
    return Row(
      children: [
        Image.asset('assets/logo/logo19.png', height: 48, fit: BoxFit.contain),
        const SizedBox(width: 48),
        ...['Home', 'Restaurants', 'Categories', 'Download', 'Contact'].map((item) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextButton(
              onPressed: () => _scrollTo(item.toLowerCase()),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              child: Text(item),
            ),
          );
        }),
        const Spacer(),
        _buildDownloadButton(),
      ],
    );
  }

  Widget _buildMobileNav() {
    return Column(
      children: [
        Row(
          children: [
            Image.asset('assets/logo/logo19.png', height: 40, fit: BoxFit.contain),
            const Spacer(),
            IconButton(
              icon: Icon(_isMobileOpen ? Icons.close : Icons.menu, color: AppColors.textPrimary),
              onPressed: () => setState(() => _isMobileOpen = !_isMobileOpen),
            ),
          ],
        ),
        if (_isMobileOpen) ...[
          const SizedBox(height: 16),
          ...['Home', 'Restaurants', 'Categories', 'Download', 'Contact'].map((item) {
            return ListTile(
              title: Text(item, style: const TextStyle(fontWeight: FontWeight.w500)),
              onTap: () => _scrollTo(item.toLowerCase()),
              contentPadding: EdgeInsets.zero,
              minVerticalPadding: 4,
            );
          }),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: _buildDownloadButton(),
          ),
        ],
      ],
    );
  }

  Widget _buildDownloadButton() {
    return ElevatedButton(
      onPressed: _downloadApk,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.download_rounded, size: 18),
          SizedBox(width: 8),
          Text('Download', style: TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
