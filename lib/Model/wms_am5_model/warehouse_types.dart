/// warehouse_types_items : [{"wh_type_id":"50","wh_type_name":"Finish Goods Warehouse"}]
/// hasMore : false
/// limit : 0
/// offset : 0
/// count : 1
/// links : [{"rel":"self","href":"https://art.artisticmilliners.com:8081/ords/art/bscan/warehouse/types/?org_id=84"},{"rel":"describedby","href":"https://art.artisticmilliners.com:8081/ords/art/metadata-catalog/bscan/warehouse/types/"}]

class Warehouse_types {
  List<Warehouse_types_items> _warehouseTypesItems;
  bool _hasMore;
  int _limit;
  int _offset;
  int _count;
  List<Links> _links;

  List<Warehouse_types_items> get warehouseTypesItems => _warehouseTypesItems;

  bool get hasMore => _hasMore;

  int get limit => _limit;

  int get offset => _offset;

  int get count => _count;

  List<Links> get links => _links;

  Warehouse_types(
      {List<Warehouse_types_items> warehouseTypesItems,
      bool hasMore,
      int limit,
      int offset,
      int count,
      List<Links> links}) {
    _warehouseTypesItems = warehouseTypesItems;
    _hasMore = hasMore;
    _limit = limit;
    _offset = offset;
    _count = count;
    _links = links;
  }

  Warehouse_types.fromJson(dynamic json) {
    if (json["warehouse_types_items"] != null) {
      _warehouseTypesItems = [];
      json["warehouse_types_items"].forEach((v) {
        _warehouseTypesItems.add(Warehouse_types_items.fromJson(v));
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
    if (_warehouseTypesItems != null) {
      map["warehouse_types_items"] =
          _warehouseTypesItems.map((v) => v.toJson()).toList();
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
/// href : "https://art.artisticmilliners.com:8081/ords/art/bscan/warehouse/types/?org_id=84"

class Links {
  String _rel;
  String _href;

  String get rel => _rel;

  String get href => _href;

  Links({String rel, String href}) {
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

/// wh_type_id : "50"
/// wh_type_name : "Finish Goods Warehouse"

class Warehouse_types_items {
  String _whTypeId;
  String _whTypeName;

  String get whTypeId => _whTypeId;

  String get whTypeName => _whTypeName;

  Warehouse_types_items({String whTypeId, String whTypeName}) {
    _whTypeId = whTypeId;
    _whTypeName = whTypeName;
  }

  Warehouse_types_items.fromJson(dynamic json) {
    _whTypeId = json["wh_type_id"];
    _whTypeName = json["wh_type_name"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["wh_type_id"] = _whTypeId;
    map["wh_type_name"] = _whTypeName;
    return map;
  }
}
