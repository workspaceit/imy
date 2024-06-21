import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ilu/app/core/constants/device_size_constant.dart';

class BaseLayout extends StatelessWidget {
  final Widget? mobileUI;
  final Widget? desktopUI;

  const BaseLayout({this.mobileUI, this.desktopUI, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileWidth && (defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS)) {
          return mobileUI!;
        }
        else {
          return desktopUI!;
        }
      },
    );
  }
}
