import 'package:flutter/material.dart';
import 'package:mayway_business/model/passbook_model/wallet_passbook_model.dart';
import 'package:intl/intl.dart';
import 'package:mayway_business/config/theme/app_colors.dart';
import 'package:mayway_business/config/theme/app_text_style.dart';
import 'package:mayway_business/constants/app_const_assets.dart';
import 'package:mayway_business/constants/app_const_text.dart';
import 'package:mayway_business/constants/common_style.dart';
import 'package:mayway_business/constants/extension/date_time.dart';
import 'package:mayway_business/utils/api_path.dart';

class PassbookCommonWidget extends StatefulWidget {
  final WalletPassbookDataModelData walletData;
  final bool? isEpinWallet;

  const PassbookCommonWidget({
    super.key,
    this.isEpinWallet,
    required this.walletData,
  });

  @override
  State<PassbookCommonWidget> createState() => _PassbookCommonWidgetState();
}

class _PassbookCommonWidgetState extends State<PassbookCommonWidget> {
  String getRechargeAmount(
      {required String mainAmount, required String cashbackAmount}) {
    final amt = ((double.parse(mainAmount) - double.parse(cashbackAmount))
        .toStringAsFixed(2));
    return amt.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      margin: widget.isEpinWallet == true
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: CommonStyleDecoration.serviceBoxDecoration(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Order No #${widget.isEpinWallet == true ? widget.walletData.transactionId : widget.walletData.referenceNo}',
                    style: AppTextStyle.semiBold14,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  widget.isEpinWallet == true
                      ? widget.walletData.createdOn!
                      : DateFormat("dd-MM-yyyy hh:mm")
                      .parse(widget.walletData.createdOn!)
                      .toString()
                      .getDateTime,
                  style:
                  AppTextStyle.semiBold12.copyWith(color: AppColors.greyColor),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Divider(color: AppColors.greyColor),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: widget.walletData.operatorImage != null &&
                    widget.walletData.operatorImage!.isNotEmpty
                    ? Image.network(
                  ApiPath.bucketUrl + widget.walletData.operatorImage!,
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      AppAssets.appLogo,
                      height: 40,
                      width: 40,
                      fit: BoxFit.cover,
                    );
                  },
                )
                    : Image.asset(
                  AppAssets.appLogo,
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                (widget.walletData.rechargeType == 'DTH'
                                    ? "DTH "
                                    : "") +
                                    widget.walletData.tranFor.toString() +
                                    (widget.walletData.planName != null
                                        ? ' ${widget.walletData.planName}'
                                        : ''),
                                style: AppTextStyle.semiBold18,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              if (widget.walletData.tranFor == 'Recharge') ...[
                                Text(
                                  'Number: ${widget.walletData.consumerNumber} | ${widget.walletData.operator} |',
                                  style: AppTextStyle.regular16.copyWith(
                                    color: AppColors.blackColor,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Amount: ${widget.walletData.mainAmount}',
                                        style: AppTextStyle.regular16.copyWith(
                                          color: AppColors.blackColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    if (widget.walletData.rechargeStatus != null)
                                      Text(
                                        widget.walletData.rechargeStatus
                                            .toString(),
                                        style: AppTextStyle.semiBold14.copyWith(
                                          fontWeight: FontWeight.w400,
                                          color: widget.walletData.rechargeStatus ==
                                              "SUCCESS"
                                              ? AppColors.successColor
                                              : widget.walletData
                                              .rechargeStatus ==
                                              "PROCESS"
                                              ? Colors.orange.shade600
                                              : AppColors.errorColor,
                                        ),
                                      ),
                                  ],
                                ),
                                if (widget.walletData.traxId != null)
                                  Text(
                                    'Trax Id: ${widget.walletData.traxId}',
                                    style: AppTextStyle.regular16.copyWith(
                                      color: AppColors.blackColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        Column(
                          children: [
                            Text(
                              '${AppConstString.rupeesSymbol}${widget.walletData.type == "Credit" ? widget.walletData.credit : widget.walletData.debit}',
                              style: AppTextStyle.semiBold18.copyWith(
                                fontWeight: FontWeight.w400,
                                color: widget.walletData.type == "Credit"
                                    ? AppColors.successColor
                                    : AppColors.errorColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(
                          widget.walletData.type.toString(),
                          style: AppTextStyle.semiBold16.copyWith(
                            fontWeight: FontWeight.w400,
                            color: widget.walletData.type == "Credit"
                                ? AppColors.successColor
                                : AppColors.errorColor,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'OB : ${AppConstString.rupeesSymbol}${widget.walletData.openingBalance}',
                            style: AppTextStyle.semiBold14.copyWith(
                              color: AppColors.greyColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'CB : ${AppConstString.rupeesSymbol}${widget.walletData.closingBalance}',
                            style: AppTextStyle.semiBold14.copyWith(
                              color: AppColors.greyColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
