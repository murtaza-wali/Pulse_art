// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);
/// items : [{"user_id":"5118","user_name":"ERPDEV5","empname":"Taha Siddiqui","dept":"I.T (E.R.P)","rtn_val":0}]
/// first : {"$ref":"https://artlive.artisticmilliners.com:8081/ords/art/apis/auth/erpdev5/TJ182021"}
/// Loginitems : [{"user_id":"5118","user_name":"ERPDEV5","empname":"Taha Siddiqui","dept":"I.T (E.R.P)","rtn_val":0}]
/// first : {"$ref":"https://artlive.artisticmilliners.com:8081/ords/art/apis/auth/erpdev5/TJ182021"}

class LOGINitem {
  List<Loginitems> _loginitems;
  First _first;

  List<Loginitems> get loginitems => _loginitems;
  First get first => _first;

  LOGINitem({
    List<Loginitems> loginitems,
    First first}){
    _loginitems = loginitems;
    _first = first;
  }

  LOGINitem.fromJson(dynamic json) {
    if (json["Loginitems"] != null) {
      _loginitems = [];
      json["Loginitems"].forEach((v) {
        _loginitems.add(Loginitems.fromJson(v));
      });
    }
    _first = json["first"] != null ? First.fromJson(json["first"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_loginitems != null) {
      map["Loginitems"] = _loginitems.map((v) => v.toJson()).toList();
    }
    if (_first != null) {
      map["first"] = _first.toJson();
    }
    return map;
  }

}

/// $ref : "https://artlive.artisticmilliners.com:8081/ords/art/apis/auth/erpdev5/TJ182021"

class First {
  String _$ref;

  String get $ref => _$ref;

  First({
    String $ref}){
    _$ref = $ref;
  }

  First.fromJson(dynamic json) {
    _$ref = json["\u0024ref"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["\u0024ref"] = _$ref;
    return map;
  }

}

/// user_id : "5118"
/// user_name : "ERPDEV5"
/// empname : "Taha Siddiqui"
/// dept : "I.T (E.R.P)"
/// rtn_val : 0

class Loginitems {
  String _userId;
  String _userName;
  String _empname;
  String _dept;
  int _rtnVal;

  String get userId => _userId;
  String get userName => _userName;
  String get empname => _empname;
  String get dept => _dept;
  int get rtnVal => _rtnVal;

  Loginitems({
    String userId,
    String userName,
    String empname,
    String dept,
    int rtnVal}){
    _userId = userId;
    _userName = userName;
    _empname = empname;
    _dept = dept;
    _rtnVal = rtnVal;
  }

  Loginitems.fromJson(dynamic json) {
    _userId = json["user_id"];
    _userName = json["user_name"];
    _empname = json["empname"];
    _dept = json["dept"];
    _rtnVal = json["rtn_val"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user_id"] = _userId;
    map["user_name"] = _userName;
    map["empname"] = _empname;
    map["dept"] = _dept;
    map["rtn_val"] = _rtnVal;
    return map;
  }

}
class user {
  user({
    this.id,
    this.user_id,
    this.user_name,
    this.status,
  });

  int id;
  int user_id;
  String user_name;
  int status;

  user.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        user_id = res["user_id"],
        user_name = res["name"],
        status = res["status"];

  Map<String, Object> toMap() {
    return {'id': id, 'user_id': user_id, 'name': user_name, 'status': status};
  }
}