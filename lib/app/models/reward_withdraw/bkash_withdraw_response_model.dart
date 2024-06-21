class BkashWithdrawResponseModel {
  BkashWithdrawResponseModel({
      String? accountName, 
      String? accountNumber, 
      dynamic branch, 
      dynamic routingNumber, 
      double? amount, 
      String? amountInWords, 
      int? points, 
      String? walletNumber, 
      String? paymentMethod,}){
    _accountName = accountName;
    _accountNumber = accountNumber;
    _branch = branch;
    _routingNumber = routingNumber;
    _amount = amount;
    _amountInWords = amountInWords;
    _points = points;
    _walletNumber = walletNumber;
    _paymentMethod = paymentMethod;
}

  BkashWithdrawResponseModel.fromJson(dynamic json) {
    _accountName = json['account_name'];
    _accountNumber = json['account_number'];
    _branch = json['branch'];
    _routingNumber = json['routing_number'];
    _amount = json['amount'];
    _amountInWords = json['amount_in_words'];
    _points = json['points'];
    _walletNumber = json['wallet_number'];
    _paymentMethod = json['payment_method'];
  }
  String? _accountName;
  String? _accountNumber;
  dynamic _branch;
  dynamic _routingNumber;
  double? _amount;
  String? _amountInWords;
  int? _points;
  String? _walletNumber;
  String? _paymentMethod;

  String? get accountName => _accountName;
  String? get accountNumber => _accountNumber;
  dynamic get branch => _branch;
  dynamic get routingNumber => _routingNumber;
  double? get amount => _amount;
  String? get amountInWords => _amountInWords;
  int? get points => _points;
  String? get walletNumber => _walletNumber;
  String? get paymentMethod => _paymentMethod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_name'] = _accountName;
    map['account_number'] = _accountNumber;
    map['branch'] = _branch;
    map['routing_number'] = _routingNumber;
    map['amount'] = _amount;
    map['amount_in_words'] = _amountInWords;
    map['points'] = _points;
    map['wallet_number'] = _walletNumber;
    map['payment_method'] = _paymentMethod;
    return map;
  }

}