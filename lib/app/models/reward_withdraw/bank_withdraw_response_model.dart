class BankWithdrawResponseModel {
  BankWithdrawResponseModel({
      String? accountName, 
      String? accountNumber, 
      String? branch, 
      String? routingNumber, 
      double? amount, 
      String? amountInWords, 
      int? points, 
      dynamic walletNumber, 
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

  BankWithdrawResponseModel.fromJson(dynamic json) {
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
  String? _branch;
  String? _routingNumber;
  double? _amount;
  String? _amountInWords;
  int? _points;
  dynamic _walletNumber;
  String? _paymentMethod;

  String? get accountName => _accountName;
  String? get accountNumber => _accountNumber;
  String? get branch => _branch;
  String? get routingNumber => _routingNumber;
  double? get amount => _amount;
  String? get amountInWords => _amountInWords;
  int? get points => _points;
  dynamic get walletNumber => _walletNumber;
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