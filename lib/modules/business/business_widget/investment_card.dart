import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mayway_business/config/theme/app_colors.dart';

import '../../../config/routes/router_import.gr.dart';
import '../../income_passbook/income_passbook_screen.dart';
import '../../redeem/redeem_screen.dart';
import '../../refer/refer_screen.dart';

class IncomeDashboardCard extends StatelessWidget {
  final List<Map<String, String>> incomeList;

  const IncomeDashboardCard({super.key, required this.incomeList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150, // Set height for the cards
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color:AppColors.appColors, // Soft shadow color
              spreadRadius: 1, // How much the shadow spreads
              blurRadius: 12, // Softness of the shadow
              offset: Offset(0, 4), // Adjust vertical offset for a more natural look
            ),
          ],
        ),
        child: Card(
          color: Colors.white,
          elevation: 0, // Remove default Card elevation
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: incomeList.isEmpty
                ? const Center(child: Text("No Income Data Available"))
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: incomeList.map((item) {
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      String? navigation = item['Navigation'];
                      if (navigation != null && navigation.isNotEmpty) {
                        if (navigation == 'self-invest') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RedeemScreen(isFromEwallet: true)),
                          );
                        } else if (navigation == 'my-invest') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const IncomePassbookScreen(isFromDrawer: true)));
                        } else if (navigation == 'invite') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ReferScreen()),
                          );
                        } else {
                          print('Unknown navigation path: $navigation');
                        }
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(item['image']!, height: 50, fit: BoxFit.contain),
                          const SizedBox(height: 8),
                          Text(
                            item['name']!,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      )

    );
  }
}
