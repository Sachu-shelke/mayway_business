import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mayway_business/config/manager/storage_manager.dart';
import 'package:mayway_business/config/routes/router_import.gr.dart';
import 'package:mayway_business/constants/app_storage_key.dart';

class SplashViewPresenter {
  Future checkForceUpdateApiCall(BuildContext context) async {}
}

class BasicSplashPresenter implements SplashViewPresenter {
  @override
  Future checkForceUpdateApiCall(context) async {
    bool isLogedIn =
        StorageManager.getBoolValue(AppStorageKey.isLogIn) ?? false;
    if (isLogedIn == true) {
      context.router.pushAndPopUntil(
        PinCodeOtpRoute(isSplash: true, isSignup: false),
        predicate: (route) => false,
      );
    } else {
      context.router.pushAndPopUntil(
        const LoginScreenRoute(),
        predicate: (route) => false,
      );
    }
  }
}
