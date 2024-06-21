class CheckResetPasswordModel {
  CheckResetPasswordModel({
      bool? success, 
      String? message, 
      String? verificationCode,}){
    _success = success;
    _message = message;
    _verificationCode = verificationCode;
}

  CheckResetPasswordModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _verificationCode = json['verification_code'];
  }
  bool? _success;
  String? _message;
  String? _verificationCode;

  bool? get success => _success;
  String? get message => _message;
  String? get verificationCode => _verificationCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    map['verification_code'] = _verificationCode;
    return map;
  }

}