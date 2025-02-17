// import 'package:flutter/material.dart';
// import 'package:mayway_business/model/team_details/team_details_info_model.dart';
// import 'package:mayway_business/modules/business/business_team/prime_team_level/prime_team_level_model.dart';
// import 'package:mayway_business/modules/business/business_team/prime_team_level/prime_team_level_view.dart';
// import 'package:mayway_business/utils/api_path.dart';
// import 'package:mayway_business/utils/encrypted_api_path.dart';
// import 'package:mayway_business/utils/network/network_dio.dart';
//
// class PrimeTeamLevelPresenter {
//   Future<void> getTeamDetails({
//     required String userID,
//     required String level,
//     required String primeId,
//     required int page,
//     required BuildContext context,
//   }) async {}
//   set updateView(PrimeTeamLevelView primeTeamLevelView) {}
// }
//
// class BasicPrimeTeamLevelPresenter implements PrimeTeamLevelPresenter {
//   late PrimeTeamLevelModel model;
//   late PrimeTeamLevelView view;
//
//   BasicPrimeTeamLevelPresenter() {
//     view = PrimeTeamLevelView();
//     model = PrimeTeamLevelModel(teamDetailsdata: []);
//   }
//
//   @override
//   Future<void> getTeamDetails({
//     required String userID,
//     required String level,
//     required String primeId,
//     required BuildContext context,
//     required int page,
//   }) async {
//     // Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
//     //   url: ApiPath.apiEndPoint + EncryptedApiPath.getTeamDeatils,
//     //   context: context,
//     //   data: {
//     //     'user_id': userID,
//     //     'teamType': primeId,
//     //     'level': level,
//     //     'plan_id': primeId,
//     //     'page': page
//     //   },
//     // );
//     // if (response != null && response['status'] == 200) {
//     //   if (page == 1) {
//     //     model.teamDetailsdata = TeamDetailsInfoModel.fromJson(response).data!;
//     //   } else {
//     //     model.teamDetailsdata
//     //         .addAll(TeamDetailsInfoModel.fromJson(response).data!);
//     //   }
//     //
//     //   view.refreshModel(model);
//     // }
//     Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
//       url: ApiPath.apiEndPoint + EncryptedApiPath.getTeamDeatils,
//       context: context,
//       data: {
//         'user_id': userID,
//         'teamType': primeId,
//         'level': level,
//         'plan_id': primeId,
//         'page': page
//       },
//     );
//
//     if (response != null) {
//       // Print the entire response
//       print("Response: $response");
//
//       // Check if 'status' exists and is 200
//       if (response['status'] == 200) {
//         // Print out the status and the team details
//         print("Status: ${response['status']}");
//
//         // Handle the team details based on page number
//         if (page == 1) {
//           if (response['data'] != null) {
//             model.teamDetailsdata = TeamDetailsInfoModel.fromJson(response).data!;
//             print("Team details (Page 1): ${model.teamDetailsdata}");
//           } else {
//             print("Team data is null for Page 1");
//           }
//         } else {
//           if (response['data'] != null) {
//             model.teamDetailsdata.addAll(TeamDetailsInfoModel.fromJson(response).data!);
//             print("Added more team details for Page $page: ${model.teamDetailsdata}");
//           } else {
//             print("Team data is null for Page $page");
//           }
//         }
//
//         view.refreshModel(model);
//       } else {
//         print("Response status is not 200: ${response['status']}");
//       }
//     } else {
//       print("Response is null");
//     }
//
//   }
//
//   @override
//   set updateView(PrimeTeamLevelView primeTeamView) {
//     view = primeTeamView;
//     view.refreshModel(model);
//   }
// }
import 'package:flutter/material.dart';
import 'package:mayway_business/model/team_details/team_details_info_model.dart';
import 'package:mayway_business/modules/business/business_team/prime_team_level/prime_team_level_model.dart';
import 'package:mayway_business/modules/business/business_team/prime_team_level/prime_team_level_view.dart';
import 'package:mayway_business/utils/api_path.dart';
import 'package:mayway_business/utils/encrypted_api_path.dart';
import 'package:mayway_business/utils/network/network_dio.dart';

class PrimeTeamLevelPresenter {
  Future<void> getTeamDetails({
    required String userID,
    required String level,
    required String primeId,
    required int page,
    required BuildContext context,
  }) async {}

  set updateView(PrimeTeamLevelView primeTeamLevelView) {}
}

class BasicPrimeTeamLevelPresenter implements PrimeTeamLevelPresenter {
  late PrimeTeamLevelModel model;
  late PrimeTeamLevelView view;

  BasicPrimeTeamLevelPresenter() {
    view = PrimeTeamLevelView();
    model = PrimeTeamLevelModel(teamDetailsdata: []);
  }

  @override
  Future<void> getTeamDetails({
    required String userID,
    required String level,
    required String primeId,
    required BuildContext context,
    required int page,
  }) async {
    try {
      Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
        url: ApiPath.apiEndPoint + EncryptedApiPath.getTeamDeatils,
        context: context,
        data: {
          'user_id': userID,
          'teamType': primeId,
          'level': level,
          'plan_id': primeId,
          'page': page
        },
      );

      if (response != null) {
        print("Response: $response");

        if (response['status'] == 200) {
          print("Status: ${response['status']}");

          if (page == 1) {
            if (response['data'] != null) {
              model.teamDetailsdata = TeamDetailsInfoModel.fromJson(response).data!;
              print("Team details (Page 1): ${model.teamDetailsdata}");
            } else {
              print("Team data is null for Page 1");
            }
          } else {
            if (response['data'] != null) {
              model.teamDetailsdata.addAll(TeamDetailsInfoModel.fromJson(response).data!);
              print("Added more team details for Page $page: ${model.teamDetailsdata}");
            } else {
              print("Team data is null for Page $page");
            }
          }

          view.refreshModel(model);
        } else {
          print("Response status is not 200: ${response['status']}");
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Failed to load team details")),
          );
        }
      } else {
        print("Response is null");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to get a valid response")),
        );
      }
    } catch (e) {
      print("Error occurred: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred while fetching data")),
      );
    }
  }

  @override
  set updateView(PrimeTeamLevelView primeTeamLevelView) {
    view = primeTeamLevelView;
    view.refreshModel(model);
  }
}
