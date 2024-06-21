class InvoiceResponseModel {
  InvoiceResponseModel({
      bool? success, 
      Invoice? invoice,}){
    _success = success;
    _invoice = invoice;
}

  InvoiceResponseModel.fromJson(dynamic json) {
    _success = json['success'];
    _invoice = json['invoice'] != null ? Invoice.fromJson(json['invoice']) : null;
  }
  bool? _success;
  Invoice? _invoice;

  bool? get success => _success;
  Invoice? get invoice => _invoice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_invoice != null) {
      map['invoice'] = _invoice?.toJson();
    }
    return map;
  }

}

class Invoice {
  Invoice({
      int? id, 
      int? points, 
      double? amount, 
      String? name, 
      String? uniqueId, 
      String? requestDate, 
      String? invoiceDate, 
      String? status,}){
    _id = id;
    _points = points;
    _amount = amount;
    _name = name;
    _uniqueId = uniqueId;
    _requestDate = requestDate;
    _invoiceDate = invoiceDate;
    _status = status;
}

  Invoice.fromJson(dynamic json) {
    _id = json['id'];
    _points = json['points'];
    _amount = json['amount'];
    _name = json['name'];
    _uniqueId = json['unique_id'];
    _requestDate = json['request_date'];
    _invoiceDate = json['invoice_date'];
    _status = json['status'];
  }
  int? _id;
  int? _points;
  double? _amount;
  String? _name;
  String? _uniqueId;
  String? _requestDate;
  String? _invoiceDate;
  String? _status;

  int? get id => _id;
  int? get points => _points;
  double? get amount => _amount;
  String? get name => _name;
  String? get uniqueId => _uniqueId;
  String? get requestDate => _requestDate;
  String? get invoiceDate => _invoiceDate;
  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['points'] = _points;
    map['amount'] = _amount;
    map['name'] = _name;
    map['unique_id'] = _uniqueId;
    map['request_date'] = _requestDate;
    map['invoice_date'] = _invoiceDate;
    map['status'] = _status;
    return map;
  }

}