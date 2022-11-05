// To parse this JSON data, do
//
//     final fpcForwardToModel = fpcForwardToModelFromJson(jsonString);

import 'dart:convert';

FpcForwardToModel fpcForwardToModelFromJson(String str) => FpcForwardToModel.fromJson(json.decode(str));

String fpcForwardToModelToJson(FpcForwardToModel data) => json.encode(data.toJson());

class FpcForwardToModel {
  FpcForwardToModel({
    this.forwardtoitems,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<Forwardtoitem> forwardtoitems;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory FpcForwardToModel.fromJson(Map<String, dynamic> json) => FpcForwardToModel(
    forwardtoitems: List<Forwardtoitem>.from(json["forwardtoitems"].map((x) => Forwardtoitem.fromJson(x))),
    hasMore: json["hasMore"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "forwardtoitems": List<dynamic>.from(forwardtoitems.map((x) => x.toJson())),
    "hasMore": hasMore,
    "limit": limit,
    "offset": offset,
    "count": count,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
  };
}

class Forwardtoitem {
  Forwardtoitem({
    this.fndEmpnameAppsMUserId,
    this.userId,
  });

  String fndEmpnameAppsMUserId;
  int userId;

  factory Forwardtoitem.fromJson(Map<String, dynamic> json) => Forwardtoitem(
    fndEmpnameAppsMUserId: json["fnd_empname@apps(m.user_id)"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "fnd_empname@apps(m.user_id)": fndEmpnameAppsMUserId,
    "user_id": userId,
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
