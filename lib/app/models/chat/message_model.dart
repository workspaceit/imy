class MessageModel {
  MessageModel({
    required this.toId,
    required this.msg,
    required this.read,
    required this.type,
    required this.fromId,
    required this.sent,
  });

  late final int toId;
  late final String msg;
  late final String read;
  late final int fromId;
  late final String sent;
  late final MessageType type;

  MessageModel.fromJson(Map<String, dynamic> json) {
    toId = json['toId'];
    msg = json['msg'].toString();
    read = json['read'].toString();
    type = json['type'].toString() == MessageType.image.name ? MessageType.image : MessageType.text;
    fromId = json['fromId'];
    sent = json['sent'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['msg'] = msg;
    data['read'] = read;
    data['type'] = type.name;
    data['fromId'] = fromId;
    data['sent'] = sent;
    return data;
  }
}

enum MessageType { text, image }

class CallModel {
  CallModel({
    required this.toId,
    required this.msg,
    required this.name,
    required this.token,
    required this.fromId,
    required this.sent,
  });

  late final int toId;
  late final String msg;
  late final String name;
  late final int fromId;
  late final String sent;
  late final String token;

  CallModel.fromJson(Map<String, dynamic> json) {
    toId = json['toId'];
    msg = json['msg'].toString();
    name = json['name'].toString();
    token = json['type'].toString();
    fromId = json['fromId'];
    sent = json['sent'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['toId'] = toId;
    data['msg'] = msg;
    data['name'] = name;
    data['token'] = token;
    data['fromId'] = fromId;
    data['sent'] = sent;
    return data;
  }
}


