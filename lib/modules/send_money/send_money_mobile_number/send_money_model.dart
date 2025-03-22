import 'package:mayway_business/model/auth_model/login_model.dart';
import 'package:mayway_business/model/recharge_model/recent_recharge_model.dart';

class SendMoneyScreenModel {
  LoginData userDetails;
  List<RecentRechargeData> recentSendMoneyList;
  SendMoneyScreenModel(
      {required this.recentSendMoneyList, required this.userDetails});
}
