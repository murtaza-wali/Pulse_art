// To parse this JSON data, do
//
//     final testing = testingFromJson(jsonString);

import 'dart:convert';

Testing testingFromJson(String str) => Testing.fromJson(json.decode(str));

String testingToJson(Testing data) => json.encode(data.toJson());

class Testing {
  Testing({
    this.testingitems,
    this.first,
  });

  List<Testingitem> testingitems;
  First first;

  factory Testing.fromJson(Map<String, dynamic> json) => Testing(
        testingitems: List<Testingitem>.from(
            json["Testingitems"].map((x) => Testingitem.fromJson(x))),
        first: First.fromJson(json["first"]),
      );

  Map<String, dynamic> toJson() => {
        "Testingitems": List<dynamic>.from(testingitems.map((x) => x.toJson())),
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

class Testingitem {
  Testingitem({
    this.notificationId,
    this.lineId,
    this.columnId,
    this.notfPrompt,
    this.notificationVal,
  });

  int notificationId;
  int lineId;
  int columnId;
  String notfPrompt;
  String notificationVal;

  factory Testingitem.fromJson(Map<String, dynamic> json) => Testingitem(
        notificationId: json["notification_id"],
        lineId: json["line_id"],
        columnId: json["column_id"],
        notfPrompt: json["notf_prompt"],
        notificationVal: json["notification_val"],
      );

  Map<String, dynamic> toJson() => {
        "notification_id": notificationId,
        "line_id": lineId,
        "column_id": columnId,
        "notf_prompt": notfPrompt,
        "notification_val": notificationVal,
      };
}
