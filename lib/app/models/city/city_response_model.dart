class CityResponseModel {
  CityResponseModel({
      List<City>? city,}){
    _city = city;
}

  CityResponseModel.fromJson(dynamic json) {
    if (json['city'] != null) {
      _city = [];
      json['city'].forEach((v) {
        _city?.add(City.fromJson(v));
      });
    }
  }
  List<City>? _city;

  List<City>? get city => _city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_city != null) {
      map['city'] = _city?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class City {
  City({
      int? id, 
      String? name, 
      String? country,}){
    _id = id;
    _name = name;
    _country = country;
}

  City.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _country = json['country'];
  }
  int? _id;
  String? _name;
  String? _country;

  int? get id => _id;
  String? get name => _name;
  String? get country => _country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country'] = _country;
    return map;
  }

}