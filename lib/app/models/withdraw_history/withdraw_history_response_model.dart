class WithdrawHistoryResponseModel {
  WithdrawHistoryResponseModel({
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

  WithdrawHistoryResponseModel.fromJson(dynamic json) {
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
      double? amount, 
      int? points, 
      String? status, 
      String? createdAt, 
      dynamic paidAt,}){
    _id = id;
    _amount = amount;
    _points = points;
    _status = status;
    _createdAt = createdAt;
    _paidAt = paidAt;
}

  Results.fromJson(dynamic json) {
    _id = json['id'];
    _amount = json['amount'];
    _points = json['points'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _paidAt = json['paid_at'];
  }
  int? _id;
  double? _amount;
  int? _points;
  String? _status;
  String? _createdAt;
  dynamic _paidAt;

  int? get id => _id;
  double? get amount => _amount;
  int? get points => _points;
  String? get status => _status;
  String? get createdAt => _createdAt;
  dynamic get paidAt => _paidAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['amount'] = _amount;
    map['points'] = _points;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['paid_at'] = _paidAt;
    return map;
  }

}