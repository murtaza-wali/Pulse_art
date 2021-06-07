// To parse this JSON data, do
//
//     final loginUser = loginUserFromJson(jsonString);

import 'dart:convert';

LoginUser loginUserFromJson(String str) => LoginUser.fromJson(json.decode(str));

String loginUserToJson(LoginUser data) => json.encode(data.toJson());

class LoginUser {
  LoginUser({
    this.items,
    this.first,
  });

  List<Item> items;
  First first;

  factory LoginUser.fromJson(Map<String, dynamic> json) => LoginUser(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    first: First.fromJson(json["first"]),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "first": first.toJson(),
  };
}

class First {
  First({
    this.ref,
  });

  String ref;

  factory First.fromJson(Map<String, dynamic> json) => First(
    ref: json["\u0024ref"],
  );

  Map<String, dynamic> toJson() => {
    "\u0024ref": ref,
  };
}

class Item {
  Item({
    this.userId,
    this.userName,
    this.empname,
    this.dept,
  });

  int userId;
  String userName;
  String empname;
  String dept;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    userId: json["user_id"],
    userName: json["user_name"],
    empname: json["empname"],
    dept: json["dept"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "user_name": userName,
    "empname": empname,
    "dept": dept,
  };
}
