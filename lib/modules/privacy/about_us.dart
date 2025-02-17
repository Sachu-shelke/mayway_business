import 'package:flutter/material.dart';
import 'package:mayway_business/config/theme/app_text_style.dart';
import 'package:mayway_business/widget/appbars/custom_app_bar.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(title: "About us"),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(
              'About Mayway Technology',
              style: AppTextStyle.semiBold16,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              '''
MayWay Technology is a trusted name in secure investment solutions, offering innovative opportunities to generate consistent returns. With over 3 years of experience, we specialize in leveraging advanced technology to develop reliable and cutting-edge investment platforms. Whether it’s in-house development or collaborations with trusted brokers, we ensure quality and transparency in every aspect of our operations.  

It is important to note that all investments are subject to market risks, and the complete responsibility for investment decisions lies with the investor. The company holds no liability for any losses incurred due to market fluctuations or other factors.  

Our mission is to empower individuals and businesses with secure and rewarding financial opportunities while maintaining transparency, trust, and growth for all our stakeholders.
''',
              textScaleFactor: 1.0,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Mayway is committed to transform the clarity',
              style: AppTextStyle.semiBold16,
            ),
          ],
        )
        //   Container(
        //     padding: const EdgeInsets.all(16),
        //     child: const Text(
        //       """Recharge and Utility services Digital Wallet

        // India’s First wallet payments & Shopping app with high cash back on Recharge and utility services.
        // #Mirror Provides mobile, DTH/Data card Recharge, Bill Payments, instant money transfers, online shopping and creating and gifting gift cards you can do it all securely with #Mirror.
        // Along with this Mirror is ways to make money online by using refer and earn program.
        // With the Mirror we strive to bring you daily needs through your mobile phone and desktop.
        // With innovation supported by various technologies we continuously upgrading our wallet that specially designed to fulfilled user’s daily requirements.
        // Mirror is committed to transform the clarity.""",
        //       textScaleFactor: 1.0,
        //     ),
        //   ),

        );
  }
}
