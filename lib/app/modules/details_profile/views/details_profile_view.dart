import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/details_profile/controllers/details_profile_controller.dart';
import 'package:ilu/app/modules/details_profile/views/mobile/details_profile_mobile_view.dart';
import 'package:ilu/app/modules/details_profile/views/web/details_profile_web_view.dart';

class DetailsProfileView extends StatefulWidget {
  const DetailsProfileView({super.key});

  @override
  State<DetailsProfileView> createState() => _DetailsProfileViewState();
}

class _DetailsProfileViewState extends State<DetailsProfileView> {

  @override
  void initState() {
    final controller = Get.find<DetailsProfileController>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getCurrentUserData();
      controller.userDetailsData(id: controller.repo.apiService.sharedPreferences.getInt(LocalStorageHelper.detailsProfileUserIdKey) ?? -1);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: DetailsProfileMobileView(),
      desktopUI: DetailsProfileWebView(),
    );
  }
}
