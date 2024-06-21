class RewardHistoryResponseModel {
  RewardHistoryResponseModel({
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

  RewardHistoryResponseModel.fromJson(dynamic json) {
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
      String? date, 
      int? totalPoints,}){
    _date = date;
    _totalPoints = totalPoints;
}

  Results.fromJson(dynamic json) {
    _date = json['date'];
    _totalPoints = json['total_points'];
  }
  String? _date;
  int? _totalPoints;

  String? get date => _date;
  int? get totalPoints => _totalPoints;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = _date;
    map['total_points'] = _totalPoints;
    return map;
  }

}