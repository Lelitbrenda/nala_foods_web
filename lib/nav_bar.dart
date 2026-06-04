import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'theme/app_theme.dart';

class NavBar extends StatefulWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;
  final String activeSection;

  const NavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
    required this.activeSection,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _isScrolled = false;
  bool _isMobileOpen = false;

  static const List<_NavItem> _navItems = [
    _NavItem('Home', 'home'),
    _NavItem('Features', 'features'),
    _NavItem('Screenshots', 'screenshots'),
    _NavItem('For Restaurants', 'restaurants'),
  ];

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
    final scrolled = widget.scrollController.offset > 100;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  void _scrollTo(String section) {
    setState(() => _isMobileOpen = false);
    final key = widget.sectionKeys[section];
    if (key == null || key.currentContext == null) return;

    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
      alignment: 0.1,
    );
  }

  Future<void> _downloadApk() async {
    final uri = Uri.parse('/apk/app-release.apk');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _isScrolled ? 70 : 90,
      decoration: BoxDecoration(
        color: _isScrolled
            ? const Color(0xF20F0F0F)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _isScrolled
                ? AppColors.border.withValues(alpha: 0.15)
                : Colors.transparent,
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width > 768 ? 48 : 16,
        ),
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
        Image.asset(
          'assets/logo/logo19.png',
          height: _isScrolled ? 36 : 40,
          fit: BoxFit.contain,
        ),
        const SizedBox(width: 48),
        ..._navItems.map((item) {
          final isActive = widget.activeSection == item.key;
          return _NavLink(
            label: item.label,
            isActive: isActive,
            onTap: () => _scrollTo(item.key),
          );
        }),
        const Spacer(),
        _buildDownloadButtonDesktop(),
      ],
    );
  }

  Widget _buildMobileNav() {
    return Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Image.asset(
                'assets/logo/logo19.png',
                height: 36,
                fit: BoxFit.contain,
              ),
              const Spacer(),
              SizedBox(
                width: 48,
                height: 48,
                child: IconButton(
                  icon: Icon(
                    _isMobileOpen ? Icons.close : Icons.menu_rounded,
                    color: AppColors.textPrimary,
                    size: 24,
                  ),
                  onPressed: () => setState(() => _isMobileOpen = !_isMobileOpen),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDownloadButtonDesktop() {
    return MouseRegion(
      child: ElevatedButton(
        onPressed: _downloadApk,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0,
          textStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.download_rounded, size: 18),
            SizedBox(width: 8),
            Text('Download App'),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String key;
  const _NavItem(this.label, this.key);
}

class _NavLink extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavLink({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: _isHovered
              ? (Matrix4.identity()..translate(0.0, -2.0)..scale(1.05))
              : Matrix4.identity(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: widget.isActive || _isHovered
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: widget.isActive ? 20 : 0,
                height: 2,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
