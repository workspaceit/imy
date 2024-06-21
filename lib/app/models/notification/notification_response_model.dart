import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationResponseModel {
  final String image;
  final bool isRead;
  final String message;
  final String type;
  final int userId;
  final Timestamp dateTime;
  const NotificationResponseModel({
    required this.image,
    required this.isRead,
    required this.message,
    required this.type,
    required this.userId,
    required this.dateTime,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) => NotificationResponseModel(
      image: json['image'] ?? "",
      isRead: json['is_read'],
      message: json['message'],
      type: json['type'],
      userId: json['user_id'],
      dateTime: json['datetime']
  );

  Map<String, dynamic> toJson() => {
    'image' : image,
    'is_read' : isRead,
    'message' : message,
    'type' : type,
    'user_id' : userId,
    'datetime' : dateTime
  };
}