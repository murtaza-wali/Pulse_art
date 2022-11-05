/// Statusitems : [{"filter_type":"Closed"},{"filter_type":"In Process"}]
/// hasMore : false
/// limit : 100
/// offset : 0
/// count : 2
/// links : [{"rel":"self","href":"https://art.artisticmilliners.com:8081/ords/art/apis/ticket/workboard/filters/5118/2"},{"rel":"describedby","href":"https://art.artisticmilliners.com:8081/ords/art/metadata-catalog/apis/ticket/workboard/filters/5118/item"},{"rel":"first","href":"https://art.artisticmilliners.com:8081/ords/art/apis/ticket/workboard/filters/5118/2"}]

class WorkboardStatus {
  List<Statusitems> _statusitems;
  bool _hasMore;
  int _limit;
  int _offset;
  int _count;
  List<Links> _links;

  List<Statusitems> get statusitems => _statusitems;
  bool get hasMore => _hasMore;
  int get limit => _limit;
  int get offset => _offset;
  int get count => _count;
  List<Links> get links => _links;

  WorkboardStatus({
      List<Statusitems> statusitems, 
      bool hasMore, 
      int limit, 
      int offset, 
      int count, 
      List<Links> links}){
    _statusitems = statusitems;
    _hasMore = hasMore;
    _limit = limit;
    _offset = offset;
    _count = count;
    _links = links;
}

  WorkboardStatus.fromJson(dynamic json) {
    if (json["Statusitems"] != null) {
      _statusitems = [];
      json["Statusitems"].forEach((v) {
        _statusitems.add(Statusitems.fromJson(v));
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
    if (_statusitems != null) {
      map["Statusitems"] = _statusitems.map((v) => v.toJson()).toList();
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
/// href : "https://art.artisticmilliners.com:8081/ords/art/apis/ticket/workboard/filters/5118/2"

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

/// filter_type : "Closed"

class Statusitems {
  String _filterType;

  String get filterType => _filterType;

  Statusitems({
      String filterType}){
    _filterType = filterType;
}

  Statusitems.fromJson(dynamic json) {
    _filterType = json["filter_type"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["filter_type"] = _filterType;
    return map;
  }

}