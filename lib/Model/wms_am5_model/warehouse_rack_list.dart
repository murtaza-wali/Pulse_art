/// warehouse_rack_list_items : [{"rack_label":"A1"},{"rack_label":"A2"},{"rack_label":"A3"},{"rack_label":"A4"},{"rack_label":"A5"},{"rack_label":"A6"},{"rack_label":"A7"},{"rack_label":"A8"},{"rack_label":"B1"},{"rack_label":"B2"},{"rack_label":"B3"},{"rack_label":"B4"},{"rack_label":"B5"},{"rack_label":"B6"},{"rack_label":"B7"},{"rack_label":"B8"},{"rack_label":"C1"},{"rack_label":"C2"},{"rack_label":"C3"},{"rack_label":"C4"},{"rack_label":"C5"},{"rack_label":"C6"},{"rack_label":"C7"},{"rack_label":"C8"}]
/// hasMore : false
/// limit : 0
/// offset : 0
/// count : 24
/// links : [{"rel":"self","href":"https://art.artisticmilliners.com:8081/ords/art/bscan/warehouse/rack_list/?org_id=84&wh_type=50"},{"rel":"describedby","href":"https://art.artisticmilliners.com:8081/ords/art/metadata-catalog/bscan/warehouse/rack_list/"}]

class Warehouse_rack_list {
  List<Warehouse_rack_list_items> _warehouseRackListItems;
  bool _hasMore;
  int _limit;
  int _offset;
  int _count;
  List<Links> _links;

  List<Warehouse_rack_list_items> get warehouseRackListItems => _warehouseRackListItems;
  bool get hasMore => _hasMore;
  int get limit => _limit;
  int get offset => _offset;
  int get count => _count;
  List<Links> get links => _links;

  Warehouse_rack_list({
      List<Warehouse_rack_list_items> warehouseRackListItems, 
      bool hasMore, 
      int limit, 
      int offset, 
      int count, 
      List<Links> links}){
    _warehouseRackListItems = warehouseRackListItems;
    _hasMore = hasMore;
    _limit = limit;
    _offset = offset;
    _count = count;
    _links = links;
}

  Warehouse_rack_list.fromJson(dynamic json) {
    if (json["warehouse_rack_list_items"] != null) {
      _warehouseRackListItems = [];
      json["warehouse_rack_list_items"].forEach((v) {
        _warehouseRackListItems.add(Warehouse_rack_list_items.fromJson(v));
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
    if (_warehouseRackListItems != null) {
      map["warehouse_rack_list_items"] = _warehouseRackListItems.map((v) => v.toJson()).toList();
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
/// href : "https://art.artisticmilliners.com:8081/ords/art/bscan/warehouse/rack_list/?org_id=84&wh_type=50"

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

/// rack_label : "A1"

class Warehouse_rack_list_items {
  String _rackLabel;

  String get rackLabel => _rackLabel;

  Warehouse_rack_list_items({
      String rackLabel}){
    _rackLabel = rackLabel;
}

  Warehouse_rack_list_items.fromJson(dynamic json) {
    _rackLabel = json["rack_label"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["rack_label"] = _rackLabel;
    return map;
  }

}