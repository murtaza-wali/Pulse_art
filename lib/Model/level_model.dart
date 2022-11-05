/// items : [{"lvl":1,"lvl_num":1},{"lvl":2,"lvl_num":2},{"lvl":3,"lvl_num":3},{"lvl":4,"lvl_num":4},{"lvl":5,"lvl_num":5}]
/// hasMore : false
/// limit : 100
/// offset : 0
/// count : 5
/// links : [{"rel":"self","href":"https://art.artisticmilliners.com:8081/ords/art/apis/empH/levels/0109000188"},{"rel":"describedby","href":"https://art.artisticmilliners.com:8081/ords/art/metadata-catalog/apis/empH/levels/item"},{"rel":"first","href":"https://art.artisticmilliners.com:8081/ords/art/apis/empH/levels/0109000188"}]

class Level_model {
  List<Items> _items;
  bool _hasMore;
  int _limit;
  int _offset;
  int _count;
  List<Links> _links;

  List<Items> get items => _items;
  bool get hasMore => _hasMore;
  int get limit => _limit;
  int get offset => _offset;
  int get count => _count;
  List<Links> get links => _links;

  Level_model({
      List<Items> items, 
      bool hasMore, 
      int limit, 
      int offset, 
      int count, 
      List<Links> links}){
    _items = items;
    _hasMore = hasMore;
    _limit = limit;
    _offset = offset;
    _count = count;
    _links = links;
}

  Level_model.fromJson(dynamic json) {
    if (json["items"] != null) {
      _items = [];
      json["items"].forEach((v) {
        _items.add(Items.fromJson(v));
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
    if (_items != null) {
      map["items"] = _items.map((v) => v.toJson()).toList();
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
/// href : "https://art.artisticmilliners.com:8081/ords/art/apis/empH/levels/0109000188"

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

/// lvl : 1
/// lvl_num : 1

class Items {
  int _lvl;
  int _lvlNum;

  int get lvl => _lvl;
  int get lvlNum => _lvlNum;

  Items({
      int lvl, 
      int lvlNum}){
    _lvl = lvl;
    _lvlNum = lvlNum;
}

  Items.fromJson(dynamic json) {
    _lvl = json["lvl"];
    _lvlNum = json["lvl_num"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["lvl"] = _lvl;
    map["lvl_num"] = _lvlNum;
    return map;
  }

}