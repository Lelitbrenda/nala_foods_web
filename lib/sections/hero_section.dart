import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import '../theme/app_theme.dart';
import '../widgets/buttons.dart';

class HeroSection extends StatefulWidget {
  final GlobalKey? heroKey;
  const HeroSection({super.key, this.heroKey});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  static const List<String> _mockups = ['assets/mockups/photo1.png', 'assets/mockups/photo2.png'];
  int _currentMockup = 0;

  Future<void> _downloadApk() async {
    final uri = Uri.parse('/apk/app-release.apk');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _switchMockup() {
    setState(() {
      _currentMockup = (_currentMockup + 1) % _mockups.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      key: widget.heroKey,
      height: screenHeight * 0.9,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.background, const Color(0xFF0A0A0A), AppColors.background],
        ),
      ),
      child: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: isWide ? 48 : 16),
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 1400),
                  child: isWide ? _buildDesktopLayout() : _buildMobileLayout(screenHeight * 1.05),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      children: [
        Expanded(flex: 4, child: _buildTextContent()),

        const SizedBox(width: 20),

        Expanded(
          flex: 6,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              // Orange glow
              Container(
                width: 900,
                height: 600,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.35),
                      AppColors.primary.withOpacity(0.15),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.45, 1.0],
                  ),
                ),
              ),

              // Decorative dots
              Positioned(
                left: 120,
                top: 180,
                child: SizedBox(
                  width: 120,
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List.generate(
                      20,
                      (_) => Container(
                        width: 4,
                        height: 4,
                        decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.5), shape: BoxShape.circle),
                      ),
                    ),
                  ),
                ),
              ),

              // Back screenshot
              Positioned(
                left: 80,
                child: Opacity(
                  opacity: 0.85,
                  child: Transform.rotate(
                    angle: -0.12,
                    child: Transform.scale(scale: 0.82, child: _buildMockupImage(_mockups[1])),
                  ),
                ),
              ),

              // Front screenshot
              Positioned(right: 40, child: Transform.rotate(angle: 0.05, child: _buildMockupImage(_mockups[0]))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(double availableHeight) {
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: availableHeight),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTextContent(),
          const SizedBox(height: 40),
          GestureDetector(onTap: _switchMockup, child: _buildMockupImage(_mockups[_currentMockup])),
          const SizedBox(height: 12),
          Text('Tap to switch view', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted)),
        ],
      ),
    );
  }

  Widget _buildMockupImage(String path) {
    return _HeroMockup(path: path);
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.primarySoft,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.restaurant, size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                'Discover & Order',
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Discover Local\nRestaurants and\n',
                style: GoogleFonts.outfit(
                  fontSize: responsiveFontSize(context, 26, 72),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.05,
                ),
              ),
              TextSpan(
                text: 'Order with Ease',
                style: GoogleFonts.outfit(
                  fontSize: responsiveFontSize(context, 26, 72),
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  height: 1.05,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Text(
            'Browse menus, connect with restaurants, and enjoy a smarter food ordering experience.',
            style: GoogleFonts.inter(fontSize: 18, color: AppColors.textSecondary, height: 1.6),
          ),
        ),
        const SizedBox(height: 36),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            CtaButton(label: 'Download for Android', icon: Icons.download_rounded, onPressed: _downloadApk),
            GhostButton(label: 'See Features', icon: Icons.explore_rounded, onPressed: () {}),
          ],
        ),
      ],
    );
  }
}

class _HeroMockup extends StatefulWidget {
  final String path;

  const _HeroMockup({required this.path});

  @override
  State<_HeroMockup> createState() => _HeroMockupState();
}

class _HeroMockupState extends State<_HeroMockup>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late final AnimationController _hoverController;
  late final Animation<double> _hoverAnimation;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _hoverAnimation = CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeOutCubic,
    );
    _hoverController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final h = _hoverAnimation.value;
    final offsetY = -(12.0 * h);
    final scale = 1.0 + (0.04 * h);

    return MouseRegion(
      onEnter: (_) {
        if (!_isHovered) {
          _isHovered = true;
          _hoverController.forward();
        }
      },
      onExit: (_) {
        if (_isHovered) {
          _isHovered = false;
          _hoverController.reverse();
        }
      },
      child: Transform(
        transform: Matrix4.identity()
          ..translateByVector3(Vector3(0.0, offsetY, 0.0))
          ..scaleByVector3(Vector3(scale, scale, 1.0)),
        alignment: Alignment.center,
        child: Container(
          width: 340,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.45),
                blurRadius: 80,
                spreadRadius: 5,
                offset: const Offset(0, 35),
              ),
              BoxShadow(
                color: AppColors.primary.withOpacity(0.18),
                blurRadius: 120,
                spreadRadius: 10,
                offset: const Offset(0, 40),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Image.asset(widget.path, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
