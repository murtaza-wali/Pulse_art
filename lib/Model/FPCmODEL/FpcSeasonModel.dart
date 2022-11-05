// To parse this JSON data, do
//
//     final fpcSeasonModel = fpcSeasonModelFromJson(jsonString);

import 'dart:convert';

FpcSeasonModel fpcSeasonModelFromJson(String str) => FpcSeasonModel.fromJson(json.decode(str));

String fpcSeasonModelToJson(FpcSeasonModel data) => json.encode(data.toJson());

class FpcSeasonModel {
  FpcSeasonModel({
    this.fpcseasonitems,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<Fpcseasonitem> fpcseasonitems;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory FpcSeasonModel.fromJson(Map<String, dynamic> json) => FpcSeasonModel(
    fpcseasonitems: List<Fpcseasonitem>.from(json["fpcseasonitems"].map((x) => Fpcseasonitem.fromJson(x))),
    hasMore: json["hasMore"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "fpcseasonitems": List<dynamic>.from(fpcseasonitems.map((x) => x.toJson())),
    "hasMore": hasMore,
    "limit": limit,
    "offset": offset,
    "count": count,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
  };
}

class Fpcseasonitem {
  Fpcseasonitem({
    this.seasonName,
    this.seaCode,
  });

  String seasonName;
  String seaCode;

  factory Fpcseasonitem.fromJson(Map<String, dynamic> json) => Fpcseasonitem(
    seasonName: json["season_name"],
    seaCode: json["sea_code"],
  );

  Map<String, dynamic> toJson() => {
    "season_name": seasonName,
    "sea_code": seaCode,
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
