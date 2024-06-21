class IluPointResponseModel {
  IluPointResponseModel({
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

  IluPointResponseModel.fromJson(dynamic json) {
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
      String? name, 
      int? points, 
      double? amount,}){
    _id = id;
    _name = name;
    _points = points;
    _amount = amount;
}

  Results.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _points = json['points'];
    _amount = json['amount'];
  }
  int? _id;
  String? _name;
  int? _points;
  double? _amount;

  int? get id => _id;
  String? get name => _name;
  int? get points => _points;
  double? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['points'] = _points;
    map['amount'] = _amount;
    return map;
  }

}