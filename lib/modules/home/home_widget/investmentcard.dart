import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../config/manager/global_singleton.dart';
import '../../../config/theme/app_colors.dart';

class InvestmentCardWidget extends StatefulWidget {
  const InvestmentCardWidget({Key? key}) : super(key: key);

  @override
  _InvestmentCardWidgetState createState() => _InvestmentCardWidgetState();
}

class _InvestmentCardWidgetState extends State<InvestmentCardWidget> {
  final Dio _dio = Dio();
  int? userId;
  double totalInvestment = 0;
  double totalEarning = 0;
  double totalRemaining = 0;

  @override
  void initState() {
    super.initState();
    userId = int.tryParse(GlobalSingleton.loginInfo!.data!.id.toString());
    if (userId != null) {
      fetchUserEarnings(userId!);
    } else {
      print("User ID is null!");
    }
  }

  Future<void> fetchUserEarnings(int userId) async {
    try {
      Response response = await _dio.post(
        'https://api.mayway.in/api/refferal-report/user-earning',
        data: {'user_id': userId},
      );

      print("API Response: ${response.data}"); // Print full response

      if (response.statusCode == 200 && response.data['data'] != null) {
        var earningsData = response.data['data'][0];

        print("User ID: ${earningsData['user_id']}");
        print("Total Investment: ${earningsData['total_investment']}");
        print("Total Earning: ${earningsData['total_earning']}");
        print("Total Remaining: ${earningsData['total_remaining']}");

        setState(() {
          totalInvestment = double.parse(earningsData['total_investment'].toString());
          totalEarning = double.parse(earningsData['total_earning'].toString());
          totalRemaining = double.parse(earningsData['total_remaining'].toString());
        });
      } else {
        print("Error fetching earnings: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception fetching earnings: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return userId == null
        ? const Center(child: CircularProgressIndicator())
        : Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildInvestmentCard("₹${totalInvestment.toStringAsFixed(2)}", "Investment"),
          buildInvestmentCard("₹${totalEarning.toStringAsFixed(2)}", "Returns"),
          buildInvestmentCard("₹${totalRemaining.toStringAsFixed(2)}", "Remaining"),
        ],
      ),
    );
  }

  Widget buildInvestmentCard(String amount, String label) {
    return Expanded(
      child: Card(
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.appColors,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  amount,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
