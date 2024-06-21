import 'dart:async';

import 'package:get/get.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  SplashController();

  // ------------------ initial stage method ----------------
  void initialStage(){
    manageSession();
    update();
  }

  // ----------------- session manage method -------------------
  manageSession() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString(LocalStorageHelper.accessTokenKey);
    if (accessToken != null && accessToken.isNotEmpty && accessToken != "") {


      Timer(const Duration(seconds: 3),
              () => Get.offAllNamed(Routes.HOME)
      );


    } else {
      Timer(const Duration(seconds: 3),
              () => Get.offAllNamed(Routes.LOGIN)
      );
    }
  }
}
