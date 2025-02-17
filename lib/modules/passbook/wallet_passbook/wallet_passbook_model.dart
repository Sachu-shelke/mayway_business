import 'package:mayway_business/model/passbook_model/wallet_passbook_model.dart';

class WalletPassbookModel {
  List<WalletPassbookDataModelData>? walletData;
  int lastPageIndex;
  WalletPassbookModel({this.walletData, required this.lastPageIndex});
}
