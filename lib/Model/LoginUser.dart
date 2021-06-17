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

