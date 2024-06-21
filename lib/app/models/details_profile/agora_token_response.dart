// To parse this JSON data, do
//
//     final agoraTokenResponse = agoraTokenResponseFromJson(jsonString);

import 'dart:convert';

AgoraTokenResponse agoraTokenResponseFromJson(String str) => AgoraTokenResponse.fromJson(json.decode(str));

String agoraTokenResponseToJson(AgoraTokenResponse data) => json.encode(data.toJson());

class AgoraTokenResponse {
  bool? success;
  String? token;

  AgoraTokenResponse({
    this.success,
    this.token,
  });

  factory AgoraTokenResponse.fromJson(Map<String, dynamic> json) => AgoraTokenResponse(
    success: json["success"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "token": token,
  };
}
