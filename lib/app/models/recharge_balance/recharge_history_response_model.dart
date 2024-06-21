class RechargeHistoryResponseModel {
  RechargeHistoryResponseModel({
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

  RechargeHistoryResponseModel.fromJson(dynamic json) {
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
      String? createdAt, 
      int? points, 
      double? amount, 
      bool? isPurchaseFromReward,}){
    _id = id;
    _createdAt = createdAt;
    _points = points;
    _amount = amount;
    _isPurchaseFromReward = isPurchaseFromReward;
}

  Results.fromJson(dynamic json) {
    _id = json['id'];
    _createdAt = json['created_at'];
    _points = json['points'];
    _amount = json['amount'];
    _isPurchaseFromReward = json['is_purchase_from_reward'];
  }
  int? _id;
  String? _createdAt;
  int? _points;
  double? _amount;
  bool? _isPurchaseFromReward;

  int? get id => _id;
  String? get createdAt => _createdAt;
  int? get points => _points;
  double? get amount => _amount;
  bool? get isPurchaseFromReward => _isPurchaseFromReward;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['created_at'] = _createdAt;
    map['points'] = _points;
    map['amount'] = _amount;
    map['is_purchase_from_reward'] = _isPurchaseFromReward;
    return map;
  }

}