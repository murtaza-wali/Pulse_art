// To parse this JSON data, do
//
//     final pieChartvalue = pieChartvalueFromJson(jsonString);

import 'dart:convert';

PieChartvalue pieChartvalueFromJson(String str) =>
    PieChartvalue.fromJson(json.decode(str));

String pieChartvalueToJson(PieChartvalue data) => json.encode(data.toJson());

class PieChartvalue {
  PieChartvalue({
     this.pieChartitems,
     this.hasMore,
     this.limit,
     this.offset,
     this.count,
     this.links,
  });

  List<PieChartitem> pieChartitems;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory PieChartvalue.fromJson(Map<String, dynamic> json) => PieChartvalue(
        pieChartitems: List<PieChartitem>.from(
            json["pieChartitems"].map((x) => PieChartitem.fromJson(x))),
        hasMore: json["hasMore"],
        limit: json["limit"],
        offset: json["offset"],
        count: json["count"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pieChartitems":
            List<dynamic>.from(pieChartitems.map((x) => x.toJson())),
        "hasMore": hasMore,
        "limit": limit,
        "offset": offset,
        "count": count,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}

class Link {
  Link({
     this.rel,
     this.href,
  });

  String rel;
  String href;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        rel: json["rel"],
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "rel": rel,
        "href": href,
      };
}

class PieChartitem {
  PieChartitem({
     this.label1,
     this.colour,
     this.value1,
  });

  String label1;
  String colour;
  int value1;

  factory PieChartitem.fromJson(Map<String, dynamic> json) => PieChartitem(
        label1: json["label1"],
        colour: json["colour"],
        value1: json["value1"],
      );

  Map<String, dynamic> toJson() => {
        "label1": label1,
        "colour": colour,
        "value1": value1,
      };
}
