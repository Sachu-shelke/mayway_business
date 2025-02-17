import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:mayway_business/config/manager/storage_manager.dart';
import 'package:mayway_business/config/routes/router_import.gr.dart';
import 'package:mayway_business/config/theme/app_colors.dart';
import 'package:mayway_business/config/theme/app_text_style.dart';
import 'package:mayway_business/constants/app_const_assets.dart';
import 'package:mayway_business/constants/app_sizes.dart';
import 'package:mayway_business/constants/app_storage_key.dart';
import 'package:mayway_business/widget/app_background_widget.dart';
import 'package:mayway_business/widget/button/primary_button.dart';

@RoutePage()
class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({super.key});

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // AutoRouter.of(context).pushAndPopUntil(
        //   MainHomeScreenRoute(isFirstLoad: false),
        //   predicate: (_) => false,
        // );
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: AppBackGroundWidget(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: AppSizes.size30,
                ),
                Image.asset(
                  AppAssets.noInternet,
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                ),
                const SizedBox(
                  height: AppSizes.size30,
                ),
                Text(
                  "Whoops!!",
                  style: AppTextStyle.regular36.copyWith(fontFamily: "Bebas"),
                ),
                const SizedBox(
                  height: AppSizes.size40,
                ),
                Text(
                  "No internet connection was found. Check your connection or try again.",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bold16,
                ),
                const SizedBox(
                  height: AppSizes.size40,
                ),
                PrimaryButton(
                  // tColor: AppColors.whiteColor,
                  // bColor: AppColors.btnBlueColor,
                  onTap: () async {
                    bool isLogedIn =
                        StorageManager.getBoolValue(AppStorageKey.isLogIn) ??
                            false;
                    if (isLogedIn == true) {
                      context.router.push(PinCodeOtpRoute(
                          isSignup: false,
                          isForgetOtp: false,
                          isSplash: false));
                      // AutoRouter.of(context).pushAndPopUntil(
                      //   MainHomeScreenRoute(isFromSignup: false),
                      //   predicate: (_) => false,
                      // );
                    } else {
                      context.router.pushAndPopUntil(
                        const LoginScreenRoute(),
                        predicate: (route) => false,
                      );
                    }
                  },
                  text: "Try again",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
