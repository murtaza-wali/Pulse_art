// To parse this JSON data, do
//
//     final articleList = articleListFromJson(jsonString);

import 'dart:convert';

ArticleList articleListFromJson(String str) => ArticleList.fromJson(json.decode(str));

String articleListToJson(ArticleList data) => json.encode(data.toJson());

class ArticleList {
  ArticleList({
    this.articleitem,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<Articleitem> articleitem;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory ArticleList.fromJson(Map<String, dynamic> json) => ArticleList(
    articleitem: List<Articleitem>.from(json["Articleitem"].map((x) => Articleitem.fromJson(x))),
    hasMore: json["hasMore"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Articleitem": List<dynamic>.from(articleitem.map((x) => x.toJson())),
    "hasMore": hasMore,
    "limit": limit,
    "offset": offset,
    "count": count,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
  };
}

class Articleitem {
  Articleitem({
    this.fancyName,
    this.iid,
  });

  String fancyName;
  String iid;

  factory Articleitem.fromJson(Map<String, dynamic> json) => Articleitem(
    fancyName: json["fancy_name"],
    iid: json["iid"],
  );

  Map<String, dynamic> toJson() => {
    "fancy_name": fancyName,
    "iid": iid,
  };

  static List<Articleitem> fromJsonList(List list) {
    return list.map((item) => Articleitem.fromJson(item)).toList();
  }

  String userAsString() {
    return '${this.fancyName}';
  }

  bool isEqual(Articleitem model) {
    return this.fancyName == model.fancyName;
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
