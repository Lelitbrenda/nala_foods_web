import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';

class CustomerExperience extends StatelessWidget {
  final GlobalKey? sectionKey;
  const CustomerExperience({super.key, this.sectionKey});

  static const List<_ExperienceData> _experiences = [
    _ExperienceData(
      icon: Icons.shopping_bag_rounded,
      title: 'Seamless Ordering',
      description: 'Place your order in seconds. Our intuitive interface makes it easy to find what you want, customize your meal, and checkout without any hassle.',
      image: 'assets/screenshots/Screenshot_20260604-143327.png',
    ),
    _ExperienceData(
      icon: Icons.map_rounded,
      title: 'Easy Discovery',
      description: 'Find new restaurants and dishes you will love. Our smart recommendations help you discover hidden gems in your neighborhood.',
      image: 'assets/screenshots/Screenshot_20260604-143352.png',
    ),
    _ExperienceData(
      icon: Icons.chat_bubble_rounded,
      title: 'Direct Communication',
      description: 'Chat directly with restaurants for special requests, dietary questions, or order modifications. No middlemen, just direct conversation.',
      image: 'assets/screenshots/Screenshot_20260604-143245.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      key: sectionKey,
      color: AppColors.lightBackground,
      child: SectionContainer(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
        child: Column(
          children: [
            const SectionTitle(
              title: 'Designed for You',
              subtitle: 'Every feature is built with the customer experience in mind.',
              light: true,
            ),
            const SizedBox(height: 56),
            LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 768;
                return Column(
                  children: List.generate(_experiences.length, (index) {
                    final isReversed = index.isOdd;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: isWide
                          ? _ExperienceRow(
                              experience: _experiences[index],
                              isReversed: isReversed,
                            )
                          : _ExperienceCard(
                              experience: _experiences[index],
                            ),
                    );
                  }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceData {
  final IconData icon;
  final String title;
  final String description;
  final String image;
  const _ExperienceData({
    required this.icon,
    required this.title,
    required this.description,
    required this.image,
  });
}

class _ExperienceRow extends StatefulWidget {
  final _ExperienceData experience;
  final bool isReversed;

  const _ExperienceRow({
    required this.experience,
    required this.isReversed,
  });

  @override
  State<_ExperienceRow> createState() => _ExperienceRowState();
}

class _ExperienceRowState extends State<_ExperienceRow> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = (screenHeight * 0.65).clamp(400.0, 520.0);

    final imageWidget = MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        transform: _isHovered
            ? (Matrix4.identity()..scale(1.02))
            : Matrix4.identity(),
        constraints: const BoxConstraints(maxWidth: 280),
        height: imageHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: AppColors.lightSurface,
          border: Border.all(
            color: AppColors.lightBorder.withValues(alpha: 0.5),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(
                alpha: _isHovered ? 0.1 : 0.03,
              ),
              blurRadius: 40,
              offset: const Offset(0, 20),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            widget.experience.image,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => Container(
              color: AppColors.grey100,
              child: const Center(
                child: Icon(Icons.phone_android_rounded, size: 64, color: AppColors.grey),
              ),
            ),
          ),
        ),
      ),
    );

    final textWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(widget.experience.icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(height: 20),
        Text(
          widget.experience.title,
          style: GoogleFonts.outfit(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.lightTextPrimary,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          widget.experience.description,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: AppColors.lightTextSecondary,
            height: 1.6,
          ),
        ),
      ],
    );

    return Row(
      children: [
        Expanded(child: widget.isReversed ? textWidget : imageWidget),
        const SizedBox(width: 48),
        Expanded(child: widget.isReversed ? imageWidget : textWidget),
      ],
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final _ExperienceData experience;
  const _ExperienceCard({required this.experience});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final imageHeight = (screenHeight * 0.55).clamp(320.0, 460.0);

    return Column(
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 280),
          height: imageHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: AppColors.lightSurface,
            border: Border.all(
              color: AppColors.lightBorder.withValues(alpha: 0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              experience.image,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.grey100,
                child: const Center(
                  child: Icon(Icons.phone_android_rounded, size: 64, color: AppColors.grey),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(experience.icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(height: 16),
        Text(
          experience.title,
          style: GoogleFonts.outfit(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.lightTextPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          experience.description,
          style: GoogleFonts.inter(
            fontSize: 14,
            color: AppColors.lightTextMuted,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
