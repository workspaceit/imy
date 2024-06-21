class UploadFilesResponseModel {
  UploadFilesResponseModel({
      Results? results,}){
    _results = results;
}

  UploadFilesResponseModel.fromJson(dynamic json) {
    _results = json['results'] != null ? Results.fromJson(json['results']) : null;
  }
  Results? _results;

  Results? get results => _results;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_results != null) {
      map['results'] = _results?.toJson();
    }
    return map;
  }

}

class Results {
  Results({
      Storage? storage,}){
    _storage = storage;
}

  Results.fromJson(dynamic json) {
    _storage = json['storage'] != null ? Storage.fromJson(json['storage']) : null;
  }
  Storage? _storage;

  Storage? get storage => _storage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_storage != null) {
      map['storage'] = _storage?.toJson();
    }
    return map;
  }

}

class Storage {
  Storage({
      List<Files>? files,}){
    _files = files;
}

  Storage.fromJson(dynamic json) {
    if (json['files'] != null) {
      _files = [];
      json['files'].forEach((v) {
        _files?.add(Files.fromJson(v));
      });
    }
  }
  List<Files>? _files;

  List<Files>? get files => _files;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_files != null) {
      map['files'] = _files?.map((v) => v.toJson()).toList();
    }
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