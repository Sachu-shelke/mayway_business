import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mayway_business/config/routes/router_import.gr.dart';
import 'package:mayway_business/config/theme/app_colors.dart';
import 'package:mayway_business/config/theme/app_text_style.dart';
import 'package:mayway_business/constants/app_sizes.dart';
import 'package:mayway_business/modules/business/business_dashboard/business_dashboard_model.dart';
import 'package:mayway_business/modules/business/business_dashboard/business_dashboard_presenter.dart';
import 'package:mayway_business/modules/business/business_widget/user_business_details.dart';

class MyPortfolio extends StatefulWidget {
  final BusinessDashboardModel model;
  final BasicBusinessDashboardPresenter presenter;
  const MyPortfolio({
    super.key,
    required this.model,
    required this.presenter,
  });

  @override
  State<MyPortfolio> createState() => _MyPortfolioState();
}

class _MyPortfolioState extends State<MyPortfolio> {
  @override
  void initState() {
    super.initState();
    // Set "All" as the default selection when the screen loads
    widget.model.selectedDasboardButtonIndex = 0;
    widget.presenter.getDashBoardData(catId: 0);  // Fetch default data
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        UserBusinessDetails(
          model: widget.model,
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Expanded(
                  child: dashboardButton(
                      title: 'All',
                      isselected: widget.model.selectedDasboardButtonIndex == 0,
                      onTap: () {
                        widget.model.selectedDasboardButtonIndex = 0;
                        widget.presenter.getDashBoardData(catId: 0);
                        // setState(() {});
                      })),
              const SizedBox(
                width: AppSizes.size6,
              ),
              Expanded(
                  child: dashboardButton(
                      title: 'Earning',
                      isselected: widget.model.selectedDasboardButtonIndex == 1,
                      onTap: () {
                        widget.model.selectedDasboardButtonIndex = 1;
                        widget.presenter.getDashBoardData(catId: 1);

                        // setState(() {});
                      })),
              const SizedBox(
                width: AppSizes.size6,
              ),
              Expanded(
                  child: dashboardButton(
                      title: 'Team',
                      isselected: widget.model.selectedDasboardButtonIndex == 2,
                      onTap: () {
                        widget.model.selectedDasboardButtonIndex = 2;
                        widget.presenter.getDashBoardData(catId: 2);

                        // setState(() {});
                      })),
              const SizedBox(
                width: AppSizes.size6,
              ),
              Expanded(
                child: dashboardButton(
                    title: 'Salary',
                    isselected: widget.model.selectedDasboardButtonIndex == 3,
                    onTap: () {
                      widget.model.selectedDasboardButtonIndex = 3;
                      widget.presenter.getDashBoardData(catId: 3);
                      // setState(() {});
                    }),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          child: SizedBox(
            // height: (widget.model.filteredincomeList.length) * 58,
            child: GridView.builder(
              itemCount: widget.model.filteredincomeList.length,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.9,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (index == 2 || index == 3 ) {
                      context.router.pushNamed(
                          widget.model.filteredincomeList[index].path.toString());
                      // context.router.push(IncomePassbookScreenRoute(
                      //     isFromDrawer: true, filter: 'Self'));
                      // context.router.push(PrimeTeamScreenRoute(
                      //     planName: widget.model.filteredincomeList[index].name,
                      //     planId: widget.model.filteredincomeList[index].id!));
                    } else if (index == 0) {
                      context.router.push(IncomePassbookScreenRoute(
                          isFromDrawer: true, filter: null));
                    } else if (index == 1) {
                      context.router
                          .push(RedeemScreenRoute(isFromEwallet: false));
                    } else if (index == 6) {
                      context.router.push(IncomePassbookScreenRoute(
                          isFromDrawer: true, filter: 'Self Income'));
                    } else if (index == 7) {
                      context.router.push(IncomePassbookScreenRoute(
                          isFromDrawer: true, filter: 'Repurchase'));
                    } else if (index == 8) {
                      context.router.push(IncomePassbookScreenRoute(
                          isFromDrawer: true, filter: 'Level Income'));
                    } else if (index == 9) {
                      context.router.push(IncomePassbookScreenRoute(
                          isFromDrawer: true, filter: 'Upgrade'));
                    } else if (index == 10) {
                      context.router.push(IncomePassbookScreenRoute(
                        isFromDrawer: true,
                      ));
                    } else if (index == 3) {
                      context.router.push(IncomePassbookScreenRoute(
                        isFromDrawer: true,
                      ));
                    } else if (index == 12) {
                      context.router.push(IncomePassbookScreenRoute(
                        isFromDrawer: true,
                      ));
                    } else if (index == 13) {
                      context.router.push(IncomePassbookScreenRoute(
                        isFromDrawer: true,
                      ));
                    } else if (index == 14) {
                      context.router.push(IncomePassbookScreenRoute(
                        isFromDrawer: true,
                      ));
                    } else if (index == 15) {
                      context.router.push(IncomePassbookScreenRoute(
                        isFromDrawer: true,
                      ));
                    } else if (index == 16) {
                      context.router.push(IncomePassbookScreenRoute(
                        isFromDrawer: true,
                      ));
                    } else if (index == 17) {
                      context.router.push(IncomePassbookScreenRoute(
                        isFromDrawer: true,
                      ));
                    } else if (index == 18) {
                      context.router.push(IncomePassbookScreenRoute(
                        isFromDrawer: true,
                      ));
                    } else if (index == 19) {
                      context.router.push(IncomePassbookScreenRoute(
                        isFromDrawer: true,
                      ));
                    } else {
                      context.router.push(IncomePassbookScreenRoute(
                        isFromDrawer: true,
                      ));
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: AppColors.blueCircleGradient,
                      // color: ,
                      border: Border.all(
                          color: widget.model.filteredincomeList[index].color ??
                              Colors.transparent,
                          width: 3),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 4,
                            offset: Offset(1, 2),
                            color: AppColors.containerShaddowbg,
                            spreadRadius: 2)
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50), // Circular shape
                              ),
                              elevation: 4, // Optional: Adds shadow effect
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                  widget.model.filteredincomeList[index].image.toString(),
                                  height: MediaQuery.of(context).size.width > 400 ? 35 : 25,
                                  width: MediaQuery.of(context).size.width > 400 ? 35 : 25,
                                ),
                              ),
                            ),

                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  widget.model.filteredincomeList[index].income,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,color: Colors.white,fontSize:22,
                                    shadows: [
                                    Shadow(
                                    color: Colors.black45, // Shadow color
                                    blurRadius: 4,       // Softness of the shadow
                                    offset: Offset(2, 2), // X and Y offset
                                  ),
                                  ],
                                  )
                                  // AppTextStyle.light10
                                  //     .copyWith(fontWeight: FontWeight.w600),
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,

                              //   children: [
                              //     // if (widget.model.filteredincomeList[index]
                              //     //         .color !=
                              //     //     null)
                              //     //   Container(
                              //     //     height: 20,
                              //     //     width: 20,
                              //     //     decoration: BoxDecoration(
                              //     //       shape: BoxShape.circle,
                              //     //       color: widget.model
                              //     //           .filteredincomeList[index].color,
                              //     //     ),
                              //     //   ),
                              //     if (widget.model.filteredincomeList[index]
                              //             .color !=
                              //         null)
                              //       const SizedBox(
                              //         width: AppSizes.size6,
                              //       ),
                              //     Text(
                              //       widget.model.filteredincomeList[index].income,
                              //       style: AppTextStyle.black20
                              //           .copyWith(fontWeight: FontWeight.w600),
                              //     ),
                              //     const SizedBox(
                              //       height: AppSizes.size10,
                              //     ),
                              //   ],
                              // ),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              widget.model.filteredincomeList[index].name,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                shadows: [
                                  Shadow(
                                    color: Colors.black, // Shadow color
                                    blurRadius: 4,       // Softness of the shadow
                                    offset: Offset(2, 1), // X and Y offset
                                  ),
                                ],
                              ),
                            ),
                          ),]

                        ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        )
      ],
    );
  }

  Widget dashboardButton(
      {final Function()? onTap,
      required bool isselected,
      required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: AppSizes.size50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: isselected == true ? AppColors.circleGradient : null,
            color: isselected == false ? Colors.white : null,
            borderRadius: BorderRadius.circular(AppSizes.size14),
            border: Border.all(
                color: isselected == false
                    ? AppColors.appColors
                    : Colors.transparent)),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: AppTextStyle.semiBold18.copyWith(
              color: isselected == false
                  ? AppColors.appColors
                  : AppColors.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
