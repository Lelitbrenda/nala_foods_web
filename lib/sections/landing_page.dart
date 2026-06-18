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
        _modalSection('What is Nala Foods',
          'Nala Foods is a mobile application that connects food lovers with local restaurants and vendors. '
          'Through the app, customers can browse restaurants and menus, place food orders, track deliveries '
          'in real time, leave reviews, manage their profiles, and communicate directly with restaurant vendors.\n\n'
          'The platform serves three types of users: Customers — individuals who browse, order, and review food; '
          'Restaurant Vendors / Sellers — businesses that list their menus, manage orders, and communicate with '
          'customers; and Delivery Personnel — individuals who pick up and deliver orders (where applicable).\n\n'
          'Nala Foods is owned and operated by [NALA FOODS], with a registered address at [NANYUKI]. If you have '
          'any questions about this policy, you may contact us at lelitbrenda@gmail.com or visit our website at '
          'https://nalafoods.site/.'),
        _modalSection('Introduction',
          'This Privacy Policy explains how Nala Foods ("we") collects, uses, stores, shares, and protects your '
          'personal information when you use our mobile application and related services (collectively, the "Service").\n\n'
          'By downloading, accessing, or using the Nala Foods app, you agree to the collection and use of your '
          'information in accordance with this Privacy Policy. If you do not agree with any part of this policy, '
          'please discontinue use of the Service immediately.\n\n'
          'This policy applies to all users of the app, including customers, restaurant vendors/sellers, and '
          'delivery personnel.'),
        _modalSection('Information We Collect',
          'We collect different types of information depending on how you use the Service.\n\n'
          'Account Information. When you register an account, we collect your name, email address, phone number, '
          'and any profile information you choose to provide. This information is necessary to create and maintain '
          'your account, verify your identity, and enable you to use the Service.\n\n'
          'Location Information. We collect your precise and/or approximate location when you use the app. This '
          'includes your delivery addresses, GPS coordinates (used for delivery tracking and restaurant discovery), '
          'and the locations of restaurants listed on the platform. We collect this information to facilitate food '
          'delivery, show you nearby restaurants, and provide accurate delivery time estimates.\n\n'
          'User-Generated Content. We collect any content you upload or submit to the Service. This includes '
          'profile pictures, product images (for vendors), restaurant images, reviews, ratings, comments, product '
          'descriptions, and business information submitted by vendors. This content is stored and displayed within '
          'the app to enable core functionality such as browsing menus, reading reviews, and managing restaurant '
          'listings.\n\n'
          'Order Information. We collect details about every order you place, including the items ordered, order '
          'history, delivery instructions, transaction records, and interactions with restaurants. This information '
          'is used to process your orders, manage deliveries, maintain order history, and provide customer support.\n\n'
          'Technical Information. We automatically collect certain information about your device and how you interact '
          'with the app. This includes device type, operating system version, app version, log data (such as crash '
          'reports and performance data), and diagnostic information. We use this information to improve the app\'s '
          'performance, fix bugs, and ensure compatibility across devices.\n\n'
          'Communication Data. When you communicate with vendors or customer support through the app, we may collect '
          'the content of those communications, including chat messages and support inquiries. This helps us facilitate '
          'orders, resolve disputes, and improve the quality of our service.'),
        _modalSection('How We Collect Information',
          'We collect information in the following ways:\n\n'
          'Information You Provide Directly. You provide information when you create an account, place an order, '
          'upload images, write reviews, fill out your profile, communicate with vendors, or contact our support team.\n\n'
          'Information Collected Automatically. We use analytics tools and logging systems to automatically collect '
          'technical information about your device and app usage. This includes crash reporting, performance monitoring, '
          'and usage statistics that help us improve the Service.\n\n'
          'Information from Your Device. With your permission, we access your device\'s location services (GPS) to '
          'provide delivery tracking and nearby restaurant recommendations. We also access your device\'s camera and '
          'photo library when you choose to upload images or take photos within the app.\n\n'
          'Information from Third Parties. We may receive information about you from third-party services you choose '
          'to link to your account, such as Google Sign-In or other authentication providers. When you use these '
          'services, you authorize them to share certain information with us as described in their respective '
          'privacy policies.'),
        _modalSection('How We Use Information',
          'We use the information we collect for the following purposes:\n\n'
          'To Provide and Maintain the Service. We use your information to create and manage your account, process '
          'orders, facilitate deliveries, display restaurant listings and menus, and enable communication between '
          'customers and vendors.\n\n'
          'To Improve and Personalize Your Experience. We use your preferences, order history, and location to '
          'recommend restaurants, show relevant content, and tailor the app experience to your needs.\n\n'
          'To Communicate With You. We use your contact information to send order confirmations, delivery updates, '
          'account alerts, and responses to your inquiries. We may also send promotional messages with your consent, '
          'which you can opt out of at any time.\n\n'
          'To Ensure Safety and Security. We use technical information and account data to detect and prevent '
          'fraudulent activity, unauthorized access, and other misuse of the Service.\n\n'
          'To Comply With Legal Obligations. We may process your information to comply with applicable laws, '
          'regulations, or legal requests from authorities.\n\n'
          'For Analytics and Improvements. We use aggregated and anonymized data to analyze usage patterns, identify '
          'trends, and improve the app\'s functionality and user experience.'),
        _modalSection('Location Data Usage',
          'Location data is essential to the core functionality of Nala Foods.\n\n'
          'Delivery Services. When you place an order for delivery, we use your precise location (GPS coordinates) '
          'and delivery address to route the order to the correct restaurant, enable the delivery personnel to find '
          'your location, provide real-time delivery tracking, and estimate delivery times.\n\n'
          'Restaurant Discovery. We use your approximate location to show restaurants near you, sort results by '
          'distance, and display relevant delivery areas.\n\n'
          'Vendor Operations. For restaurant vendors, we use the restaurant\'s location to display it on maps, '
          'calculate delivery zones, and enable customer discovery.\n\n'
          'Background Location. We may request background location access to continue providing delivery tracking '
          'even when the app is minimized. This permission is used only when you have an active delivery in progress.\n\n'
          'Opt-Out. You can disable location services through your device settings at any time. However, doing so '
          'may limit or prevent certain features from working properly.'),
        _modalSection('User Uploaded Content',
          'Images, photos, and other content you upload to Nala Foods may be displayed publicly within the platform.\n\n'
          'Profile Pictures. Your profile picture may be visible to vendors (when you place an order or chat) and to '
          'customers (if you are a vendor).\n\n'
          'Vendor Content. If you are a restaurant vendor, images you upload (food photos, restaurant images, product '
          'images) will be displayed on your restaurant listing page.\n\n'
          'Reviews and Ratings. Reviews, ratings, and comments you submit may be displayed publicly on restaurant '
          'listing pages and may include your name and profile picture.\n\n'
          'Licensing. By uploading content, you grant Nala Foods a non-exclusive, royalty-free license to display, '
          'distribute, and reproduce your content within the Service for the purpose of operating and promoting the '
          'platform. You retain full ownership of your content.\n\n'
          'Removal. You may request removal of your uploaded content by contacting us at lelitbrenda@gmail.com. '
          'However, content that is part of public reviews or order records may be retained as required for '
          'legitimate business or legal purposes.'),
        _modalSection('Order and Delivery Information',
          'Your order and delivery information is central to how Nala Foods operates.\n\n'
          'Order Processing. When you place an order, your selected items, special instructions, and payment '
          'information are shared with the restaurant vendor to prepare your food. Order details are also shared '
          'with delivery personnel to enable pickup and delivery.\n\n'
          'Order History. Your order history is stored in your account and is visible to you at any time. Vendors '
          'can see their order history for business management purposes.\n\n'
          'Transaction Records. We maintain records of your transactions, including order totals, payment methods, '
          'and transaction dates, for accounting, dispute resolution, and customer support purposes.\n\n'
          'Delivery Tracking. Real-time location data is shared between customers, vendors, and delivery personnel '
          'to coordinate the delivery process. This data is used only for the duration of the delivery.\n\n'
          'Communication Logs. Messages exchanged between customers and vendors regarding orders are stored to '
          'facilitate order fulfillment and resolve any issues that may arise.'),
        _modalSection('Firebase and Third-Party Services',
          'Nala Foods uses Google Firebase, a comprehensive app development platform provided by Google LLC, to '
          'power many of its core features. Firebase processes and stores your information on secure Google Cloud '
          'servers, which may be located in various regions around the world.\n\n'
          'Firebase Authentication. We use Firebase Authentication to manage user registration and login. When you '
          'sign up or log in, your email address, password (stored in encrypted form), and account identifiers are '
          'processed and stored by Firebase.\n\n'
          'Cloud Firestore. We use Cloud Firestore as our primary database. Your user profile, restaurant information, '
          'product listings, orders, reviews, chat messages, and delivery details are stored in Firestore. Data is '
          'encrypted at rest and in transit.\n\n'
          'Firebase Cloud Storage. We use Firebase Cloud Storage to store uploaded images such as profile pictures, '
          'product photos, and restaurant images. Files are encrypted at rest.\n\n'
          'Firebase Cloud Messaging (FCM). We use FCM to send push notifications to your device, including order '
          'status updates, delivery tracking alerts, promotional offers (with your consent), and account-related '
          'notifications.\n\n'
          'Firebase Cloud Functions. We use Cloud Functions for server-side processing, including sending automated '
          'notifications, processing order updates, and executing business logic.\n\n'
          'Firebase App Check. We use App Check to verify that requests to our Firebase services come from your '
          'genuine installed app, helping to prevent fraud and unauthorized access. App Check does not collect '
          'personal information.\n\n'
          'For more information about how Firebase processes your data, please review Google\'s Privacy Policy at '
          'https://policies.google.com/privacy.'),
        _modalSection('Push Notifications',
          'Nala Foods uses Firebase Cloud Messaging (FCM) to send push notifications directly to your device.\n\n'
          'Types of Notifications. You may receive notifications regarding order status changes (confirmed, dispatched, '
          'delivered), delivery updates, promotional offers and discounts (if you have opted in), account alerts '
          '(password changes, login activity), and new restaurant or menu items in your area.\n\n'
          'Permission. Push notifications are only sent after you grant explicit permission through your device\'s '
          'notification settings.\n\n'
          'Opt-Out. You may opt out of promotional notifications at any time by adjusting your preferences in the '
          'app settings or by disabling notifications for the Nala Foods app in your device settings. Transactional '
          'notifications (order updates, delivery alerts) may still be sent as they are essential to the Service.\n\n'
          'Data Used for Notifications. To deliver notifications, we use your device\'s unique FCM token. This token '
          'is generated by Firebase and is used solely for the purpose of routing notifications to your device.'),
        _modalSection('Data Sharing and Disclosure',
          'We DO NOT sell your personal information to third parties. However, we may share your information in the '
          'following circumstances:\n\n'
          'With Restaurant Vendors. When you place an order, your name, delivery address, phone number, and order '
          'details are shared with the restaurant vendor so they can prepare and deliver your order.\n\n'
          'With Delivery Personnel. Your name, delivery address, phone number, and delivery instructions are shared '
          'with delivery personnel to enable them to pick up your order and deliver it to your location.\n\n'
          'With Service Providers. We may share your information with trusted third-party service providers who help '
          'us operate the Service, including cloud hosting (Firebase), payment processors, analytics providers, and '
          'customer support tools. These providers are contractually obligated to protect your data.\n\n'
          'For Legal Reasons. We may disclose your information if required to do so by law, or in response to a valid '
          'legal request from a governmental authority.\n\n'
          'Business Transfers. In the event of a merger, acquisition, or sale of all or substantially all of our '
          'assets, your information may be transferred to the acquiring entity.\n\n'
          'With Your Consent. We may share your information for any other purpose with your explicit consent.'),
        _modalSection('Data Storage and Security',
          'We take the security of your personal information seriously and implement reasonable technical and '
          'organizational measures to protect it.\n\n'
          'Encryption. Data transmitted between the app and our servers is encrypted using industry-standard Transport '
          'Layer Security (TLS). Data stored in Firebase services is encrypted at rest using AES-256 encryption.\n\n'
          'Access Controls. Access to personal data within our systems is restricted to authorized personnel who need '
          'it to perform their job functions.\n\n'
          'Authentication Security. Passwords are stored using strong hashing algorithms and are never stored in '
          'plain text. We encourage you to use a strong, unique password for your account.\n\n'
          'App Security. We use Firebase App Check to verify the authenticity of requests to our backend services.\n\n'
          'Limitations. No method of electronic storage or transmission is 100% secure. While we strive to protect '
          'your personal information, we cannot guarantee its absolute security.\n\n'
          'Data Breach Response. In the event of a data breach that affects your personal information, we will notify '
          'you in accordance with applicable legal requirements.'),
        _modalSection('Data Retention',
          'We retain your personal information only as long as necessary to fulfill the purposes described in this '
          'Privacy Policy, unless a longer retention period is required or permitted by law.\n\n'
          'Account Information. Your account information is retained for as long as your account is active. If you '
          'delete your account, we will delete or anonymize your personal information within a reasonable timeframe.\n\n'
          'Order and Transaction Records. Order and transaction records are retained for business, accounting, and '
          'legal purposes. These records may be kept for a period required by applicable laws (typically 5-7 years).\n\n'
          'Uploaded Content. Content you upload (images, reviews, etc.) is retained as long as it is relevant to the '
          'Service. If you delete your account, your uploaded content may be removed or anonymized.\n\n'
          'Communication Logs. Chat messages and support communications may be retained for customer service, dispute '
          'resolution, and quality assurance purposes.\n\n'
          'Technical Data. Log data and diagnostic information are retained for a shorter period, typically up to 90 '
          'days, unless needed for longer for security or legal reasons.\n\n'
          'Backup Retention. Deleted data may persist in backups for a limited period until those backups are cycled '
          'out in accordance with our backup retention schedule.'),
        _modalSection('User Rights and Choices',
          'Depending on your jurisdiction, you may have the following rights regarding your personal information:\n\n'
          'Access and Portability. You have the right to request a copy of the personal information we hold about '
          'you. You may also request that we provide your data in a structured, commonly used, and machine-readable '
          'format.\n\n'
          'Correction. You have the right to request that we correct any inaccurate or incomplete personal information.\n\n'
          'Deletion. You have the right to request the deletion of your personal information, subject to certain '
          'exceptions.\n\n'
          'Restriction of Processing. You have the right to request that we restrict the processing of your personal '
          'information under certain circumstances.\n\n'
          'Objection to Processing. You have the right to object to the processing of your personal information for '
          'direct marketing purposes.\n\n'
          'Withdrawal of Consent. Where we rely on your consent to process your information, you have the right to '
          'withdraw that consent at any time.\n\n'
          'Complaint. If you believe that we have violated your privacy rights, you have the right to file a complaint '
          'with a relevant data protection authority.\n\n'
          'To exercise any of these rights, please contact us at lelitbrenda@gmail.com.'),
        _modalSection('Account Deletion Process',
          'You may request the deletion of your account and associated personal information at any time.\n\n'
          'How to Request Deletion. To request account deletion, please contact us at lelitbrenda@gmail.com with the '
          'subject line "Account Deletion Request" and include the email address associated with your Nala Foods '
          'account.\n\n'
          'What We Delete. Upon processing your deletion request, we will delete or anonymize your personal information, '
          'including your account profile, saved addresses, payment information, preferences, and uploaded content.\n\n'
          'What We Retain. Certain information may be retained even after account deletion if required by law or for '
          'legitimate business purposes, including order and transaction records and records of communications '
          'necessary to resolve disputes.\n\n'
          'Processing Time. We will process your deletion request within 30 days of receiving it. We may need to '
          'verify your identity before processing the request.\n\n'
          'Effect of Deletion. Once your account is deleted, you will lose access to all account features, including '
          'order history, saved preferences, and any active orders.\n\n'
          'Data Backup Deletion. Data removed from our active systems may persist in backups for a limited period.'),
        _modalSection('Children\'s Privacy',
          'Nala Foods is not intended for use by children under the age of 18 (or the equivalent minimum age in your '
          'jurisdiction). We do not knowingly collect personal information from children.\n\n'
          'If you are a parent or guardian and you believe that your child has provided us with personal information '
          'without your consent, please contact us at lelitbrenda@gmail.com. If we become aware that we have collected '
          'personal information from a child without verifiable parental consent, we will take steps to delete that '
          'information promptly.'),
        _modalSection('International Data Transfers',
          'Nala Foods uses Google Firebase services, which are operated by Google LLC. Your personal information may '
          'be transferred to and processed on servers located outside your country of residence, including in the '
          'United States and other countries where Google Cloud maintains data centers.\n\n'
          'When we transfer your data across international borders, we take appropriate safeguards to ensure that '
          'your information is protected in accordance with this Privacy Policy and applicable data protection laws.\n\n'
          'By using the Service, you consent to the transfer of your information to countries that may have different '
          'data protection laws than your country of residence.'),
        _modalSection('Changes to This Privacy Policy',
          'We may update this Privacy Policy from time to time to reflect changes in our practices, legal requirements, '
          'or the features of the Service.\n\n'
          'We will notify you of material changes by posting the updated policy within the app and updating the '
          '"Effective Date" at the top of this policy. For significant changes, we may also notify you via email or '
          'through a prominent in-app notice.\n\n'
          'Your continued use of the Service after any changes to this Privacy Policy constitutes your acceptance of '
          'the updated policy. If you do not agree with the changes, you should discontinue use of the Service and '
          'delete your account.'),
        _modalSection('Contact Information',
          'If you have any questions, concerns, or requests regarding this Privacy Policy or our data practices, '
          'please contact us:\n\n'
          'Company/Business Name: [NALA FOODS]\n'
          'Email Address: lelitbrenda@gmail.com\n'
          'Website: https://nalafoods.site/\n'
          'Physical Address: [NANYUKI]\n\n'
          'We will respond to your inquiry within a reasonable timeframe, typically within 30 days.'),
      ],
    );
  }

  Widget _buildTermsContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _modalSection('Acceptance of Terms',
          'By downloading, accessing, or using the Nala Foods mobile application and related services (collectively, '
          'the "Service"), you agree to be bound by these Terms of Use ("Terms"). If you do not agree to these '
          'Terms, please do not use the Service.\n\n'
          'These Terms constitute a legally binding agreement between you ("User" or "you") and [NALA] ("Nala Foods", '
          '"we," "our," or "us"). Your use of the Service is also subject to our Privacy Policy, which is incorporated '
          'by reference.'),
        _modalSection('Description of Service',
          'Nala Foods is a mobile application that connects food customers with local restaurants and food vendors. '
          'The platform enables users to browse restaurant menus, place food orders, arrange for pickup or delivery, '
          'communicate with vendors, and manage their accounts.\n\n'
          'The Service may include features for three types of users: Customers — individuals who browse, order, '
          'and review food; Restaurant Vendors / Sellers — businesses that list menus, manage orders, and communicate '
          'with customers; and Delivery Personnel — individuals who pick up and deliver orders (where applicable).'),
        _modalSection('Account Registration',
          'To use certain features of the Service, you must create an account. When registering, you agree to provide '
          'accurate, current, and complete information. You are responsible for maintaining the confidentiality of '
          'your login credentials and for all activities that occur under your account.\n\n'
          'You must be at least 13 years of age (or the equivalent minimum age in your jurisdiction) to create an '
          'account. If you are under 18, you must have the consent of a parent or legal guardian.\n\n'
          'You agree to notify us immediately of any unauthorized use of your account. We are not liable for any '
          'loss or damage arising from your failure to protect your account credentials.'),
        _modalSection('User Conduct',
          'When using the Service, you agree not to:\n\n'
          '- Violate any applicable law, regulation, or third-party right\n'
          '- Provide false, misleading, or fraudulent information\n'
          '- Interfere with or disrupt the operation of the Service\n'
          '- Attempt to gain unauthorized access to any part of the Service\n'
          '- Use the Service for any unlawful or prohibited purpose\n'
          '- Harass, abuse, or harm other users, vendors, or delivery personnel\n'
          '- Submit false or misleading reviews or ratings\n'
          '- Upload or transmit viruses, malware, or any malicious code\n'
          '- Collect or harvest user information without consent'),
        _modalSection('Orders and Payments',
          'Order Placement. When you place an order through the Service, you agree to pay the total amount shown '
          'at checkout, including all applicable taxes, fees, and delivery charges. Orders are subject to acceptance '
          'by the restaurant vendor.\n\n'
          'Order Modifications and Cancellations. You may modify or cancel an order only within the time frame '
          'specified by the vendor or as permitted by applicable law. Once a vendor begins preparing your order, '
          'modifications and cancellations may not be possible.\n\n'
          'Pricing. All prices are displayed in the currency specified by the vendor. Prices are subject to change '
          'at any time without prior notice, but changes will not affect orders that have already been accepted.\n\n'
          'Payment Processing. Payments may be processed through third-party payment processors. By providing payment '
          'information, you represent that you are authorized to use the payment method and authorize us to charge '
          'the applicable amounts.\n\n'
          'Refunds. Refunds are handled in accordance with our refund policy, which may vary depending on the vendor '
          'and the circumstances. Please contact our support team for refund requests.'),
        _modalSection('Vendor Terms',
          'Listing and Menu Management. Vendors are responsible for maintaining accurate and up-to-date information '
          'about their business, including menu items, pricing, availability, operating hours, and location.\n\n'
          'Order Fulfillment. Vendors agree to fulfill orders placed through the Service in a timely manner and to '
          'meet the quality standards represented in their listings.\n\n'
          'Compliance. Vendors represent that they hold all necessary licenses, permits, and approvals required to '
          'operate their food business and to prepare and sell food to the public.\n\n'
          'Fees. Vendors agree to pay any applicable service fees, commission fees, or other charges as described in '
          'the separate Vendor Agreement or within the app.\n\n'
          'Indemnification. Vendors agree to indemnify and hold Nala Foods harmless from any claims, damages, or '
          'liabilities arising from their products, services, or conduct.'),
        _modalSection('Delivery Services',
          'Delivery Personnel. Delivery personnel are independent contractors or employees of the vendor or a '
          'third-party delivery service. They are not employees of Nala Foods.\n\n'
          'Delivery Estimates. Delivery time estimates are provided as approximations only. We do not guarantee '
          'delivery within any specific time frame.\n\n'
          'Delivery Areas. Delivery is available only within designated delivery zones. We reserve the right to '
          'change delivery areas at any time.\n\n'
          'Delivery Instructions. You agree to provide accurate delivery instructions and to be available to receive '
          'your order at the designated delivery location.'),
        _modalSection('Intellectual Property',
          'The Service, including its design, layout, graphics, logos, text, content, and software, is owned by '
          'Nala Foods or its licensors and is protected by copyright, trademark, and other intellectual property laws.\n\n'
          'You may not reproduce, distribute, modify, create derivative works from, or exploit any part of the '
          'Service without our prior written consent.'),
        _modalSection('User Content',
          'By submitting content to the Service (including reviews, ratings, photos, and comments), you grant Nala '
          'Foods a non-exclusive, royalty-free, perpetual, and worldwide license to use, display, reproduce, and '
          'distribute your content in connection with the Service.\n\n'
          'You represent that you own or have the necessary rights to any content you submit, and that such content '
          'does not violate the rights of any third party.'),
        _modalSection('Limitation of Liability',
          'To the maximum extent permitted by applicable law, Nala Foods and its officers, directors, employees, '
          'and agents shall not be liable for any indirect, incidental, special, consequential, or punitive damages '
          'arising out of or relating to your use of the Service, including but not limited to:\n\n'
          '- Errors, interruptions, or delays in the Service\n'
          '- Loss of data, profits, or business opportunities\n'
          '- Food quality, safety, or accuracy of orders\n'
          '- Acts or omissions of vendors, delivery personnel, or other users\n'
          '- Unauthorized access to your account or data\n\n'
          'Our total liability for any claim arising from your use of the Service shall not exceed the total amount '
          'you have paid to us in the twelve (12) months preceding the claim.'),
        _modalSection('Disclaimer of Warranties',
          'The Service is provided on an "as is" and "as available" basis, without any warranties of any kind, '
          'either express or implied. We do not warrant that the Service will be uninterrupted, error-free, secure, '
          'or free from viruses or other harmful components.\n\n'
          'We do not control, endorse, or guarantee the quality, safety, or legality of food items offered by '
          'vendors, or the accuracy of vendor listings. We are not responsible for the conduct of vendors, delivery '
          'personnel, or other users.'),
        _modalSection('Termination',
          'We may suspend or terminate your access to the Service at any time, with or without cause, with or '
          'without notice. Grounds for termination may include, but are not limited to:\n\n'
          '- Violation of these Terms\n'
          '- Fraudulent, abusive, or illegal activity\n'
          '- Conduct that harms other users, vendors, or the Service\n'
          '- Request by law enforcement or government agency\n\n'
          'Upon termination, your right to use the Service immediately ceases. You may also delete your account at '
          'any time by using the account deletion feature within the app.'),
        _modalSection('Dispute Resolution',
          'Governing Law. These Terms shall be governed by and construed in accordance with the laws of '
          '[Jurisdiction/Country], without regard to its conflict of laws principles.\n\n'
          'Informal Resolution. Before filing any claim, you agree to attempt to resolve the dispute informally by '
          'contacting us at lelitbrenda@gmail.com. We will attempt to resolve the dispute within 30 days.\n\n'
          'Arbitration. If the dispute cannot be resolved informally, you agree to resolve any claims through '
          'binding individual arbitration, rather than in court. You agree to waive any right to participate in a '
          'class-action lawsuit or class-wide arbitration.\n\n'
          'Exceptions. You may bring claims in small claims court if they qualify. Either party may seek injunctive '
          'or equitable relief in court for intellectual property infringement or unauthorized access to the Service.'),
        _modalSection('Changes to Terms',
          'We reserve the right to modify these Terms at any time. We will notify you of material changes by posting '
          'the updated Terms within the app and updating the "Effective Date" at the top.\n\n'
          'Your continued use of the Service after any changes constitutes your acceptance of the updated Terms. If '
          'you do not agree with the changes, you should discontinue use of the Service and delete your account.'),
        _modalSection('Severability',
          'If any provision of these Terms is found to be unenforceable or invalid, that provision shall be limited '
          'or eliminated to the minimum extent necessary, and the remaining provisions shall remain in full force '
          'and effect.'),
        _modalSection('Entire Agreement',
          'These Terms, together with our Privacy Policy, constitute the entire agreement between you and Nala Foods '
          'regarding your use of the Service and supersede any prior agreements or understandings.'),
        _modalSection('Contact Information',
          'If you have any questions, concerns, or requests regarding these Terms, please contact us:\n\n'
          'Company/Business Name: [NALA]\n'
          'Email Address: lelitbrenda@gmail.com\n'
          'Website: https://nalafoods.site/\n\n'
          'We will respond to your inquiry within a reasonable timeframe.'),
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
              Container(
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(8),
                child: Image.asset('assets/logo/logo19.png', height: 32, fit: BoxFit.contain),
              ),
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
            _FooterLink('Privacy Policy', _showPrivacyPolicy, alwaysUnderlined: true),
            _FooterLink('Terms of Service', _showTermsOfService, alwaysUnderlined: true),
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
        Container(
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(8),
          child: Image.asset('assets/logo/logo19.png', height: 32, fit: BoxFit.contain),
        ),
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
          child: _FooterLinkWidget(
            label: link.label,
            onTap: link.onTap,
            alwaysUnderlined: link.alwaysUnderlined,
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
  final bool alwaysUnderlined;
  const _FooterLink(this.label, this.onTap, {this.alwaysUnderlined = false});
}

class _FooterLinkWidget extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool alwaysUnderlined;

  const _FooterLinkWidget({
    required this.label,
    required this.onTap,
    this.alwaysUnderlined = false,
  });

  @override
  State<_FooterLinkWidget> createState() => _FooterLinkWidgetState();
}

class _FooterLinkWidgetState extends State<_FooterLinkWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: GoogleFonts.inter(
            color: _isHovered ? Colors.white : Colors.white.withValues(alpha: 0.5),
            fontSize: 14,
            decoration: widget.alwaysUnderlined
                ? TextDecoration.underline
                : TextDecoration.none,
            decorationColor: _isHovered ? Colors.white : Colors.white.withValues(alpha: 0.5),
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
