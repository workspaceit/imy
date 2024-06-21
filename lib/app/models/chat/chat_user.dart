class ChatUser {
  ChatUser({
    required this.image,
    required this.about,
    required this.name,
    required this.createdAt,
    required this.isOnline,
    required this.id,
    required this.lastActive,
    required this.uniqueId,
    required this.pushToken,
    required this.isBlocked
  });
  late String image;
  late String about;
  late String name;
  late String createdAt;
  late bool isOnline;
  late bool isBlocked;
  late String id;
  late String lastActive;
  late String uniqueId;
  late String pushToken;

  ChatUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    about = json['about'] ?? '';
    name = json['name'] ?? '';
    createdAt = json['created_at'] ?? '';
    isOnline = json['is_online'] ?? '';
    isBlocked = json['is_blocked'] ?? '';
    id = json['id'] ?? '';
    lastActive = json['last_active'] ?? '';
    uniqueId = json['uniqueId'] ?? '';
    pushToken = json['push_token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['about'] = about;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['is_online'] = isOnline;
    data['is_blocked'] = isBlocked;
    data['id'] = id;
    data['last_active'] = lastActive;
    data['uniqueId'] = uniqueId;
    data['push_token'] = pushToken;
    return data;
  }
}
