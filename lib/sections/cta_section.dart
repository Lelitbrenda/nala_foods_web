import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_container.dart';
import '../widgets/buttons.dart';

class CtaSection extends StatelessWidget {
  const CtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionContainer(
      padding: EdgeInsets.symmetric(vertical: 72),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Food Ordering, Reimagined",
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Text(
              "Join thousands of happy customers and restaurants. Download Nala Foods today!",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 36),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              PrimaryButton(
                label: "Get Started",
                icon: Icons.download_rounded,
                onPressed: () {},
              ),
              SecondaryButton(
                label: "Become a Seller",
                icon: Icons.store_rounded,
                isOutlined: true,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}