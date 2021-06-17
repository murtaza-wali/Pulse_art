// To parse this JSON data, do
//
//     final type = typeFromJson(jsonString);

import 'dart:convert';

Type typeFromJson(String str) => Type.fromJson(json.decode(str));

String typeToJson(Type data) => json.encode(data.toJson());

class Type {
  Type({
    this.typeitems,
    this.first,
  });

  List<Typeitem> typeitems;
  First first;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        typeitems: List<Typeitem>.from(
            json["typeitems"].map((x) => Typeitem.fromJson(x))),
        first: First.fromJson(json["first"]),
      );

  Map<String, dynamic> toJson() => {
        "typeitems": List<dynamic>.from(typeitems.map((x) => x.toJson())),
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

class Typeitem {
  Typeitem({
    this.type,
  });

  String type;

  factory Typeitem.fromJson(Map<String, dynamic> json) => Typeitem(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}
