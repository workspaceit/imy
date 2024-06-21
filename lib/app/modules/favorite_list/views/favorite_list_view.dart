import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/favorite_list/controllers/favorite_list_controller.dart';
import 'package:ilu/app/modules/favorite_list/views/mobile/favorite_list_mobile_ui_view.dart';
import 'package:ilu/app/modules/favorite_list/views/web/favorite_list_web_ui_view.dart';

class FavoriteListView extends StatefulWidget {
  const FavoriteListView({super.key});

  @override
  State<FavoriteListView> createState() => _FavoriteListViewState();
}

class _FavoriteListViewState extends State<FavoriteListView> {
  @override
  void initState() {
    final controller = Get.find<FavoriteListController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: FavoriteListMobileUiView(),
      desktopUI: FavoriteListWebUiView(),
    );
  }
}
