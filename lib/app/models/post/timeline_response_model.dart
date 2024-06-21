class TimelineResponseModel {
  TimelineResponseModel({
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

  TimelineResponseModel.fromJson(dynamic json) {
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
      String? caption, 
      String? createdAt, 
      String? updatedAt, 
      List<Files>? files, 
      bool? isLiked,
      int? liked
  }){
    _id = id;
    _caption = caption;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _files = files;
    _isLiked = isLiked;
    _liked = liked;
}

  Results.fromJson(dynamic json) {
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
    _isLiked = json['is_liked'];
    _liked = json['liked'];
  }
  int? _id;
  String? _caption;
  String? _createdAt;
  String? _updatedAt;
  List<Files>? _files;
  bool? _isLiked;
  int? _liked;

  int? get id => _id;
  String? get caption => _caption;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Files>? get files => _files;
  bool? get isLiked => _isLiked;
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
    map['is_liked'] = _isLiked;
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