import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/block_list/controllers/block_list_controller.dart';
import 'package:ilu/app/modules/block_list/views/mobile/block_list_mobile_view.dart';
import 'package:ilu/app/modules/block_list/views/web/block_list_web_view.dart';

class BlockListView extends StatefulWidget {
  const BlockListView({super.key});

  @override
  State<BlockListView> createState() => _BlockListViewState();
}

class _BlockListViewState extends State<BlockListView> {

  @override
  void initState() {
    final controller = Get.find<BlockListController>();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.initialState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const BaseLayout(
      mobileUI: BlockListMobileView(),
      desktopUI: BlockListWebView(),
    );
  }
}
