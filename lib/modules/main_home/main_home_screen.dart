import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mayway_business/config/manager/global_singleton.dart';
import 'package:mayway_business/config/manager/storage_manager.dart';
import 'package:mayway_business/config/routes/router_import.gr.dart';
import 'package:mayway_business/config/theme/app_colors.dart';
import 'package:mayway_business/config/theme/app_text_style.dart';
import 'package:mayway_business/constants/app_const_assets.dart';
import 'package:mayway_business/constants/app_const_text.dart';
import 'package:mayway_business/constants/app_sizes.dart';
import 'package:mayway_business/constants/method/common_method.dart';
import 'package:mayway_business/modules/home/home_screen.dart';
import 'package:mayway_business/modules/main_home/drawer/drawer.dart';
import 'package:mayway_business/modules/main_home/main_home_model.dart';
import 'package:mayway_business/modules/main_home/main_home_presenter.dart';
import 'package:mayway_business/modules/main_home/mian_home_view.dart';
import 'package:mayway_business/modules/marketing/marketing_dashboard/marketing_dashboard_screen.dart';
import 'package:mayway_business/modules/profile/profile_screen.dart';
import 'package:mayway_business/modules/vendor/vendor_screen.dart';
import 'package:mayway_business/training_meeting/training_meeting_dashboard/training_meeting_dashboard_page.dart';
import 'package:mayway_business/widget/appbars/home_app_bar.dart';
import 'package:mayway_business/widget/button/primary_button.dart';

import '../business/business_dashboard/business_dashboard_screen.dart';
import '../business/business_widget/custombox.dart';

@RoutePage()
class MainHomeScreen extends StatefulWidget {
  final bool? isFromSignup;
  const MainHomeScreen({super.key, this.isFromSignup});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen>
    with SingleTickerProviderStateMixin
    implements MainHomeView {
  MainHomePresenter presenter = BasicMainHomePresenter();
  late MainHomeModel model;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? timer;
  int indexOF = 0;
  @override
  void initState() {
    super.initState();
    presenter.updateView = this;
    startTimer();
    if (GlobalSingleton.prime != 1) {
      presenter.getPrimePlanDetails(context: context);
    }

    presenter.getAdditionalUserInfoDetails(context: context);
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      indexOF++;
      if (indexOF > 4) {
        indexOF = 0;
      }
      setState(() {});
    });
  }

  @override
  void refreshModel(MainHomeModel mainHomeModel) {
    model = mainHomeModel;

    if (model.primeList.isNotEmpty) {
      getTimeCheck();
    }
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    timer!.cancel();

    super.dispose();
  }

  getTimeCheck() {
    DateTime currentTime = DateTime.now();

    // Check if it's after 12 AM
    // bool isAfter12AM = currentTime.hour >= 0 && currentTime.hour < 12;

    // // Check if it's after 12 PM
    // bool isAfter12PM = currentTime.hour >= 12;

    if (currentTime.hour >= 0 && currentTime.hour < 12) {
      StorageManager.clearKey('pmmarketingStoreTime');
      if (StorageManager.getIntValue('ammarketingStoreTime') == null) {
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        StorageManager.setIntValue(
            key: 'ammarketingStoreTime', value: timestamp);
      }
    } else {
      StorageManager.clearKey('ammarketingStoreTime');
      if (StorageManager.getIntValue('pmmarketingStoreTime') == null) {
        int timestamp = DateTime.now().millisecondsSinceEpoch;
        StorageManager.setIntValue(
            key: 'pmmarketingStoreTime', value: timestamp);
        //isPrime
        // if (GlobalSingleton.loginInfo!.data!.isPrime != 1) {
        showDialog(
          context: context,
          builder: (context) {
            return markeingWidget();
          },
        );
        // }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Row(
        children:[
          !(MediaQuery.of(context).size.width < 600)
              ? const CustomDrawer()
              : Container(),
          Expanded(
            child: WillPopScope(
              onWillPop: onWillPop,
              child: Scaffold(
                key: _scaffoldKey,
                drawer: (MediaQuery.of(context).size.width < 600)
                    ? const CustomDrawer()
                    : null,
                resizeToAvoidBottomInset: true,
                body: Stack(
                  children: [
                    Column(
                      children: [
                        getAppBar(),
                        Expanded(child: _getCurrentPage()),
                      ],
                    ),
                  ],
                ),
                // bottomNavigationBar: BottomNavigationBar(
                //   currentIndex: model.selectedIndex,
                //   onTap: (index) {
                //     setState(() {
                //       model.selectedIndex = index;
                //     });
                //   },
                //   selectedItemColor: AppColors.appColors,
                //   unselectedItemColor: Colors.black87,
                //   backgroundColor: AppColors.whiteColor,
                //   type: BottomNavigationBarType.fixed,
                //   enableFeedback: true,
                //   items: [
                //     BottomNavigationBarItem(
                //       label: 'Home',
                //       icon: Stack(alignment: Alignment.center, children: [
                //         if (indexOF == 0)
                //           Center(
                //             child: Lottie.asset(
                //               AppAssets.roundCircleeYellow,
                //               width: 50,
                //               fit: BoxFit.fill,
                //               height: 50,
                //               repeat: true,
                //             ),
                //           ),
                //         const Icon(
                //           Icons.home,
                //           size: 30,
                //         )
                //       ]),
                //     ),
                //     BottomNavigationBarItem(
                //       label: 'Business',
                //       icon: Stack(alignment: Alignment.center, children: [
                //         if (indexOF == 1)
                //           Center(
                //             child: Lottie.asset(
                //               AppAssets.roundCircleeYellow,
                //               width: 50,
                //               fit: BoxFit.fill,
                //               height: 50,
                //               repeat: true,
                //             ),
                //           ),
                //         const Icon(
                //           Icons.shopping_bag_outlined,
                //           size: 30,
                //         )
                //       ]),
                //     ),
                //     BottomNavigationBarItem(
                //       label: 'Profile',
                //       icon: Stack(alignment: Alignment.center, children: [
                //         if (indexOF == 2)
                //           Center(
                //             child: Lottie.asset(
                //               AppAssets.roundCircleeYellow,
                //               width: 50,
                //               fit: BoxFit.fill,
                //               height: 50,
                //               repeat: true,
                //             ),
                //           ),
                //         const Icon(
                //           Icons.health_and_safety,
                //           size: 30,
                //         )
                //       ]),
                //     ),
                //     // BottomNavigationBarItem(
                //     //   label: 'Training',
                //     //   icon: Stack(alignment: Alignment.center, children: [
                //     //     if (indexOF == 3)
                //     //       Center(
                //     //         child: Lottie.asset(
                //     //           AppAssets.roundCircleeYellow,
                //     //           width: 50,
                //     //           fit: BoxFit.fill,
                //     //           height: 50,
                //     //           repeat: true,
                //     //         ),
                //     //       ),
                //     //     const Icon(
                //     //       Icons.book,
                //     //       size: 30,
                //     //     )
                //     //   ]),
                //
                //     //   // Icon(Icons.book)
                //     // ),
                //     // BottomNavigationBarItem(
                //     //   label: 'Markeing',
                //     //   icon: Stack(alignment: Alignment.center, children: [
                //     //     if (indexOF == 4)
                //     //       Center(
                //     //         child: Lottie.asset(
                //     //           AppAssets.roundCircleeYellow,
                //     //           width: 50,
                //     //           fit: BoxFit.fill,
                //     //           height: 50,
                //     //           repeat: true,
                //     //         ),
                //     //       ),
                //     //     const Icon(
                //     //       Icons.book,
                //     //       size: 30,
                //     //     )
                //     //   ]),
                //     //   // Icon(Icons.person)
                //     // ),
                //
                //   ],
                // ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: model.selectedIndex,
                  onTap: (index) {
                    setState(() {
                      model.selectedIndex = index;
                    });
                  },
                  selectedItemColor: AppColors.appColors,
                  unselectedItemColor: Colors.black87,
                  backgroundColor: AppColors.whiteColor,
                  type: BottomNavigationBarType.fixed,
                  enableFeedback: true,
                  items: const [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: Icon(Icons.home,size: 30,)
                    ),
                    BottomNavigationBarItem(
                      label: 'Business',
                      icon: Icon(Icons.shopping_bag_outlined,
                                size: 30,
                              ),
                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: [
                      //     if (model.selectedIndex == 1)
                      //       Center(
                      //         child: Lottie.asset(
                      //           AppAssets.roundCircleeYellow,
                      //           width: 50,
                      //           fit: BoxFit.fill,
                      //           height: 50,
                      //           repeat: true,
                      //         ),
                      //       ),
                      //     SizedBox(
                      //       width: 30,
                      //       height: 30,
                      //       child: const Icon(
                      //         Icons.shopping_bag_outlined,
                      //         size: 30,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Profile',
                      icon: Icon(
                                Icons.person,
                                size: 30,
                              ),
                      // Stack(
                      //   alignment: Alignment.center,
                      //   children: [
                      //     if (model.selectedIndex == 4)
                      //       Center(
                      //         child: Lottie.asset(
                      //           AppAssets.roundCircleeYellow,
                      //           width: 50,
                      //           fit: BoxFit.fill,
                      //           height: 50,
                      //           repeat: true,
                      //         ),
                      //       ),
                      //     SizedBox(
                      //       width: 30,
                      //       height: 30,
                      //       child: const Icon(
                      //         Icons.person,
                      //         size: 30,
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                  ],
                ),

              ),
            ),
          ),
        ],
      ),
    ]);
  }

  Widget getAppBar() {
    if (model.selectedIndex == 0) {
      return HomeAppBar(
        onTap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        title: AppConstString.appName,
      );
    } else if (model.selectedIndex == 1) {
      return HomeAppBar(
        onTap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        title: "Business",
      );
    } else if (model.selectedIndex == 2) {
      return HomeAppBar(
        onTap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        title: "Vendors",
      );
    } else if (model.selectedIndex == 3) {
      return HomeAppBar(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProfileScreen(
              isFromDrawer: false,
            )),
          );
          // _scaffoldKey.currentState!.openDrawer();
        },
        title: "History",
      );
    }
    // else if (model.selectedIndex == 4) {
    //   return HomeAppBar(
    //     onTap: () {
    //       _scaffoldKey.currentState!.openDrawer();
    //     },
    //     title: "Markeing",
    //   );
    // }
    else {
      return Container();
    }
  }

  Widget _getCurrentPage() {
    if (model.selectedIndex == 0) {
      return  const HomeScreen();
    } else if (model.selectedIndex == 1) {
      return  const BusinessDashboardScreen();
    }
    else if (model.selectedIndex == 2) {
      return  const ProfileScreen(
        isFromDrawer: false,
      );
    } else {
      return Container();
    }
  }

  Widget markeingWidget() {
    return Container(
      color: AppColors.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                    color: AppColors.appColors, shape: BoxShape.circle),
                child: const Icon(
                  Icons.close,
                  color: AppColors.whiteColor,
                )),
          ),
          if (model.primeList.isNotEmpty)
            Expanded(
              child: MarketingPrimeScreen(
                index: 0,
                planName: model.primeList[0].planName.toString(),
                featuresList: model.primeList[0].planDetails!.toList(),
                gst: model.primeList[0].gst.toString(),
                onTap: () {
                  context.router.push(PrimePlanPurchaseScreenRoute(
                      isFromEpin: false, data: model.primeList[0]));
                },
                planAmountWithoutGst:
                    double.parse(model.primeList[0].withoutGst.toString())
                        .round()
                        .toString(),
                planamount:
                    double.parse(model.primeList[0].planAmount.toString())
                        .round()
                        .toString(),
                recomanded: false,
              ),
            )
          // Column(
          //   children:

          //   List.generate(
          //       model.primeList.isNotEmpty ? 1 : 0,
          //       (index) => MarketingPrimeScreen(
          //             index: index,
          //             planName: model.primeList[index].planName.toString(),
          //             featuresList:
          //                 model.primeList[index].planDetails!.toList(),
          //             gst: model.primeList[index].gst.toString(),
          //             onTap: () {
          //               context.router.push(PrimePlanPurchaseScreenRoute(
          //                   data: model.primeList[index]));
          //             },
          //             planAmountWithoutGst: double.parse(
          //                     model.primeList[index].withoutGst.toString())
          //                 .round()
          //                 .toString(),
          //             planamount: double.parse(
          //                     model.primeList[index].planAmount.toString())
          //                 .round()
          //                 .toString(),
          //             recomanded: false,
          //           )),
          //   // options: CarouselOptions(
          //   //   height: 680,
          //   //   enlargeCenterPage: true,
          //   //   autoPlay: false,
          //   //   autoPlayCurve: Curves.fastOutSlowIn,
          //   //   enableInfiniteScroll: true,
          //   //   autoPlayAnimationDuration: const Duration(milliseconds: 3500),
          //   //   viewportFraction: 0.8,
          //   // ),
          // ),
        ],
      ),
    );
  }

  Future<bool> onWillPop() async {
    if (model.selectedIndex == 0) {
      return await showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  AppConstString.cnfExit.tr(),
                  textScaleFactor: 1.0,
                ),
                content: Text(
                  AppConstString.conformExitText.tr(),
                  textScaleFactor: 1.0,
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      AppConstString.yes.tr(),
                      textScaleFactor: 1.0,
                    ),
                    onPressed: () {
                      //SystemNavigator.pop();
                      exit(0);
                    },
                  ),
                  TextButton(
                    child: Text(
                      AppConstString.no.tr(),
                      textScaleFactor: 1.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  )
                ],
              );
            },
          ) ??
          false;
    } else {
      setState(() {
        model.selectedIndex = 0;
      });
      return false;
    }
  }
}

class MarketingPrimeScreen extends StatelessWidget {
  final int index;
  final String planamount;
  final String planName;
  final String planAmountWithoutGst;
  final String gst;
  final VoidCallback onTap;
  final bool? recomanded;
  final List<String> featuresList;
  const MarketingPrimeScreen(
      {super.key,
      required this.planamount,
      required this.index,
      required this.planName,
      required this.planAmountWithoutGst,
      required this.gst,
      required this.featuresList,
      required this.onTap,
      this.recomanded});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,

            // color: index == 0
            //     ? AppColors.blue.withOpacity(0.2)
            //     : index == 1
            //         ? AppColors.secoundColors.withOpacity(0.2)
            //         : index == 2
            //             ? AppColors.successColor.withOpacity(0.2)
            //             : AppColors.blackColor.withOpacity(0.2),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  index == 0
                      ? AppAssets.prime555
                      : index == 1
                          ? AppAssets.prime1499
                          : index == 2
                              ? AppAssets.prime2360
                              : AppAssets.prime555,
                  height: 150,
                ),
                Text(
                  'Premium',
                  style: AppTextStyle.semiBold14,
                ),
                Text(
                  'Try Mayway Assured Savings Cashback Benefits With Guaranteed Passive Reward',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.semiBold16,
                )
                // Text(
                //   planName,
                //   style: AppTextStyle.semiBold20
                //       .copyWith(color: AppColors.blackColor),
                // ),
                // const SizedBox(
                //   height: AppSizes.size6,
                // ),
                // Text(
                //   '${AppConstString.rupeesSymbol}$planamount /-',
                //   style: AppTextStyle.bold30.copyWith(
                //       color: index == 0
                //           ? AppColors.blue
                //           : index == 1
                //               ? AppColors.secoundColors
                //               : index == 2
                //                   ? AppColors.successColor
                //                   : AppColors.blackColor
                //       // AppColors.appColors

                //       ),
                // ),
                // const SizedBox(
                //   height: AppSizes.size6,
                // ),
                // Text(
                //   'including 18% GST',
                //   style: AppTextStyle.semiBold12,
                // ),
              ],
            ),
          ),
          const SizedBox(
            height: AppSizes.size10,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         'Features',
          //         style: AppTextStyle.regular26
          //             .copyWith(color: AppColors.greyColor),
          //       ),
          //       const SizedBox(
          //         height: AppSizes.size6,
          //       ),
          //       const Divider(
          //         color: AppColors.greyColor,
          //         thickness: 2,
          //       ),
          //       const SizedBox(
          //         height: AppSizes.size10,
          //       ),
          //     ],
          //   ),
          // ),
          // Expanded(
          //   child: ListView.builder(
          //       itemCount: featuresList.length,
          //       padding: const EdgeInsets.symmetric(horizontal: 20),
          //       itemBuilder: (context, ind) {
          //         return Column(
          //           children: [
          //             Row(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               // ignore: prefer_const_literals_to_create_immutables
          //               children: [
          //                 Icon(
          //                   Icons.check_circle,
          //                   color: index == 0
          //                       ? AppColors.blue
          //                       : index == 1
          //                           ? AppColors.secoundColors
          //                           : index == 2
          //                               ? AppColors.successColor
          //                               : AppColors.blackColor,
          //                 ),
          //                 const SizedBox(
          //                   width: 15,
          //                 ),
          //                 Expanded(
          //                     child: Text(
          //                   featuresList[ind],
          //                   textScaleFactor: 1.0,
          //                 ))
          //               ],
          //             ),
          //             const SizedBox(
          //               height: AppSizes.size10,
          //             ),
          //           ],
          //         );
          //       }),
          // ),

          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: index == 0
                          ? AppColors.blue
                          : index == 1
                          ? AppColors.secoundColors
                          : index == 2
                          ? AppColors.successColor
                          : AppColors.blackColor,
                    ),
                    const SizedBox(width: 15),
                    const Flexible(
                      child: Text(
                        'Guaranteed 10% Monthly Returns',
                        textScaleFactor: 1.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: index == 0
                          ? AppColors.blue
                          : index == 1
                          ? AppColors.secoundColors
                          : index == 2
                          ? AppColors.successColor
                          : AppColors.blackColor,
                    ),
                    const SizedBox(width: 15),
                    const Flexible(
                      child: Text(
                        'Work Based on a Legally Binding Agreement',
                        textScaleFactor: 1.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: index == 0
                          ? AppColors.blue
                          : index == 1
                          ? AppColors.secoundColors
                          : index == 2
                          ? AppColors.successColor
                          : AppColors.blackColor,
                    ),
                    const SizedBox(width: 15),
                    const Flexible(
                      child: Text(
                        'A Trusted Platform Operating Since 2021 (4+ Years of Excellence)',
                        textScaleFactor: 1.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: index == 0
                          ? AppColors.blue
                          : index == 1
                          ? AppColors.secoundColors
                          : index == 2
                          ? AppColors.successColor
                          : AppColors.blackColor,
                    ),
                    const SizedBox(width: 15),
                    const Flexible(
                      child: Text(
                        'Transparency is Our Commitment',
                        textScaleFactor: 1.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: index == 0
                          ? AppColors.blue
                          : index == 1
                          ? AppColors.secoundColors
                          : index == 2
                          ? AppColors.successColor
                          : AppColors.blackColor,
                    ),
                    const SizedBox(width: 15),
                    const Flexible(
                      child: Text(
                        'Instant Referral Income for Affiliates',
                        textScaleFactor: 1.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: index == 0
                          ? AppColors.blue
                          : index == 1
                          ? AppColors.secoundColors
                          : index == 2
                          ? AppColors.successColor
                          : AppColors.blackColor,
                    ),
                    const SizedBox(width: 15),
                    const Flexible(
                      child: Text(
                        'Unlock Higher Earnings Through Team Growth',
                        textScaleFactor: 1.0,
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: index == 0
                          ? AppColors.blue
                          : index == 1
                          ? AppColors.secoundColors
                          : index == 2
                          ? AppColors.successColor
                          : AppColors.blackColor,
                    ),
                    const SizedBox(width: 15),
                    const Flexible(
                      child: Text(
                        '100% Company Safety Assurance',
                        textScaleFactor: 1.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.size10),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: PrimaryButton(
              text: 'Activate',
              onTap: (){
                context.router
                    .push(RedeemScreenRoute(isFromEwallet: true));
              },
  
            ),
          ),
          // Align(
          //   alignment: Alignment.center,
          //   child: InkWell(
          //     onTap: () {
          //       CommonMethod.referLink(
          //           referCode:
          //               GlobalSingleton.loginInfo!.data!.mobile.toString(),
          //           name:
          //               "${GlobalSingleton.loginInfo!.data!.firstName} ${GlobalSingleton.loginInfo!.data!.lastName}");
          //     },
          //     child: Text(
          //       'Refer Now',
          //       style: AppTextStyle.semiBold18
          //           .copyWith(color: AppColors.secoundColors),
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 4,
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                '48 Hrs Refund policy*',
                style: AppTextStyle.regular10,
              )),

          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
