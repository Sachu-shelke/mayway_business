import 'package:flutter/material.dart';

import '../../widget/appbars/custom_app_bar.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Privacy Policy"),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Privacy Policy',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'At MayWay Technology, we take your privacy seriously. This Privacy Policy explains how we collect, use, and protect your personal and financial data when you interact with our services. By using our platform, you agree to the collection and use of information in accordance with this policy.',
              ),
              const SizedBox(height: 15),
              _buildSectionTitle('1. Information We Collect'),
              _buildBulletPoint('Personal Information: Name, contact details (email, phone number), address, and other identifiable information.'),
              _buildBulletPoint('Investment Data: Information about the investments made, including amounts, duration, and any other related financial details.'),
              _buildBulletPoint('Usage Data: Data on how you use our website or platform, including IP address, browser type, device information, and session data.'),
              
              const SizedBox(height: 15),
              _buildSectionTitle('2. How We Use Your Information'),
              _buildBulletPoint('To Provide Services: To manage and execute investments, process transactions, and offer customer support.'),
              _buildBulletPoint('To Improve Our Platform: We use usage data to enhance the user experience, fix bugs, and improve our platform’s features.'),
              _buildBulletPoint('To Comply with Legal Obligations: To comply with regulatory, legal, and compliance requirements.'),
              
              const SizedBox(height: 15),
              _buildSectionTitle('3. Data Security'),
              _buildBulletPoint('We use industry-standard encryption methods and secure servers to protect your data from unauthorized access.'),
              _buildBulletPoint('Only authorized personnel with legitimate reasons have access to your data.'),
              _buildBulletPoint('We retain your personal and financial information for as long as required by law.'),
              
              const SizedBox(height: 15),
              _buildSectionTitle('4. Your Rights'),
              _buildBulletPoint('Access: The right to request copies of your data.'),
              _buildBulletPoint('Rectification: The right to request correction of inaccurate data.'),
              _buildBulletPoint('Deletion: The right to request the deletion of your data.'),
              
              const SizedBox(height: 20),
              const Text(
                'Investment Terms & Conditions',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildSectionTitle('1. Investor Responsibility'),
              _buildBulletPoint('Market Risks: Investments are subject to market conditions, and their value may fluctuate.'),
              _buildBulletPoint('Decision-Making: The investor assumes full responsibility for their investment choices.'),
              _buildBulletPoint('Liability: MayWay Technology is not responsible for any financial losses due to market performance.'),
              
              const SizedBox(height: 15),
              _buildSectionTitle('2. Risk Disclosure'),
              _buildBulletPoint('Investment Risks: Investments inherently carry risks, including potential loss of principal.'),
              _buildBulletPoint('No Guaranteed Returns: While we provide opportunities, returns are not guaranteed.'),
              _buildBulletPoint('Diversification: We recommend diversifying your investments to manage risk effectively.'),
              
              const SizedBox(height: 15),
              _buildSectionTitle('3. Returns and Payouts'),
              _buildBulletPoint('Market-Linked Returns: Returns depend on market performance and asset classes.'),
              _buildBulletPoint('Payouts: Returns are paid as per the chosen investment plan.'),
              
              const SizedBox(height: 15),
              _buildSectionTitle('4. Compliance with Laws and Regulations'),
              _buildBulletPoint('Legal Obligations: Investors must comply with applicable tax and investment laws.'),
              _buildBulletPoint('AML/KYC Requirements: Investors must verify their identity before making investments.'),
              
              const SizedBox(height: 15),
              _buildSectionTitle('5. Investment Termination'),
              _buildBulletPoint('Investors can terminate their investments following the withdrawal process.'),
              _buildBulletPoint('MayWay Technology reserves the right to terminate accounts in case of violations.'),
              
              const SizedBox(height: 20),
              const Text(
                'For any questions, contact us at support@mayway.in',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
