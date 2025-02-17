import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mayway_business/config/routes/router_import.gr.dart';
import 'package:mayway_business/config/theme/app_colors.dart';
import 'package:mayway_business/config/theme/app_text_style.dart';
import 'package:mayway_business/modules/business/business_dashboard/business_dashboard_screen.dart';

import '../../modules/home/home_screen_model.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Function onTap;
  final bool isPrime;
  final String title;

  const HomeAppBar(
      {super.key,
      required this.onTap,
      this.isPrime = false,
      required this.title});

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();

  @override
  Size get preferredSize => throw UnimplementedError();
}

class _HomeAppBarState extends State<HomeAppBar> {
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  late HomeScreenModel model;

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    return GlobalUpdateNotifier(
      onGlobalUpdate: () {
        setState(() {});
      },
      child: AppBar(
        elevation: 0,
        toolbarHeight: kToolbarHeight,
        backgroundColor: AppColors.appColors,
        iconTheme: const IconThemeData(color: AppColors.whiteColor),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Mayway business',
                textScaleFactor: 1.0,
                style: AppTextStyle.semiBold18
                    .copyWith(color: AppColors.whiteColor)),
            // SizedBox(width: 10,),
          // Text(
          //   formatAmount(
          //       model.todayIncome.toString()),
          //   overflow: TextOverflow.ellipsis,
          //   maxLines: 1,
          //   // style: AppTextStyle.regular20,
          // ),
            if (widget.isPrime) ...[
              const SizedBox(width: 10),
              const Text(
                "Prime",
                textScaleFactor: 1.0,
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              )
            ]
          ],
        ),
        actions: [

          IconButton(
            onPressed: () {
              context.router.push(const NotificationScreenRoute());
            },
            icon: const Icon(
              Icons.notifications,
              // color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

// String formatAmount(String amount) {
//   final formatter = NumberFormat('#,##0.00');
//   return formatter.format(double.parse(amount));
// }