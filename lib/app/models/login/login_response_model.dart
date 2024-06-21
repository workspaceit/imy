class LoginResponseModel {
  LoginResponseModel({
      String? accessToken, 
      int? expiresIn, 
      String? tokenType, 
      String? scope, 
      String? refreshToken,}){
    _accessToken = accessToken;
    _expiresIn = expiresIn;
    _tokenType = tokenType;
    _scope = scope;
    _refreshToken = refreshToken;
}

  LoginResponseModel.fromJson(dynamic json) {
    _accessToken = json['access_token'];
    _expiresIn = json['expires_in'];
    _tokenType = json['token_type'];
    _scope = json['scope'];
    _refreshToken = json['refresh_token'];
  }
  String? _accessToken;
  int? _expiresIn;
  String? _tokenType;
  String? _scope;
  String? _refreshToken;

  String? get accessToken => _accessToken;
  int? get expiresIn => _expiresIn;
  String? get tokenType => _tokenType;
  String? get scope => _scope;
  String? get refreshToken => _refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['access_token'] = _accessToken;
    map['expires_in'] = _expiresIn;
    map['token_type'] = _tokenType;
    map['scope'] = _scope;
    map['refresh_token'] = _refreshToken;
    return map;
  }

}