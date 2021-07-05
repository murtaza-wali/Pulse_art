// To parse this JSON data, do
//
//     final testingline = testinglineFromJson(jsonString);

import 'dart:convert';

Testingline testinglineFromJson(String str) => Testingline.fromJson(json.decode(str));

String testinglineToJson(Testingline data) => json.encode(data.toJson());

class Testingline {
  Testingline({
    this.lineitems,
    this.first,
  });

  List<Lineitem> lineitems;
  First first;

  factory Testingline.fromJson(Map<String, dynamic> json) => Testingline(
    lineitems: List<Lineitem>.from(json["lineitems"].map((x) => Lineitem.fromJson(x))),
    first: First.fromJson(json["first"]),
  );

  Map<String, dynamic> toJson() => {
    "lineitems": List<dynamic>.from(lineitems.map((x) => x.toJson())),
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

class Lineitem {
  Lineitem({
    this.notificationId,
    this.lineId,
  });

  int notificationId;
  int lineId;

  factory Lineitem.fromJson(Map<String, dynamic> json) => Lineitem(
    notificationId: json["notification_id"],
    lineId: json["line_id"],
  );

  Map<String, dynamic> toJson() => {
    "notification_id": notificationId,
    "line_id": lineId,
  };
}
