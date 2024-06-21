class CreateCallResponseModel {
  CreateCallResponseModel({
      int? id, 
      String? callDuration, 
      int? pointsSpent, 
      int? pointsGained, 
      String? startTime, 
      String? endTime, 
      String? callType, 
      Caller? caller, 
      Receiver? receiver,}){
    _id = id;
    _callDuration = callDuration;
    _pointsSpent = pointsSpent;
    _pointsGained = pointsGained;
    _startTime = startTime;
    _endTime = endTime;
    _callType = callType;
    _caller = caller;
    _receiver = receiver;
}

  CreateCallResponseModel.fromJson(dynamic json) {
    _id = json['id'];
    _callDuration = json['call_duration'];
    _pointsSpent = json['points_spent'];
    _pointsGained = json['points_gained'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _callType = json['call_type'];
    _caller = json['caller'] != null ? Caller.fromJson(json['caller']) : null;
    _receiver = json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null;
  }
  int? _id;
  String? _callDuration;
  int? _pointsSpent;
  int? _pointsGained;
  String? _startTime;
  String? _endTime;
  String? _callType;
  Caller? _caller;
  Receiver? _receiver;

  int? get id => _id;
  String? get callDuration => _callDuration;
  int? get pointsSpent => _pointsSpent;
  int? get pointsGained => _pointsGained;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get callType => _callType;
  Caller? get caller => _caller;
  Receiver? get receiver => _receiver;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['call_duration'] = _callDuration;
    map['points_spent'] = _pointsSpent;
    map['points_gained'] = _pointsGained;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['call_type'] = _callType;
    if (_caller != null) {
      map['caller'] = _caller?.toJson();
    }
    if (_receiver != null) {
      map['receiver'] = _receiver?.toJson();
    }
    return map;
  }

}

class Receiver {
  Receiver({
      int? id, 
      String? firstName, 
      String? lastName, 
      ProfileImage? profileImage, 
      String? uniqueId, 
      bool? isVerified, 
      int? age, 
      String? createdAt,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _profileImage = profileImage;
    _uniqueId = uniqueId;
    _isVerified = isVerified;
    _age = age;
    _createdAt = createdAt;
}

  Receiver.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _profileImage = json['profile_image'] != null ? ProfileImage.fromJson(json['profile_image']) : null;
    _uniqueId = json['unique_id'];
    _isVerified = json['is_verified'];
    _age = json['age'];
    _createdAt = json['created_at'];
  }
  int? _id;
  String? _firstName;
  String? _lastName;
  ProfileImage? _profileImage;
  String? _uniqueId;
  bool? _isVerified;
  int? _age;
  String? _createdAt;

  int? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  ProfileImage? get profileImage => _profileImage;
  String? get uniqueId => _uniqueId;
  bool? get isVerified => _isVerified;
  int? get age => _age;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    if (_profileImage != null) {
      map['profile_image'] = _profileImage?.toJson();
    }
    map['unique_id'] = _uniqueId;
    map['is_verified'] = _isVerified;
    map['age'] = _age;
    map['created_at'] = _createdAt;
    return map;
  }

}

class ProfileImage {
  ProfileImage({
      int? id, 
      String? name, 
      String? extension, 
      String? file, 
      String? thumbnail, 
      bool? isPrimary,}){
    _id = id;
    _name = name;
    _extension = extension;
    _file = file;
    _thumbnail = thumbnail;
    _isPrimary = isPrimary;
}

  ProfileImage.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _extension = json['extension'];
    _file = json['file'];
    _thumbnail = json['thumbnail'];
    _isPrimary = json['is_primary'];
  }
  int? _id;
  String? _name;
  String? _extension;
  String? _file;
  String? _thumbnail;
  bool? _isPrimary;

  int? get id => _id;
  String? get name => _name;
  String? get extension => _extension;
  String? get file => _file;
  String? get thumbnail => _thumbnail;
  bool? get isPrimary => _isPrimary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['extension'] = _extension;
    map['file'] = _file;
    map['thumbnail'] = _thumbnail;
    map['is_primary'] = _isPrimary;
    return map;
  }

}

class Caller {
  Caller({
      int? id, 
      String? firstName, 
      String? lastName, 
      ProfileImage? profileImage, 
      String? uniqueId, 
      bool? isVerified, 
      int? age, 
      String? createdAt,}){
    _id = id;
    _firstName = firstName;
    _lastName = lastName;
    _profileImage = profileImage;
    _uniqueId = uniqueId;
    _isVerified = isVerified;
    _age = age;
    _createdAt = createdAt;
}

  Caller.fromJson(dynamic json) {
    _id = json['id'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _profileImage = json['profile_image'] != null ? ProfileImage.fromJson(json['profile_image']) : null;
    _uniqueId = json['unique_id'];
    _isVerified = json['is_verified'];
    _age = json['age'];
    _createdAt = json['created_at'];
  }
  int? _id;
  String? _firstName;
  String? _lastName;
  ProfileImage? _profileImage;
  String? _uniqueId;
  bool? _isVerified;
  int? _age;
  String? _createdAt;

  int? get id => _id;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  ProfileImage? get profileImage => _profileImage;
  String? get uniqueId => _uniqueId;
  bool? get isVerified => _isVerified;
  int? get age => _age;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    if (_profileImage != null) {
      map['profile_image'] = _profileImage?.toJson();
    }
    map['unique_id'] = _uniqueId;
    map['is_verified'] = _isVerified;
    map['age'] = _age;
    map['created_at'] = _createdAt;
    return map;
  }

}