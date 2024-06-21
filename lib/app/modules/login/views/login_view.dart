import 'package:flutter/material.dart';
import 'package:ilu/app/core/layout/base_layout.dart';
import 'package:ilu/app/modules/login/views/mobile/login_mobile_ui_view.dart';
import 'package:ilu/app/modules/login/views/web/login_web_ui_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final loginMobileFormKey = GlobalKey<FormState>();
  final loginWebFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BaseLayout(
      mobileUI: LoginMobileUiView(loginMobileFormKey: loginMobileFormKey),
      desktopUI: LoginWebUiView(loginWebFormKey: loginWebFormKey),
    );
  }
}
