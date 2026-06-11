import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';
import '../widgets/phone_frame.dart';

class CustomerExperience extends StatelessWidget {
  final GlobalKey? sectionKey;
  const CustomerExperience({super.key, this.sectionKey});

  static const List<_ExperienceData> _experiences = [
    _ExperienceData(
      icon: Icons.shopping_bag_rounded,
      title: 'Seamless Ordering',
      description: 'Place your order in seconds. Our intuitive interface makes it easy to find what you want, customize your meal, and checkout without any hassle.',
      image: 'assets/screenshots/scrn2.png',
    ),
    _ExperienceData(
      icon: Icons.map_rounded,
      title: 'Easy Discovery',
      description: 'Find new restaurants and dishes you will love. Our smart recommendations help you discover hidden gems in your neighborhood.',
      image: 'assets/screenshots/scrn3.png',
    ),
    _ExperienceData(
      icon: Icons.chat_bubble_rounded,
      title: 'Direct Communication',
      description: 'Chat directly with restaurants for special requests, dietary questions, or order modifications. No middlemen, just direct conversation.',
      image: 'assets/screenshots/scrn1.png',
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

class _ExperienceRow extends StatelessWidget {
  final _ExperienceData experience;
  final bool isReversed;

  const _ExperienceRow({
    required this.experience,
    required this.isReversed,
  });

  @override
  Widget build(BuildContext context) {
    final phoneWidth = 240.0;
    final phoneHeight = phoneWidth * 2.1;

    final imageWidget = SizedBox(
      width: phoneWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildPhoneGlow(phoneWidth, phoneHeight),
          PhoneFrame(
            screenshotPath: experience.image,
            width: phoneWidth,
            height: phoneHeight,
          ),
        ],
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
          child: Icon(experience.icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(height: 20),
        Text(
          experience.title,
          style: GoogleFonts.outfit(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.lightTextPrimary,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          experience.description,
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
        Expanded(child: isReversed ? textWidget : imageWidget),
        const SizedBox(width: 48),
        Expanded(child: isReversed ? imageWidget : textWidget),
      ],
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final _ExperienceData experience;

  const _ExperienceCard({
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    final phoneWidth = 240.0;
    final phoneHeight = phoneWidth * 2.1;

    return Column(
      children: [
        SizedBox(
          width: phoneWidth,
          child: Stack(
            alignment: Alignment.center,
            children: [
              _buildPhoneGlow(phoneWidth, phoneHeight),
              PhoneFrame(
                screenshotPath: experience.image,
                width: phoneWidth,
                height: phoneHeight,
              ),
            ],
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

Widget _buildPhoneGlow(double phoneWidth, double phoneHeight) {
  return IgnorePointer(
    child: Container(
      width: phoneWidth * 1.5,
      height: phoneHeight * 0.75,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            AppColors.primary.withValues(alpha: 0.08),
            AppColors.primary.withValues(alpha: 0.03),
            Colors.transparent,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    ),
  );
}
