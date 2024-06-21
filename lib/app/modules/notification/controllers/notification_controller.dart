import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:ilu/app/core/helper/local_storage_helper.dart';
import 'package:ilu/app/data/notification/notificaton_repo.dart';
import 'package:ilu/app/models/notification/notification_response_model.dart';

class NotificationController extends GetxController {
  NotificationRepo repo;
  NotificationController({required this.repo});

  bool isLoading = false;
  List<NotificationResponseModel> notificationList = [];

  initialState() async{
    isLoading = true;
    update();

    notificationList.clear();
    await getNotificationData();

    isLoading = false;
    update();
  }

  Future<List<NotificationResponseModel>> getNotificationData() async{

    FirebaseFirestore.instance.collection("notification").where("user_id", isEqualTo: repo.apiService.sharedPreferences.getInt(LocalStorageHelper.userIdKey)).orderBy("datetime", descending: true).snapshots().listen((event) {
       notificationList = event.docs.map((e) => NotificationResponseModel.fromJson(e.data())).toList();
       update();
    });

    return notificationList;
  }
}
