// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mayway_business/config/manager/global_singleton.dart';
import 'package:mayway_business/config/manager/storage_manager.dart';
import 'package:mayway_business/config/routes/router_import.gr.dart';
import 'package:mayway_business/config/theme/app_colors.dart';
import 'package:mayway_business/config/theme/app_text_style.dart';
import 'package:mayway_business/constants/app_const_assets.dart';
import 'package:mayway_business/constants/app_const_text.dart';
import 'package:mayway_business/constants/app_sizes.dart';
import 'package:mayway_business/constants/common_style.dart';
import 'package:mayway_business/constants/method/common_method.dart';
import 'package:mayway_business/main.dart';
import 'package:mayway_business/modules/home/home_screen.dart';
import 'package:mayway_business/modules/privacy/about_us.dart';
import 'package:mayway_business/modules/privacy/privacy_policy.dart';
import 'package:mayway_business/modules/profile/basic_profile/basic_profile_screen.dart';
import 'package:mayway_business/modules/profile/profile_model.dart';
import 'package:mayway_business/modules/profile/profile_presenter.dart';
import 'package:mayway_business/modules/profile/profile_screen_view.dart';
import 'package:mayway_business/modules/setting/setting_screen.dart';
import 'package:mayway_business/utils/google_Ads.dart';
import 'package:mayway_business/widget/appbars/custom_app_bar.dart';
import 'package:mayway_business/widget/button/primary_button.dart';
import 'package:mayway_business/widget/logo.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  final bool isFromDrawer;
  const ProfileScreen({super.key, required this.isFromDrawer});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> implements ProfileView {
  late ProfileModel model;
  double? totalInvestment;
  double? totalEarning;
  bool isLoading = true;
  final Dio _dio = Dio();
  int? userId = int.tryParse(GlobalSingleton.loginInfo!.data!.id.toString());
  ProfilePresenter presenter = BasicProfilePresenter();
  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
    presenter.getProfile(context: context);
    userId = int.tryParse(GlobalSingleton.loginInfo!.data!.id.toString());
    if (userId != null) {
      fetchUserEarnings(userId!);
    } else {
      print("User ID is null!");
    }
  }

  @override
  void refreshModel(ProfileModel primePurchaseModel) {
    model = primePurchaseModel;

    if (mounted) {
      setState(() {});
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

        double? investment = double.tryParse(earningsData['total_investment']?.toString() ?? '0.0');
        double? earning = double.tryParse(earningsData['total_earning']?.toString() ?? '0.0');

        if (mounted) { // ✅ Check if the widget is still mounted before updating state
          setState(() {
            totalInvestment = investment;
            totalEarning = earning;
          });
        }
      } else {
        print("Error fetching earnings: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception fetching earnings: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: widget.isFromDrawer == true
          ? CustomAppBar(title: AppConstString.myProfile.tr())
          : null,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: AppColors.appColors,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            height: 160,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      boxShadow: [CommonStyle.boxShadow()],
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          decoration: const BoxDecoration(
                              color: AppColors.appColors,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(6, 6),
                                    blurRadius: 15.0,
                                    color: Color.fromARGB(255, 132, 179, 202),
                                    spreadRadius: 1)
                              ]),
                          alignment: Alignment.center,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ClipOval(
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(60),
                                  child: GlobalSingleton.profilePic != null
                                      ? Image.network(
                                          'https://api.mayway.in/${GlobalSingleton.profilePic}',
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          AppAssets.appLogo,
                                          width: 200,
                                          height: 200,
                                          fit: BoxFit.contain,
                                        ),
                                ),
                              ),
                              Positioned(
                                top: 5,
                                right: -15,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                BasicProfileScreen(
                                                  data: model.data,
                                                )));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.appColors),
                                    child: const Icon(
                                      Icons.edit,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // child: CircleAvatar(
                        //   radius: 30.w,
                        //   backgroundImage: const AssetImage(
                        //     "assets/logo_100.png",
                        //   ),
                        // ),
                      ),
                      // Container(
                      //   decoration: const BoxDecoration(
                      //     borderRadius: BorderRadius.only(
                      //         bottomLeft: Radius.circular(100),
                      //         bottomRight: Radius.circular(100)),
                      //   ),
                      //   child: Column(
                      //     children: [
                      //       const Padding(
                      //         padding: EdgeInsets.symmetric(horizontal: 16),
                      //         child: Logo(),
                      //         // child: CircleAvatar(
                      //         //   radius: 30.w,
                      //         //   backgroundImage: const AssetImage(
                      //         //     "assets/logo_100.png",
                      //         //   ),
                      //         // ),
                      //       ),
                      //       const SizedBox(
                      //         height: 10,
                      //       ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}",
                                  textScaleFactor: 1.0,
                                  style: AppTextStyle.semiBold18,
                                ),

                                const SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "+91 ${GlobalSingleton.loginInfo!.data!.mobile!}",
                                      textScaleFactor: 1.0,
                                      style: AppTextStyle.regular14,
                                    ),

                                    Container(
                                      height: 20, // Adjust height as needed
                                      child: VerticalDivider(
                                        color: Colors.black54, // Divider color
                                        thickness: 1, // Divider thickness
                                        width: 10, // Space between text and the divider
                                      ),
                                    ),

                                    Text(
                                      "${GlobalSingleton.loginInfo!.data!.mlmId}",
                                      textScaleFactor: 1.0,
                                      style: AppTextStyle.regular14,
                                    ),
                                  ],
                                ),

                              ],
                            ),
                      //     ],
                      //   ),
                      // ),
                      const SizedBox(
                        height: 18,
                      ),
                      IntrinsicHeight(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      // context.router.push(const PassbookRoute());
                                    },
                                    child: WalletBalanceContainer(
                                      title: "My Investment",
                                      subtitle:
                                      '₹ ${totalInvestment?.toStringAsFixed(2) ?? '0.00'}',
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      // context.router.push(const PassbookRoute());
                                    },
                                    child: WalletBalanceContainer(
                                      title: "Total Return",
                                      subtitle:
                                      '₹ ${totalEarning?.toStringAsFixed(2) ?? '0.00'}',
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            // const Padding(
                            //   padding: EdgeInsets.symmetric(vertical: 6),
                            //   child: Divider(color: primaryColor),
                            // ),
                            // Row(
                            //   children: const [
                            //     Expanded(
                            //       child: WalletBalanceContainer(
                            //         title: "Total Income",
                            //         subtitle: "${Constant.rupeesSymbol} 0",
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: WalletBalanceContainer(
                            //         title: "Total Withdraw",
                            //         subtitle: "${Constant.rupeesSymbol} 0",
                            //       ),
                            //     )add
                            //   ],
                            // ),
                            // const Padding(
                            //   padding: EdgeInsets.symmetric(vertical: 6),
                            //   child: Divider(color: primaryColor),
                            // ),
                            // Row(
                            //   // ignore: prefer_const_literals_to_create_immutables
                            //   children: [
                            //     Expanded(
                            //       child: InkWell(
                            //         onTap: () {},
                            //         child: WalletBalanceContainer(
                            //           title: "Total Earn CashBack",
                            //           subtitle:
                            //               "${AppConstString.rupeesSymbol} ${model.totalCashback.toStringAsFixed(2)}",
                            //         ),
                            //       ),
                            //     ),
                            //     Expanded(
                            //       child: InkWell(
                            //         onTap: () {
                            //           // context.router.push(const InviteEarnRoute());
                            //         },
                            //         child: WalletBalanceContainer(
                            //           title: "Total Referrals",
                            //           subtitle: '${model.totalReferral}',
                            //         ),
                            //       ),
                            //     )
                            //   ],
                            // ),
                            // const SizedBox(
                            //   height: 5,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: Text('You are a Prime Member',
                            //       style: AppTextStyle.semiBold16),
                            // ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: CommonStyleDecoration.serviceBoxDecoration(),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  margin:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(
                      //   AppConstString.paymentSetting.tr(),
                      //   style: AppTextStyle.semiBold16,
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (model.data.refFirstName != null)
                        customAppListTile(
                            icon: Icons.person_2_outlined,
                            title:
                                '(Ref.by) ${model.data.refFirstName} ${model.data.refLastName}',
                            isDrawer: true,
                            onTap: () {}),
                      if (model.data.refMobile != null)
                        customAppListTile(
                            icon: Icons.phone_enabled_outlined,
                            title: '+91 ${model.data.refMobile}',
                            onTap: () {}),
                      // customAppListTile(
                      //     icon: Icons.settings,
                      //     title: 'Settings',
                      //     onTap: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => const SettingScreen(),
                      //         ),
                      //       );
                      //     }),
                      customAppListTile(
                          icon: Icons.person,
                          title: 'Update Profile',
                          onTap: () {
                            // BasicProfileScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BasicProfileScreen(
                                  data: model.data,
                                ),
                              ),
                            );
                          }),
                      // customAppListTile(
                      //     icon: Icons.share,
                      //     title: AppConstString.inviteFriend.tr(),
                      //     onTap: () {
                      //       CommonMethod.referLink(
                      //           name:
                      //               "${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}",
                      //           referCode: GlobalSingleton
                      //               .loginInfo!.data!.mobile
                      //               .toString());
                      //     }),
                      customAppListTile(
                          icon: Icons.security,
                          title: AppConstString.privacyPolicy.tr(),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrivacyPolicyScreen(),
                              ),
                            );
                          }),
                      customAppListTile(
                          icon: Icons.security,
                          title: 'About Us',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AboutUsScreen(),
                              ),
                            );
                          }),

                      // customAppListTile(
                      //     icon: Icons.security,
                      //     title: 'Feedback',
                      //     onTap: () {
                      //       Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) => const FeedbackScreen(),
                      //         ),
                      //       );
                      //     }),
                      customAppListTile(
                          icon: Icons.call,
                          title: AppConstString.helpandSupport.tr(),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(32.0),
                                      ),
                                    ),
                                    insetPadding: const EdgeInsets.all(10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          RechargeContainer(
                                            title: 'Connect with us',
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: List.generate(
                                                    mirrorConnectList.length,
                                                    (index) => servicesIconDrawerWidget(
                                                        title:
                                                            mirrorConnectList[
                                                                index]['title'],
                                                        data: const [],
                                                        imageurl:
                                                            mirrorConnectList[
                                                                    index]
                                                                ['imageUrl'],
                                                        onPress:
                                                            mirrorConnectList[
                                                                    index]
                                                                ['function']),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: AppSizes.size6,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10),
                                                  child: PrimaryButton(
                                                    width: 200,
                                                    onTap: () {
                                                      appRouter.push(
                                                          const FeedbackScreenRoute());
                                                    },
                                                    text: 'Create Ticket',
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: AppSizes.size6,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }),
                      customAppListTile(
                          icon: Icons.logout,
                          title: 'Logout',
                          onTap: () {
                            StorageManager.clearSharedPreferences();
                            context.router
                                .pushAndPopUntil(
                              const LoginScreenRoute(),
                              predicate: (route) => false,
                            )
                                .then((value) {
                              setState(() {});
                            });
                          }),
                      if (Platform.isAndroid)
                        const SizedBox(
                          // height: 30,
                          child: Align(
                            //padding: EdgeInsets.symmetric(horizontal: 20),
                            alignment: Alignment.center,
                            //   child:
                            //   Column(
                            //   children: [
                            //     Text(
                            //       "Ver ${AppConstString.appVersion}",
                            //       textScaleFactor: 1.0,
                            //       style: TextStyle(
                            //           fontSize: 13.5,
                            //           fontWeight: FontWeight.w600,
                            //           color: Colors.black54,
                            //           letterSpacing: 0.8),
                            //     ),
                            //     Padding(
                            //       padding: EdgeInsets.symmetric(horizontal: 40),
                            //       child: Text(
                            //         "App Designed and Developed by MirrorInfo Tech Pvt Ltd",
                            //         textScaleFactor: 1.0,
                            //         textAlign: TextAlign.center,
                            //         style: TextStyle(
                            //             fontSize: 13.5,
                            //             fontWeight: FontWeight.w600,
                            //             color: Colors.black54,
                            //             letterSpacing: 0.8),
                            //       ),
                            //     ),
                            //     Text(
                            //       AppConstString.ownersNumber,
                            //       textScaleFactor: 1.0,
                            //       textAlign: TextAlign.center,
                            //       style: TextStyle(
                            //           fontSize: 13.5,
                            //           fontWeight: FontWeight.w600,
                            //           color: Colors.black54,
                            //           letterSpacing: 0.8),
                            //     ),
                            //   ],
                            // ),
                          ),
                        ),
                    ],
                  ),
                ),
                const GoogleAdsScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final List mirrorConnectList = [
    {
      "title": "Ticket",
      "imageUrl": AppAssets.todayMessage,
      "function": () {
        appRouter.push(const FeedbackScreenRoute());
      },
    },
    {
      "title": "WhatsApp",
      "imageUrl": AppAssets.whatsapp,
      "function": () {
        const number = AppConstString.supportNumber;
        CommonMethod.whatsapp(mobileNumber: number);
      },
    },
    {
      "title": "Telegram",
      "imageUrl": AppAssets.teleg,
      "function": () {
        launch('https://t.me/mirrorinfotech');
      },
    },
    // {
    //   "title": "Gmail",
    //   "imageUrl": AppAssets.gmail,
    //   "function": () {
    //     launch("mailto:support@mirrorinfo.in");
    //   },
    // },
    {
      "title": "Call",
      "imageUrl": AppAssets.call,
      "function": () {
        CommonMethod.call(number: AppConstString.supportNumber);
      },
    },
  ];

  Widget servicesIconDrawerWidget({
    required String? title,
    required String? imageurl,
    required Function()? onPress,
    required List<dynamic>? data,
  }) {
    return InkWell(
      onTap: onPress,
      child: Stack(
        children: [
          SizedBox(
            width: 80,
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  imageurl!,
                  width: 45,
                  height: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 40,
                  child: Text(
                    title!,
                    textScaleFactor: 1.0,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 79, 78, 78)),
                  ),
                )
              ],
            ),
          ),

          // else
          //   const SizedBox.shrink()
        ],
      ),
    );
  }

  Widget customAppListTile(
      {required IconData icon,
      required String title,
      String? subTitle,
      bool? isDrawer,
      void Function()? onTap}) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.appColors,
                ),
                const SizedBox(
                  width: AppSizes.size20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: AppTextStyle.semiBold16,
                    ),
                    const SizedBox(
                      height: AppSizes.size6,
                    ),
                    if (subTitle != null)
                      Text(
                        subTitle,
                        style: AppTextStyle.regular12
                            .copyWith(color: AppColors.greyColor),
                      ),
                  ],
                ),
                // const Spacer(),
                // const Icon(Icons.arrow_forward_ios_rounded)
              ],
            ),
          ),
        ),
        if (isDrawer != true)
          const Divider(
            color: AppColors.appColors,
            thickness: 1,
          )
      ],
    );
  }
}

class WalletBalanceContainer extends StatelessWidget {
  final String title;
  final String subtitle;

  const WalletBalanceContainer({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          // border: Border.all(color: primaryColor, width: .6),
          // // color: containerbg,
          // borderRadius: const BorderRadius.only(
          // topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          // boxShadow: CommonMethod.glocyShadow(color: Colors.blue)),
          // padding: EdgeInsets.symmetric(vertical: 12.h),
          // margin: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
          ),
      child: Column(
        children: [
          Text(subtitle,
              textScaleFactor: 1.0,
              style: const TextStyle(
                  fontSize: 18,
                  color: AppColors.secoundColors,
                  fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(
            title,
            textScaleFactor: 1.0,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}

