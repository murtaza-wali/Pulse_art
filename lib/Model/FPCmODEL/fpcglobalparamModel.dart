// To parse this JSON data, do
//
//     final fpcglobalparamModel = fpcglobalparamModelFromJson(jsonString);

import 'dart:convert';

FpcglobalparamModel fpcglobalparamModelFromJson(String str) => FpcglobalparamModel.fromJson(json.decode(str));

String fpcglobalparamModelToJson(FpcglobalparamModel data) => json.encode(data.toJson());

class FpcglobalparamModel {
  FpcglobalparamModel({
    this.globalparamitems,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<Globalparamitem> globalparamitems;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory FpcglobalparamModel.fromJson(Map<String, dynamic> json) => FpcglobalparamModel(
    globalparamitems: List<Globalparamitem>.from(json["globalparamitems"].map((x) => Globalparamitem.fromJson(x))),
    hasMore: json["hasMore"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "globalparamitems": List<dynamic>.from(globalparamitems.map((x) => x.toJson())),
    "hasMore": hasMore,
    "limit": limit,
    "offset": offset,
    "count": count,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
  };
}

class Globalparamitem {
  Globalparamitem({
    this.headerId,
    this.hSeq,
  });

  int headerId;
  int hSeq;

  factory Globalparamitem.fromJson(Map<String, dynamic> json) => Globalparamitem(
    headerId: json["header_id"],
    hSeq: json["h_seq"],
  );

  Map<String, dynamic> toJson() => {
    "header_id": headerId,
    "h_seq": hSeq,
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
