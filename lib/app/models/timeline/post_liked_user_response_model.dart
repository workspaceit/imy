class PostLikedUserResponseModel {
  PostLikedUserResponseModel({
      int? count, 
      dynamic next, 
      dynamic previous, 
      int? totalPage, 
      List<Results>? results,}){
    _count = count;
    _next = next;
    _previous = previous;
    _totalPage = totalPage;
    _results = results;
}

  PostLikedUserResponseModel.fromJson(dynamic json) {
    _count = json['count'];
    _next = json['next'];
    _previous = json['previous'];
    _totalPage = json['total_page'];
    if (json['results'] != null) {
      _results = [];
      json['results'].forEach((v) {
        _results?.add(Results.fromJson(v));
      });
    }
  }
  int? _count;
  dynamic _next;
  dynamic _previous;
  int? _totalPage;
  List<Results>? _results;

  int? get count => _count;
  dynamic get next => _next;
  dynamic get previous => _previous;
  int? get totalPage => _totalPage;
  List<Results>? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    map['next'] = _next;
    map['previous'] = _previous;
    map['total_page'] = _totalPage;
    if (_results != null) {
      map['results'] = _results?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Results {
  Results({
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

  Results.fromJson(dynamic json) {
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