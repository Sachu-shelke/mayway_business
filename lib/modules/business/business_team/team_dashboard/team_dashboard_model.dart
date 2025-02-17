import 'package:mayway_business/model/team_details/team_details_model.dart';
import 'package:mayway_business/modules/business/business_dashboard/business_dashboard_model.dart';

class TeamDashboardModel {
  List<DashboardIncomeList> incomeList;
  TeamDetailsModel? teamDetails;
  TeamDashboardModel({
    required this.incomeList,
    this.teamDetails,
  });
}
