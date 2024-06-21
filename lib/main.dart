import 'dart:convert';
import 'package:api_service_interceptor/api_service_interceptor.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/constants/locale_constant.dart';
import 'package:ilu/app/core/di/dependency_injection.dart';
import 'package:ilu/app/core/global/initial_binding.dart';
import 'package:ilu/app/core/language/languages.dart';
import 'package:ilu/app/core/utils/app_colors.dart';
import 'package:ilu/app/core/utils/app_images.dart';
import 'package:ilu/app/core/utils/app_text_style.dart';
import 'package:ilu/app/core/utils/app_utils.dart';
import 'package:ilu/app/routes/app_pages.dart';
import 'package:ilu/app/widgets/dialog/custom_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/core/global/api_url_container.dart';
import 'app/core/helper/local_storage_helper.dart';
import 'app/core/utils/agora_settings.dart';
import 'app/core/utils/local_notification_service.dart';
import 'app/models/details_profile/details_profile_response_model.dart';
import 'firebase_options.dart';

//receive message in background
Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("---------- Handling a background message: ${message.messageId}");
}

void main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      statusBarColor: AppColors.colorWhite,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.colorWhite,
      systemNavigationBarIconBrightness: Brightness.dark));

  await DependencyInjection.initDependency();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _message = '';
  String fcmToken = '';
  Map<String, dynamic> deviceData = <String, dynamic>{};
  final AudioPlayer audioPlayer = AudioPlayer();
  @override
  void initState() {
    if (kIsWeb) {
      requestNotificationPermission();
    }
    _registerOnFirebase();
    if (!kIsWeb) {
      LocalNotificationService.intialize(context);
    }

    /// ------------------ gives the message
    /// ------------------ open app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message?.notification != null) {
        if (message?.notification != null) {
          final routeFromMessage = message?.data["data"];
          print("Data--- $routeFromMessage");
          final routeFromMessageBody = message?.data["body"];
          print("routeFromMessageBody----$routeFromMessageBody");
        }
      }
    });

    /// ----------------------- foreground state
    FirebaseMessaging.onMessage.listen((message) async {
      if (kIsWeb) {
        if (message.notification != null) {
          final notificationType = message.data["notification_type"];
          AppUtils.webNotificationMessage(
              title: message.notification?.title ?? "imy",
              message: message.notification?.body ?? "");

          if (notificationType == 'call') {
            AgoraConfig.agoraAudioChannelName = message.data["channel_name"];
            AgoraConfig.agoraToken = message.data["token"];
            var toId = message.data["fromId"];
            await userDetailsData(
              id: toId.toString(),
              token: message.data["token"],
              channelName: message.data["channel_name"],
            );
          }
        }
      } else {
        if (message.notification != null) {
          LocalNotificationService.displayNotification(message);

          final notificationType = message.data["notification_type"];

          if (notificationType == 'call') {
            final notificationType = message.data["notification_type"];
            AgoraConfig.agoraAudioChannelName = message.data["channel_name"];
            AgoraConfig.agoraToken = message.data["token"];
            var toId = message.data["fromId"];
            await userDetailsData(
              id: toId.toString(),
              token: message.data["token"],
              channelName: message.data["channel_name"],
            );
          }
        }
      }
    });

    /// ----------------- app is in background but opened and user taps
    /// ----------------- on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      if (kIsWeb) {
        final routeFromMessage = message.data["data"];
        print("Data--- $routeFromMessage");
        final routeFromMessageBody = message.data["body"];
        print("background----$routeFromMessageBody");

        final notificationype = message.data["notification_type"];
        print("foreground----$notificationype");

        if (notificationype == 'chat') {
          Get.offAllNamed(Routes.HOME);
        }

        if (notificationype == 'call') {
          AgoraConfig.agoraAudioChannelName = message.data["channel_name"];
          AgoraConfig.agoraToken = message.data["token"];
          var toId = message.data["fromId"];
          await userDetailsData(
            id: toId.toString(),
            token: message.data["token"],
            channelName: message.data["channel_name"],
          );
        }
      } else {
        final routeFromMessage = message.data["data"];
        print("Data--- $routeFromMessage");
        final routeFromMessageBody = message.data["body"];
        print("background----$routeFromMessageBody");

        final notificationype = message.data["notification_type"];
        print("foreground----$notificationype");

        if (notificationype == 'chat') {
          Get.offAllNamed(Routes.HOME);
        }

        if (notificationype == 'call') {
          final notificationType = message.data["notification_type"];
          AgoraConfig.agoraAudioChannelName = message.data["channel_name"];
          AgoraConfig.agoraToken = message.data["token"];
          var toId = message.data["fromId"];
          await userDetailsData(
            id: toId.toString(),
            token: message.data["token"],
            channelName: message.data["channel_name"],
          );
        }
      }
    });
    super.initState();
  }

  void requestNotificationPermission() async {
    try {
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        print('User granted permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        print('User granted provisional permission');
      } else {
        print('User declined or has not accepted permission');
      }
    } catch (e) {
      print('------------- Error during notification permission request: $e');
    }
  }

  List<ProfileImage> profileImages = [];

  void playRingtone() async {
    await audioPlayer.setSource(AssetSource('ringtone/incoming_call.mp3'));
    audioPlayer.play(AssetSource('ringtone/incoming_call.mp3'));
  }

  Future<void> userDetailsData(
      {required String id,
      required String token,
      required String channelName}) async {
    profileImages.clear();

    ApiResponseModel responseModel = await getUserDetails(id: id);

    if (responseModel.statusCode == 200) {
      DetailsProfileResponseModel receiverUserInfo =
          DetailsProfileResponseModel.fromJson(
              jsonDecode(responseModel.responseJson));
      var username =
          "${receiverUserInfo.firstName ?? ""} ${receiverUserInfo.lastName ?? ""}";
      var userId = receiverUserInfo.id ?? "";

      List<ProfileImage>? tempList = receiverUserInfo.profileImage;
      if (tempList != null && tempList.isNotEmpty) {
        profileImages.addAll(tempList);
      }

      var userProfileImage = '';
      if (profileImages.isEmpty) {
      } else {
        var userProfileImage =
            "${ApiUrlContainer.baseUrl}${profileImages[0].file}";
      }
      playRingtone();

      /// --------------- call receive and decline bottom sheet
      kIsWeb
          ? showDialog(
              context: Get.context!,
              builder: (_) => CustomDialog(
                    width: 400,
                    dialogChild: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// ------------------ calling user image
                        userProfileImage.isEmpty
                            ? Container(
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(AppImages.iluImage))),
                              )
                            : CachedNetworkImage(
                                imageUrl: userProfileImage,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider)),
                                    )),
                        const Gap(12),

                        /// ------------------ calling user name
                        Text(
                          username,
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkA,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        const Gap(32),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// -------------- receive call
                              InkWell(
                                hoverColor: AppColors.colorWhite,
                                borderRadius: BorderRadius.circular(100),
                                onTap: () async {
                                  audioPlayer.stop();
                                  Get.back();
                                  var ff = await getConversationID(
                                      int.parse(userId.toString()));
                                  Get.toNamed(Routes.AUDIO_CALL, arguments: [
                                    ff,
                                    userProfileImage,
                                  ]);
                                },
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.colorGreen),
                                  child: const Icon(Icons.call,
                                      color: AppColors.colorWhite, size: 24),
                                ),
                              ),

                              /// -------------- decline call
                              InkWell(
                                hoverColor: AppColors.colorWhite,
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  audioPlayer.stop();
                                  Get.back();
                                },
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  child: const Icon(Icons.call_end,
                                      color: AppColors.colorWhite, size: 24),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ))
          : showModalBottomSheet(
              context: Get.context!,
              isScrollControlled: false,
              backgroundColor: AppColors.colorWhite,
              constraints: const BoxConstraints(maxHeight: 300),
              builder: (_) => Container(
                    width: Get.width,
                    alignment: Alignment.center,
                    padding: const EdgeInsetsDirectional.symmetric(
                        horizontal: 24, vertical: 20),
                    decoration: const BoxDecoration(
                        color: AppColors.colorWhite,
                        borderRadius: BorderRadiusDirectional.vertical(
                            top: Radius.circular(16))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// ------------------ calling user image
                        userProfileImage.isEmpty
                            ? Container(
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: AssetImage(AppImages.iluImage))),
                              )
                            : CachedNetworkImage(
                                imageUrl: userProfileImage,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: imageProvider)),
                                    )),
                        const Gap(12),

                        /// ------------------ calling user name
                        Text(
                          username,
                          style: AppTextStyle.appTextStyle(
                              textColor: AppColors.colorDarkA,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        const Gap(32),
                        Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              horizontal: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              /// -------------- receive call
                              InkWell(
                                hoverColor: AppColors.colorWhite,
                                borderRadius: BorderRadius.circular(100),
                                onTap: () async {
                                  Get.back();
                                  audioPlayer.stop();
                                  var ff = await getConversationID(
                                      int.parse(userId.toString()));
                                  Get.toNamed(Routes.AUDIO_CALL, arguments: [
                                    ff,
                                    userProfileImage,
                                  ]);
                                },
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.colorGreen),
                                  child: const Icon(Icons.call,
                                      color: AppColors.colorWhite, size: 24),
                                ),
                              ),

                              /// -------------- decline call
                              InkWell(
                                hoverColor: AppColors.colorWhite,
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  audioPlayer.stop();
                                  Get.back();
                                },
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  child: const Icon(Icons.call_end,
                                      color: AppColors.colorWhite, size: 24),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
    } else if (responseModel.statusCode == 401 ||
        responseModel.statusCode == 403) {
      Get.offAllNamed(Routes.LOGIN);
    } else {}
  }

  Future<String> getConversationID(int id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int currentUserId =
        sharedPreferences.getInt(LocalStorageHelper.idOfCurrentUserKey) ?? 0;

    if (currentUserId.hashCode <= id.hashCode) {
      return "${currentUserId}_$id";
    } else {
      return "${id}_$currentUserId";
    }
  }

  Future<ApiResponseModel> getUserDetails({required String id}) async {
    String url =
        "${ApiUrlContainer.baseUrl}${ApiUrlContainer.getUserDetailsEndPoint}$id/";
    print("--------------- url: $url");

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var apiService =
        await ApiServiceInterceptor(sharedPreferences: sharedPreferences);
    ApiResponseModel responseModel = await apiService.requestToServer(
        requestUrl: url,
        requestMethod: ApiRequestMethod.getRequest,
        headers: {
          'Authorization':
              '${apiService.sharedPreferences.getString(LocalStorageHelper.tokenTypeKey)} ${apiService.sharedPreferences.getString(LocalStorageHelper.accessTokenKey)}'
        });

    print("--------------- status: ${responseModel.statusCode}");
    print("--------------- response data: ${responseModel.responseJson}");

    return responseModel;
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "imy",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      initialBinding: InitialBinding(),
      defaultTransition: Transition.noTransition,
      translations: Languages(),
      locale: english,
      fallbackLocale: english,
    );
  }

  _registerOnFirebase() async {
    if (kIsWeb) {
      FirebaseMessaging.instance
          .getToken(
              vapidKey:
                  'BDXH4X3pqybqITPYyMBVOp7ssWy81kGYCeFWlV6pJRnzA5-6qrx6x7-Lv8PxdGNho2J8kf2eZ37ebYfMJ82MruA')
          .then((webToken) {
        setState(() {
          fcmToken = webToken ?? '';
          AppUtils.fcmToken = webToken ?? '';
        });
      });
    } else {
      FirebaseMessaging.instance.getToken().then((token) {
        setState(() {
          fcmToken = token ?? '';
          AppUtils.fcmToken = token ?? '';
        });
      });
    }
  }
}
