class RegistrationResponseModel {
  RegistrationResponseModel({
      bool? success, 
      String? message, 
      User? user,}){
    _success = success;
    _message = message;
    _user = user;
}

  RegistrationResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? _success;
  String? _message;
  User? _user;

  bool? get success => _success;
  String? get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

class User {
  User({
      int? id, 
      String? email, 
      String? firstName, 
      String? lastName, 
      bool? isActive, 
      String? phoneNumber, 
      String? userType, 
      String? gender, 
      String? dateOfBirth, 
      String? phoneCode, 
      City? city,
      String? uniqueId, 
      bool? isVerified, 
      int? points, 
      bool? enablePushNotification, 
      bool? enableMessageNotification, 
      bool? autoSaveChatImage, 
      String? createdAt,}){
    _id = id;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _isActive = isActive;
    _phoneNumber = phoneNumber;
    _userType = userType;
    _gender = gender;
    _dateOfBirth = dateOfBirth;
    _phoneCode = phoneCode;
    _city = city;
    _uniqueId = uniqueId;
    _isVerified = isVerified;
    _points = points;
    _enablePushNotification = enablePushNotification;
    _enableMessageNotification = enableMessageNotification;
    _autoSaveChatImage = autoSaveChatImage;
    _createdAt = createdAt;
}

  User.fromJson(dynamic json) {
    _id = json['id'];
    _email = json['email'];
    _firstName = json['first_name'];
    _lastName = json['last_name'];
    _isActive = json['is_active'];
    _phoneNumber = json['phone_number'];
    _userType = json['user_type'];
    _gender = json['gender'];
    _dateOfBirth = json['date_of_birth'];
    _phoneCode = json['phone_code'];
    _city = json['city'] != null ? City.fromJson(json['city']) : null;
    _uniqueId = json['unique_id'];
    _isVerified = json['is_verified'];
    _points = json['points'];
    _enablePushNotification = json['enable_push_notification'];
    _enableMessageNotification = json['enable_message_notification'];
    _autoSaveChatImage = json['auto_save_chat_image'];
    _createdAt = json['created_at'];
  }
  int? _id;
  String? _email;
  String? _firstName;
  String? _lastName;
  bool? _isActive;
  String? _phoneNumber;
  String? _userType;
  String? _gender;
  String? _dateOfBirth;
  String? _phoneCode;
  City? _city;
  String? _uniqueId;
  bool? _isVerified;
  int? _points;
  bool? _enablePushNotification;
  bool? _enableMessageNotification;
  bool? _autoSaveChatImage;
  String? _createdAt;

  int? get id => _id;
  String? get email => _email;
  String? get firstName => _firstName;
  String? get lastName => _lastName;
  bool? get isActive => _isActive;
  String? get phoneNumber => _phoneNumber;
  String? get userType => _userType;
  String? get gender => _gender;
  String? get dateOfBirth => _dateOfBirth;
  String? get phoneCode => _phoneCode;
  City? get city => _city;
  String? get uniqueId => _uniqueId;
  bool? get isVerified => _isVerified;
  int? get points => _points;
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
    map['is_active'] = _isActive;
    map['phone_number'] = _phoneNumber;
    map['user_type'] = _userType;
    map['gender'] = _gender;
    map['date_of_birth'] = _dateOfBirth;
    map['phone_code'] = _phoneCode;
    if (_city != null) {
      map['city'] = _city?.toJson();
    }
    map['unique_id'] = _uniqueId;
    map['is_verified'] = _isVerified;
    map['points'] = _points;
    map['enable_push_notification'] = _enablePushNotification;
    map['enable_message_notification'] = _enableMessageNotification;
    map['auto_save_chat_image'] = _autoSaveChatImage;
    map['created_at'] = _createdAt;
    return map;
  }

}

class City {
  City({
      int? id, 
      String? name, 
      String? country,}){
    _id = id;
    _name = name;
    _country = country;
}

  City.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _country = json['country'];
  }
  int? _id;
  String? _name;
  String? _country;

  int? get id => _id;
  String? get name => _name;
  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country'] = _country;
    return map;
  }

}