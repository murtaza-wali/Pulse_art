/// severityitems : [{"value":"Urgent","id":2},{"value":"High","id":1},{"value":"Medium","id":3},{"value":"Low","id":4}]
/// hasMore : false
/// limit : 100
/// offset : 0
/// count : 4
/// links : [{"rel":"self","href":"https://art.artisticmilliners.com:8081/ords/art/apis/ticket/severity"},{"rel":"describedby","href":"https://art.artisticmilliners.com:8081/ords/art/metadata-catalog/apis/ticket/item"},{"rel":"first","href":"https://art.artisticmilliners.com:8081/ords/art/apis/ticket/severity"}]

class Severity {
  List<Severityitems> _severityitems;
  bool _hasMore;
  int _limit;
  int _offset;
  int _count;
  List<Links> _links;

  List<Severityitems> get severityitems => _severityitems;
  bool get hasMore => _hasMore;
  int get limit => _limit;
  int get offset => _offset;
  int get count => _count;
  List<Links> get links => _links;

  Severity({
      List<Severityitems> severityitems, 
      bool hasMore, 
      int limit, 
      int offset, 
      int count, 
      List<Links> links}){
    _severityitems = severityitems;
    _hasMore = hasMore;
    _limit = limit;
    _offset = offset;
    _count = count;
    _links = links;
}

  Severity.fromJson(dynamic json) {
    if (json["severityitems"] != null) {
      _severityitems = [];
      json["severityitems"].forEach((v) {
        _severityitems.add(Severityitems.fromJson(v));
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
    if (_severityitems != null) {
      map["severityitems"] = _severityitems.map((v) => v.toJson()).toList();
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
/// href : "https://art.artisticmilliners.com:8081/ords/art/apis/ticket/severity"

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

/// value : "Urgent"
/// id : 2

class Severityitems {
  String _value;
  int _id;

  String get value => _value;
  int get id => _id;

  Severityitems({
      String value, 
      int id}){
    _value = value;
    _id = id;
}

  Severityitems.fromJson(dynamic json) {
    _value = json["value"];
    _id = json["id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["value"] = _value;
    map["id"] = _id;
    return map;
  }

}