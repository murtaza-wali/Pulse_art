// To parse this JSON data, do
//
//     final attendenceTotal = attendenceTotalFromJson(jsonString);

import 'dart:convert';

AttendenceTotal attendenceTotalFromJson(String str) => AttendenceTotal.fromJson(json.decode(str));

String attendenceTotalToJson(AttendenceTotal data) => json.encode(data.toJson());

class AttendenceTotal {
  AttendenceTotal({
    this.attendenceTotalitems,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<AttendenceTotalitem> attendenceTotalitems;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory AttendenceTotal.fromJson(Map<String, dynamic> json) => AttendenceTotal(
    attendenceTotalitems: List<AttendenceTotalitem>.from(json["attendenceTotalitems"].map((x) => AttendenceTotalitem.fromJson(x))),
    hasMore: json["hasMore"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "attendenceTotalitems": List<dynamic>.from(attendenceTotalitems.map((x) => x.toJson())),
    "hasMore": hasMore,
    "limit": limit,
    "offset": offset,
    "count": count,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
  };
}

class AttendenceTotalitem {
  AttendenceTotalitem({
    this.presents,
    this.absents,
    this.halfDays,
    this.lates,
  });

  double presents;
  double absents;
  int halfDays;
  int lates;

  factory AttendenceTotalitem.fromJson(Map<String, dynamic> json) => AttendenceTotalitem(
    presents: json["presents"].toDouble(),
    absents: json["absents"].toDouble(),
    halfDays: json["half_days"],
    lates: json["lates"],
  );

  Map<String, dynamic> toJson() => {
    "presents": presents,
    "absents": absents,
    "half_days": halfDays,
    "lates": lates,
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
