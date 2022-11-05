/// deptitems : [{"department_name":"INFORMATION TECHNOLOGY","department_id":16}]
/// hasMore : false
/// limit : 100
/// offset : 0
/// count : 1
/// links : [{"rel":"self","href":"https://art.artisticmilliners.com:8081/ords/art/apis/ticket/dept/83"},{"rel":"describedby","href":"https://art.artisticmilliners.com:8081/ords/art/metadata-catalog/apis/ticket/dept/item"},{"rel":"first","href":"https://art.artisticmilliners.com:8081/ords/art/apis/ticket/dept/83"}]

class Department {
  List<Deptitems> _deptitems;
  bool _hasMore;
  int _limit;
  int _offset;
  int _count;
  List<Links> _links;

  List<Deptitems> get deptitems => _deptitems;
  bool get hasMore => _hasMore;
  int get limit => _limit;
  int get offset => _offset;
  int get count => _count;
  List<Links> get links => _links;

  Department({
      List<Deptitems> deptitems, 
      bool hasMore, 
      int limit, 
      int offset, 
      int count, 
      List<Links> links}){
    _deptitems = deptitems;
    _hasMore = hasMore;
    _limit = limit;
    _offset = offset;
    _count = count;
    _links = links;
}

  Department.fromJson(dynamic json) {
    if (json["deptitems"] != null) {
      _deptitems = [];
      json["deptitems"].forEach((v) {
        _deptitems.add(Deptitems.fromJson(v));
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
    if (_deptitems != null) {
      map["deptitems"] = _deptitems.map((v) => v.toJson()).toList();
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
/// href : "https://art.artisticmilliners.com:8081/ords/art/apis/ticket/dept/83"

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

/// department_name : "INFORMATION TECHNOLOGY"
/// department_id : 16

class Deptitems {
  String _departmentName;
  int _departmentId;

  String get departmentName => _departmentName;
  int get departmentId => _departmentId;

  Deptitems({
      String departmentName, 
      int departmentId}){
    _departmentName = departmentName;
    _departmentId = departmentId;
}

  Deptitems.fromJson(dynamic json) {
    _departmentName = json["department_name"];
    _departmentId = json["department_id"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["department_name"] = _departmentName;
    map["department_id"] = _departmentId;
    return map;
  }

}