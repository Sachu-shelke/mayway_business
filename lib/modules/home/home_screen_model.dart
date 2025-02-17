import 'package:mayway_business/model/banner_model/banner_model.dart';
import 'package:mayway_business/model/company/user_graph_model.dart';
import 'package:mayway_business/model/graphics/get_graphics_main_model.dart';
import 'package:mayway_business/model/graphics/get_graphics_model.dart' as ge;
import 'package:mayway_business/model/home_model/get_categories_model.dart';
import 'package:mayway_business/model/home_model/rank_details_count_model.dart';
import 'package:mayway_business/model/notification/notification_model.dart';
import 'package:mayway_business/model/recent_screen_model.dart';
import 'package:mayway_business/model/team_details/team_details_info_model.dart';

class HomeScreenModel {
  ge.GetGraphicsCategoryModel graphicsList;
  TeamDetailsInfoModel todayData;
  List todayList;
  List<CategoriesResponse>? leadsList;
  GetRankDetailsModel silverDetailsResponse;
  List<BannerList>? bennerApiList;
  List<CompanyGraphData> graphData;
  Map<String, double>? dataMaps;
  int selectedGraphData;
  List<RecentAppUseData> rechargeServiceList;
  List<GraphicsMainData> graphicsdata;
  List<NotificationData> notificationdata;
  List categoriesIdList;
  List mirrorConnectList;
  int tabindex;
  num todayIncome;
  num totalEarning;
  num totalRemaining;
  String tabelName;

  HomeScreenModel({
    required this.graphicsList,
    required this.leadsList,
    required this.tabindex,
    required this.todayIncome,
    required this.totalEarning,
    required this.totalRemaining,
    required this.todayData,
    required this.selectedGraphData,
    required this.categoriesIdList,
    required this.notificationdata,
    required this.graphicsdata,
    required this.rechargeServiceList,
    required this.todayList,
    required this.mirrorConnectList,
    required this.graphData,
    required this.silverDetailsResponse,
    required this.tabelName,
  }) {
    dataMaps = {
      "Total Earnings": totalEarning.toDouble(),  // Convert explicitly
      "Total Remaining": totalRemaining.toDouble(),  // Convert explicitly
    };
  }


}
