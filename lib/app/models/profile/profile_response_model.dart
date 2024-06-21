class ProfileResponseModel {
  ProfileResponseModel({
      int? id, 
      String? email, 
      String? firstName, 
      String? lastName, 
      int? age, 
      bool? isActive, 
      dynamic phoneNumber, 
      String? userType, 
      String? gender, 
      String? dateOfBirth, 
      dynamic phoneCode, 
      dynamic city, 
      String? country, 
      List<ProfileImages>? profileImages, 
      String? uniqueId, 
      bool? isVerified, 
      int? iluPoints, 
      int? rewardPoints, 
      bool? enablePushNotification, 
      bool? enableMessageNotification, 
      bool? autoSaveChatImage, 
      String? createdAt,}){
    _id = id;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _age = age;
    _isActive = isActive;
    _phoneNumber = phoneNumber;
    _userType = userType;
    _gender = gender;
    _dateOfBirth = dateOfBirth;
    _phoneCode = phoneCode;
    _city = city;
    _country = country;
    _profileImages = profileImages;
    _uniqueId = uniqueId;
    _isVerified = isVerified;
    _iluPoints = iluPoints;
    _rewardPoints = rewardPoints;
    _enablePushNotification = enablePushNotification;
    _enableMessageNotification = enableMessageNotification;
    _autoSaveChatImage = autoSaveChatImage;
    _createdAt = createdAt;
}

  ProfileResponseModel.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _age = json['age'];
    _isActive = json['is_active'];
    _phoneNumber = json['phone_number'];
    _userType = json['user_type'];
    _gender = json['gender'];
    _dateOfBirth = json['date_of_birth'];
    _phoneCode = json['phone_code'];
    _city = json['city'];
    _country = json['country'];
    if (json['profile_images'] != null) {
      _profileImages = [];
      json['profile_images'].forEach((v) {
        _profileImages?.add(ProfileImages.fromJson(v));
      });
    }
    _uniqueId = json['unique_id'];
    _isVerified = json['is_verified'];
    _iluPoints = json['ilu_points'];
    _rewardPoints = json['reward_points'];
    _enablePushNotification = json['enable_push_notification'];
    _enableMessageNotification = json['enable_message_notification'];
    _autoSaveChatImage = json['auto_save_chat_image'];
    _createdAt = json['created_at'];
  }
  int? _id;
  String? _email;
  String? _firstName;
  String? _lastName;
  int? _age;
  bool? _isActive;
  dynamic _phoneNumber;
  String? _userType;
  String? _gender;
  String? _dateOfBirth;
  dynamic _phoneCode;
  dynamic _city;
  String? _country;
  List<ProfileImages>? _profileImages;
  String? _uniqueId;
  bool? _isVerified;
  int? _iluPoints;
  int? _rewardPoints;
  bool? _enablePushNotification;
  bool? _enableMessageNotification;
  bool? _autoSaveChatImage;
  String? _createdAt;

  int? get id => _id;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  int? get age => _age;
  bool? get isActive => _isActive;
  dynamic get phoneNumber => _phoneNumber;
  String? get userType => _userType;
  String? get gender => _gender;
  String? get dateOfBirth => _dateOfBirth;
  dynamic get phoneCode => _phoneCode;
  dynamic get city => _city;
  String? get country => _country;
  List<ProfileImages>? get profileImages => _profileImages;
  String? get uniqueId => _uniqueId;
  bool? get isVerified => _isVerified;
  int? get iluPoints => _iluPoints;
  int? get rewardPoints => _rewardPoints;
  bool? get enablePushNotification => _enablePushNotification;
  bool? get enableMessageNotification => _enableMessageNotification;
  bool? get autoSaveChatImage => _autoSaveChatImage;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['email'] = _email;
    map['first_name'] = _firstName;
    map['last_name'] = _lastName;
    map['age'] = _age;
    map['is_active'] = _isActive;
    map['phone_number'] = _phoneNumber;
    map['user_type'] = _userType;
    map['gender'] = _gender;
    map['date_of_birth'] = _dateOfBirth;
    map['phone_code'] = _phoneCode;
    map['city'] = _city;
    map['country'] = _country;
    if (_profileImages != null) {
      map['profile_images'] = _profileImages?.map((v) => v.toJson()).toList();
    }
    map['unique_id'] = _uniqueId;
    map['is_verified'] = _isVerified;
    map['ilu_points'] = _iluPoints;
    map['reward_points'] = _rewardPoints;
    map['enable_push_notification'] = _enablePushNotification;
    map['enable_message_notification'] = _enableMessageNotification;
    map['auto_save_chat_image'] = _autoSaveChatImage;
    map['created_at'] = _createdAt;
    return map;
  }

}

class ProfileImages {
  ProfileImages({
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

  ProfileImages.fromJson(dynamic json) {
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