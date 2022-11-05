/// AssignItems : [{"ename":"ZAIN UL ABDEEN - 3502000618 - OPERATOR CUM TECHNICIAN - INFORMATION TECHNOLOGY","employeecode":"3502000618"},{"ename":"SYED MAZHAR ALI - 0102000270 - SR. MANAGER - INFORMATION TECHNOLOGY","employeecode":"0102000270"},{"ename":"SYED MUHAMMAD TAHA ALI SHAH - 0102000287 - ASST. MANAGER - INFORMATION TECHNOLOGY","employeecode":"0102000287"},{"ename":"MIRZA REHAN BAIG - 0102000638 - OFFICER - INFORMATION TECHNOLOGY","employeecode":"0102000638"},{"ename":"MEHMOOD SHEIKH - 0102000731 - MANAGER - INFORMATION TECHNOLOGY","employeecode":"0102000731"},{"ename":"MUHAMMAD ABDUL TAMIR - 0102000732 - MANAGER - INFORMATION TECHNOLOGY","employeecode":"0102000732"},{"ename":"UZAIR AHMED - 3502000154 - COMPUTER OPERATOR - INFORMATION TECHNOLOGY","employeecode":"3502000154"},{"ename":"SADIQ KHAN - 0102000987 - INCHARGE - INFORMATION TECHNOLOGY","employeecode":"0102000987"},{"ename":"S M WASI HAIDER - 3502000393 - COMPUTER OPERATOR - INFORMATION TECHNOLOGY","employeecode":"3502000393"},{"ename":"MUHAMMAD HASSAN KHAN - 0102000895 - EXECUTIVE - INFORMATION TECHNOLOGY","employeecode":"0102000895"},{"ename":"MUHAMMAD AHMER - 0102000984 - TRAINEE - INFORMATION TECHNOLOGY","employeecode":"0102000984"},{"ename":"MUHAMMAD SHAROZ IQBAL - 3502001114 - COMPUTER OPERATOR - INFORMATION TECHNOLOGY","employeecode":"3502001114"},{"ename":"MUHAMMAD SALMAN - 3502001135 - COMPUTER OPERATOR - INFORMATION TECHNOLOGY","employeecode":"3502001135"},{"ename":"MUHAMMAD TALHA - 3502001144 - COMPUTER OPERATOR - INFORMATION TECHNOLOGY","employeecode":"3502001144"},{"ename":"MUHAMMAD AMEER HAMZA - 3502001178 - TRAINEE - INFORMATION TECHNOLOGY","employeecode":"3502001178"},{"ename":"ZUHAIB HUSSAIN - 3502001305 - OPERATOR - INFORMATION TECHNOLOGY","employeecode":"3502001305"},{"ename":"WAQAS AHMED - 0101000186 - INTERN - INFORMATION TECHNOLOGY","employeecode":"0101000186"}]
/// hasMore : false
/// limit : 100
/// offset : 0
/// count : 17
/// links : [{"rel":"self","href":"https://art.artisticmilliners.com:8081/ords/art/apis/ticket/assign/83/16"},{"rel":"describedby","href":"https://art.artisticmilliners.com:8081/ords/art/metadata-catalog/apis/ticket/assign/83/item"},{"rel":"first","href":"https://art.artisticmilliners.com:8081/ords/art/apis/ticket/assign/83/16"}]

class Assign {
  List<AssignItems> _assignItems;
  bool _hasMore;
  int _limit;
  int _offset;
  int _count;
  List<Links> _links;

  List<AssignItems> get assignItems => _assignItems;
  bool get hasMore => _hasMore;
  int get limit => _limit;
  int get offset => _offset;
  int get count => _count;
  List<Links> get links => _links;

  Assign({
      List<AssignItems> assignItems, 
      bool hasMore, 
      int limit, 
      int offset, 
      int count, 
      List<Links> links}){
    _assignItems = assignItems;
    _hasMore = hasMore;
    _limit = limit;
    _offset = offset;
    _count = count;
    _links = links;
}

  Assign.fromJson(dynamic json) {
    if (json["AssignItems"] != null) {
      _assignItems = [];
      json["AssignItems"].forEach((v) {
        _assignItems.add(AssignItems.fromJson(v));
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
    if (_assignItems != null) {
      map["AssignItems"] = _assignItems.map((v) => v.toJson()).toList();
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
/// href : "https://art.artisticmilliners.com:8081/ords/art/apis/ticket/assign/83/16"

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

/// ename : "ZAIN UL ABDEEN - 3502000618 - OPERATOR CUM TECHNICIAN - INFORMATION TECHNOLOGY"
/// employeecode : "3502000618"

class AssignItems {
  String _ename;
  String _employeecode;

  String get ename => _ename;
  String get employeecode => _employeecode;

  AssignItems({
      String ename, 
      String employeecode}){
    _ename = ename;
    _employeecode = employeecode;
}

  AssignItems.fromJson(dynamic json) {
    _ename = json["ename"];
    _employeecode = json["employeecode"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["ename"] = _ename;
    map["employeecode"] = _employeecode;
    return map;
  }

}