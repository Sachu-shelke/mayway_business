import 'package:mayway_business/model/auth_model/login_model.dart';
import 'package:mayway_business/model/passbook_model/wallet_passbook_model.dart';
import 'package:mayway_business/model/redeem/redeem_history_model.dart';
import 'package:mayway_business/model/team_details/team_details_model.dart';

class RedeemModel {
  TeamDetailsData teamDetailsData;
  List<RedeemHistorData> historyData;
  List<WalletPassbookDataModelData> epinHisoryModel;
  LoginData userDetails;
  bool isButtonTap;
  RedeemModel(
      {required this.teamDetailsData,
      required this.isButtonTap,
      required this.epinHisoryModel,
      required this.userDetails,
      required this.historyData});
}
