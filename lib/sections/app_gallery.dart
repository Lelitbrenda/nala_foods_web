import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';

class AppGallery extends StatefulWidget {
  const AppGallery({super.key});

  @override
  State<AppGallery> createState() => _AppGalleryState();
}

class _AppGalleryState extends State<AppGallery> {
  final PageController _pageController = PageController(viewportFraction: 0.75);
  int _currentPage = 0;

  final List<String> _imageAssets = [
    'assets/Images/image1.png',
    'assets/Images/image2.png',
    'assets/Images/image3.png',
    'assets/Images/image4.png',
    'assets/Images/promo1.png',
    'assets/Images/food.jpg',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: const EdgeInsets.symmetric(vertical: 64),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'App Gallery',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Text(
              'Explore the Nala Foods experience',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            height: 420,
            child: PageView.builder(
              controller: _pageController,
              itemCount: _imageAssets.length,
              onPageChanged: (index) {
                setState(() => _currentPage = index);
              },
              itemBuilder: (context, index) {
                return _buildGalleryItem(index);
              },
            ),
          ),
          const SizedBox(height: 24),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildGalleryItem(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.textPrimary.withValues(alpha: 0.12),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.asset(
          _imageAssets[index],
          fit: BoxFit.cover,
          errorBuilder: (context, error, stack) {
            return Container(
              color: AppColors.grey100,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.image_rounded, size: 56, color: AppColors.grey600),
                    const SizedBox(height: 12),
                    Text('Image ${index + 1}', style: const TextStyle(color: AppColors.textMuted)),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(_imageAssets.length, (index) {
        final isActive = index == _currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.grey300,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}