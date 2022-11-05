// To parse this JSON data, do
//
//     final systemAttachedModel = systemAttachedModelFromJson(jsonString);

import 'dart:convert';

SystemAttachedModel systemAttachedModelFromJson(String str) => SystemAttachedModel.fromJson(json.decode(str));

String systemAttachedModelToJson(SystemAttachedModel data) => json.encode(data.toJson());

class SystemAttachedModel {
  SystemAttachedModel({
    this.systemAttachedModelitems,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<SystemAttachedModelitem> systemAttachedModelitems;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory SystemAttachedModel.fromJson(Map<String, dynamic> json) => SystemAttachedModel(
    systemAttachedModelitems: List<SystemAttachedModelitem>.from(json["systemAttachedModelitems"].map((x) => SystemAttachedModelitem.fromJson(x))),
    hasMore: json["hasMore"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "systemAttachedModelitems": List<dynamic>.from(systemAttachedModelitems.map((x) => x.toJson())),
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

class SystemAttachedModelitem {
  SystemAttachedModelitem({
    this.fileId,
    this.fileDescription,
    this.fileName,
    this.fileType,
  });

  int fileId;
  dynamic fileDescription;
  String fileName;
  String fileType;

  factory SystemAttachedModelitem.fromJson(Map<String, dynamic> json) => SystemAttachedModelitem(
    fileId: json["file_id"],
    fileDescription: json["file_description"],
    fileName: json["file_name"],
    fileType: json["file_type"],
  );

  Map<String, dynamic> toJson() => {
    "file_id": fileId,
    "file_description": fileDescription,
    "file_name": fileName,
    "file_type": fileType,
  };
}
