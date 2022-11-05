// To parse this JSON data, do
//
//     final fpcBrandModel = fpcBrandModelFromJson(jsonString);

import 'dart:convert';

FpcBrandModel fpcBrandModelFromJson(String str) =>
    FpcBrandModel.fromJson(json.decode(str));

String fpcBrandModelToJson(FpcBrandModel data) => json.encode(data.toJson());

class FpcBrandModel {
  FpcBrandModel({
    this.fpcbranditems,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<Fpcbranditem> fpcbranditems;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory FpcBrandModel.fromJson(Map<String, dynamic> json) => FpcBrandModel(
        fpcbranditems: List<Fpcbranditem>.from(
            json["fpcbranditems"].map((x) => Fpcbranditem.fromJson(x))),
        hasMore: json["hasMore"],
        limit: json["limit"],
        offset: json["offset"],
        count: json["count"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fpcbranditems":
            List<dynamic>.from(fpcbranditems.map((x) => x.toJson())),
        "hasMore": hasMore,
        "limit": limit,
        "offset": offset,
        "count": count,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}

class Fpcbranditem {
  Fpcbranditem({
    this.baseBrand,
    this.bid,
  });

  String baseBrand;
  String bid;

  factory Fpcbranditem.fromJson(Map<String, dynamic> json) => Fpcbranditem(
        baseBrand: json["base_brand"],
        bid: json["bid"],
      );

  Map<String, dynamic> toJson() => {
        "base_brand": baseBrand,
        "bid": bid,
      };

  static List<Fpcbranditem> fromJsonList(List list) {
    return list.map((item) => Fpcbranditem.fromJson(item)).toList();
  }

  String userAsString() {
    return '${this.baseBrand}';
  }

  bool isEqual(Fpcbranditem model) {
    return this.baseBrand == model.baseBrand;
  }
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
