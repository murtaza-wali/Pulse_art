/// daywiseunititems : [{"day":"01","day_total":7179},{"day":"02","day_total":23283},{"day":"03","day_total":5931},{"day":"04","day_total":1029},{"day":"06","day_total":64815},{"day":"07","day_total":17676}]
/// hasMore : false
/// limit : 25
/// offset : 0
/// count : 6
/// links : [{"rel":"self","href":"https://art.artisticmilliners.com:8081/ords/art/dashboard/denim_sales/daywiseunit/83"},{"rel":"describedby","href":"https://art.artisticmilliners.com:8081/ords/art/metadata-catalog/dashboard/denim_sales/daywiseunit/item"},{"rel":"first","href":"https://art.artisticmilliners.com:8081/ords/art/dashboard/denim_sales/daywiseunit/83"}]

class DaywiseunitModel {
  List<Daywiseunititems> _daywiseunititems;
  bool _hasMore;
  int _limit;
  int _offset;
  int _count;
  List<Links> _links;

  List<Daywiseunititems> get daywiseunititems => _daywiseunititems;
  bool get hasMore => _hasMore;
  int get limit => _limit;
  int get offset => _offset;
  int get count => _count;
  List<Links> get links => _links;

  DaywiseunitModel({
      List<Daywiseunititems> daywiseunititems, 
      bool hasMore, 
      int limit, 
      int offset, 
      int count, 
      List<Links> links}){
    _daywiseunititems = daywiseunititems;
    _hasMore = hasMore;
    _limit = limit;
    _offset = offset;
    _count = count;
    _links = links;
}

  DaywiseunitModel.fromJson(dynamic json) {
    if (json["daywiseunititems"] != null) {
      _daywiseunititems = [];
      json["daywiseunititems"].forEach((v) {
        _daywiseunititems.add(Daywiseunititems.fromJson(v));
      });
    }
    _hasMore = json["hasMore"];
    _limit = json["limit"];
    _offset = json["offset"];
    _count = json["count"];
    if (json["links"] != null) {
      _links = [];
      json["links"].forEach((v) {
        _links.add(Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_daywiseunititems != null) {
      map["daywiseunititems"] = _daywiseunititems.map((v) => v.toJson()).toList();
    }
    map["hasMore"] = _hasMore;
    map["limit"] = _limit;
    map["offset"] = _offset;
    map["count"] = _count;
    if (_links != null) {
      map["links"] = _links.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// rel : "self"
/// href : "https://art.artisticmilliners.com:8081/ords/art/dashboard/denim_sales/daywiseunit/83"

class Links {
  String _rel;
  String _href;

  String get rel => _rel;
  String get href => _href;

  Links({
      String rel, 
      String href}){
    _rel = rel;
    _href = href;
}

  Links.fromJson(dynamic json) {
    _rel = json["rel"];
    _href = json["href"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["rel"] = _rel;
    map["href"] = _href;
    return map;
  }

}

/// day : "01"
/// day_total : 7179

class Daywiseunititems {
  String _day;
  int _dayTotal;

  String get day => _day;
  int get dayTotal => _dayTotal;

  Daywiseunititems({
      String day, 
      int dayTotal}){
    _day = day;
    _dayTotal = dayTotal;
}

  Daywiseunititems.fromJson(dynamic json) {
    _day = json["day"];
    _dayTotal = json["day_total"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["day"] = _day;
    map["day_total"] = _dayTotal;
    return map;
  }

}