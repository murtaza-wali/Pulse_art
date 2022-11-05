/// fabric_lib_items : [{"organization_code":"AM2","org_id":83},{"organization_code":"AM5","org_id":84},{"organization_code":"AM16W","org_id":289},{"organization_code":"PQD","org_id":414}]
/// hasMore : false
/// limit : 25
/// offset : 0
/// count : 4
/// links : [{"rel":"self","href":"https://artlive.artisticmilliners.com:8081/ords/art/fabric-library/orgs/"},{"rel":"describedby","href":"https://artlive.artisticmilliners.com:8081/ords/art/metadata-catalog/fabric-library/orgs/"},{"rel":"first","href":"https://artlive.artisticmilliners.com:8081/ords/art/fabric-library/orgs/"}]

class FabricLibUnitListModel {
  List<Fabric_lib_items> _fabricLibItems;
  bool _hasMore;
  int _limit;
  int _offset;
  int _count;
  List<Links> _links;

  List<Fabric_lib_items> get fabricLibItems => _fabricLibItems;
  bool get hasMore => _hasMore;
  int get limit => _limit;
  int get offset => _offset;
  int get count => _count;
  List<Links> get links => _links;

  FabricLibUnitListModel({
      List<Fabric_lib_items> fabricLibItems, 
      bool hasMore, 
      int limit, 
      int offset, 
      int count, 
      List<Links> links}){
    _fabricLibItems = fabricLibItems;
    _hasMore = hasMore;
    _limit = limit;
    _offset = offset;
    _count = count;
    _links = links;
}

  FabricLibUnitListModel.fromJson(dynamic json) {
    if (json["fabric_lib_items"] != null) {
      _fabricLibItems = [];
      json["fabric_lib_items"].forEach((v) {
        _fabricLibItems.add(Fabric_lib_items.fromJson(v));
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
    if (_fabricLibItems != null) {
      map["fabric_lib_items"] = _fabricLibItems.map((v) => v.toJson()).toList();
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
/// href : "https://artlive.artisticmilliners.com:8081/ords/art/fabric-library/orgs/"

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

/// organization_code : "AM2"
/// org_id : 83

class Fabric_lib_items {
  String _organizationCode;
  int _orgId;

  String get organizationCode => _organizationCode;
  int get orgId => _orgId;

  Fabric_lib_items({
      String organizationCode, 
      int orgId}){
    _organizationCode = organizationCode;
    _orgId = orgId;
}

  Fabric_lib_items.fromJson(dynamic json) {
    _organizationCode = json["organization_code"];
    _orgId = json["org_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["organization_code"] = _organizationCode;
    map["org_id"] = _orgId;
    return map;
  }
  static List<Fabric_lib_items> fromJsonList(List list) {
    return list.map((item) => Fabric_lib_items.fromJson(item)).toList();
  }

  String userAsString() {
    return '${this.organizationCode}';
  }

  bool isEqual(Fabric_lib_items model) {
    return this.organizationCode == model.organizationCode;
  }

}