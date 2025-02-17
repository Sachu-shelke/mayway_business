import 'package:flutter/material.dart';
import 'package:mayway_business/config/manager/global_singleton.dart';
import 'package:mayway_business/config/routes/router_import.gr.dart';
import 'package:mayway_business/main.dart';
import 'package:mayway_business/model/base_model/base_model.dart';
import 'package:mayway_business/modules/data_uploading/data_uploading_model.dart';
import 'package:mayway_business/modules/data_uploading/data_uploading_view.dart';
import 'package:mayway_business/utils/api_path.dart';
import 'package:mayway_business/utils/encrypted_api_path.dart';
import 'package:mayway_business/utils/network/network_dio.dart';

class DataUploadingPresenter {
  Future<void> getBackupData({required BuildContext context}) async {}
  set updateView(DataUploadingView incomePassbookView) {}
}

class BasicDataUploadingPresenter implements DataUploadingPresenter {
  late DataUploadingView view;
  late DataUploadingModel model;
  BasicDataUploadingPresenter() {
    view = DataUploadingView();
    model = DataUploadingModel();
  }

  @override
  Future<void> getBackupData({required BuildContext context}) async {
    Map<String, dynamic>? response = await NetworkDio.postDioHttpMethod(
      url: ApiPath.apiEndPoint + EncryptedApiPath.dataBackup,
      data: {
        'mrid': GlobalSingleton.loginInfo!.data!.mlmId.toString(),
        'user_id': GlobalSingleton.loginInfo!.data!.id.toString()
      },
      // context: context
    );

    if (response != null && response['status'] == 200) {
      BaseModel mod = BaseModel.fromJson(response);
      if (mod.data == true) {
        appRouter
            .pushAndPopUntil(
              MainHomeScreenRoute(),
              predicate: (route) => false,
            )
            .then((value) {});
        //  context.router.push(const MainHomeScreenRoute());
      } else {}
      // view.refreshModel(model);
    }
  }

  @override
  set updateView(DataUploadingView incomePassbookView) {
    view = incomePassbookView;
    view.refreshModel(model);
  }
}
