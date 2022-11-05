// To parse this JSON data, do
//
//     final damUnitList = damUnitListFromJson(jsonString);

import 'dart:convert';

DamUnitList damUnitListFromJson(String str) => DamUnitList.fromJson(json.decode(str));

String damUnitListToJson(DamUnitList data) => json.encode(data.toJson());

class DamUnitList {
  DamUnitList({
    this.damUnitListitems,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<DamUnitListitem> damUnitListitems;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory DamUnitList.fromJson(Map<String, dynamic> json) => DamUnitList(
    damUnitListitems: List<DamUnitListitem>.from(json["DamUnitListitems"].map((x) => DamUnitListitem.fromJson(x))),
    hasMore: json["hasMore"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "DamUnitListitems": List<dynamic>.from(damUnitListitems.map((x) => x.toJson())),
    "hasMore": hasMore,
    "limit": limit,
    "offset": offset,
    "count": count,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
  };
}

class DamUnitListitem {
  DamUnitListitem({
    this.companycode,
    this.orgId,
  });

  String companycode;
  int orgId;

  factory DamUnitListitem.fromJson(Map<String, dynamic> json) => DamUnitListitem(
    companycode: json["companycode"],
    orgId: json["org_id"],
  );

  Map<String, dynamic> toJson() => {
    "companycode": companycode,
    "org_id": orgId,
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
