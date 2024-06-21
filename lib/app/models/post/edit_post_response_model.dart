class EditPostResponseModel {
  EditPostResponseModel({
      int? id, 
      dynamic caption, 
      String? createdAt, 
      String? updatedAt, 
      List<Files>? files, 
      int? liked,}){
    _id = id;
    _caption = caption;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _files = files;
    _liked = liked;
}

  EditPostResponseModel.fromJson(dynamic json) {
    _id = json['id'];
    _caption = json['caption'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['files'] != null) {
      _files = [];
      json['files'].forEach((v) {
        _files?.add(Files.fromJson(v));
      });
    }
    _liked = json['liked'];
  }
  int? _id;
  dynamic _caption;
  String? _createdAt;
  String? _updatedAt;
  List<Files>? _files;
  int? _liked;

  int? get id => _id;
  dynamic get caption => _caption;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Files>? get files => _files;
  int? get liked => _liked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['caption'] = _caption;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_files != null) {
      map['files'] = _files?.map((v) => v.toJson()).toList();
    }
    map['liked'] = _liked;
    return map;
  }

}

class Files {
  Files({
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

  Files.fromJson(dynamic json) {
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