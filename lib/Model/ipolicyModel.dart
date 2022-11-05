// To parse this JSON data, do
//
//     final policyhub = policyhubFromJson(jsonString);

import 'dart:convert';

Policyhub policyhubFromJson(String str) => Policyhub.fromJson(json.decode(str));

String policyhubToJson(Policyhub data) => json.encode(data.toJson());

class Policyhub {
  Policyhub({
    this.iPolicyitems,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<IPolicyitem> iPolicyitems;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory Policyhub.fromJson(Map<String, dynamic> json) => Policyhub(
    iPolicyitems: List<IPolicyitem>.from(json["iPolicyitems"].map((x) => IPolicyitem.fromJson(x))),
    hasMore: json["hasMore"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "iPolicyitems": List<dynamic>.from(iPolicyitems.map((x) => x.toJson())),
    "hasMore": hasMore,
    "limit": limit,
    "offset": offset,
    "count": count,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
  };
}

class IPolicyitem {
  IPolicyitem({
    this.categoryId,
    this.categoryTitle,
    this.policyId,
    this.title,
    this.docNo,
    this.cdt,
    this.fileId,
    this.attachmentFile,
    this.subcat,
  });

  int categoryId;
  String categoryTitle;
  int policyId;
  String title;
  String docNo;
  String cdt;
  int fileId;
  String attachmentFile;
  int subcat;

  factory IPolicyitem.fromJson(Map<String, dynamic> json) => IPolicyitem(
    categoryId: json["category_id"],
    categoryTitle: json["category_title"],
    policyId: json["policy_id"],
    title: json["title"],
    docNo: json["doc_no"],
    cdt: json["cdt"],
    fileId: json["file_id"],
    attachmentFile: json["attachment_file"],
    subcat: json["subcat"],
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category_title": categoryTitle,
    "policy_id": policyId,
    "title": title,
    "doc_no": docNo,
    "cdt": cdt,
    "file_id": fileId,
    "attachment_file": attachmentFile,
    "subcat": subcat,
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
