// To parse this JSON data, do
//
//     final menuCards = menuCardsFromJson(jsonString);

import 'dart:convert';

MenuCards menuCardsFromJson(String str) => MenuCards.fromJson(json.decode(str));

String menuCardsToJson(MenuCards data) => json.encode(data.toJson());

class MenuCards {
  MenuCards({
    this.items,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<CardsMenuItem> items;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory MenuCards.fromJson(Map<String, dynamic> json) => MenuCards(
    items: List<CardsMenuItem>.from(json["items"].map((x) => CardsMenuItem.fromJson(x))),
    hasMore: json["hasMore"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "hasMore": hasMore,
    "limit": limit,
    "offset": offset,
    "count": count,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
  };
}

class CardsMenuItem {
  CardsMenuItem({
    this.applicationName,
    this.applicationId,
    this.logo,
    this.loginUrl,
    this.applicationPage,
    this.isPublic,
    this.sno,
  });

  String applicationName;
  int applicationId;
  String logo;
  String loginUrl;
  dynamic applicationPage;
  IsPublic isPublic;
  int sno;

  factory CardsMenuItem.fromJson(Map<String, dynamic> json) => CardsMenuItem(
    applicationName: json["application_name"],
    applicationId: json["application_id"],
    logo: json["logo"],
    loginUrl: json["login_url"] == null ? null : json["login_url"],
    applicationPage: json["application_page"],
    isPublic: isPublicValues.map[json["is_public"]],
    sno: json["sno"],
  );

  Map<String, dynamic> toJson() => {
    "application_name": applicationName,
    "application_id": applicationId,
    "logo": logo,
    "login_url": loginUrl == null ? null : loginUrl,
    "application_page": applicationPage,
    "is_public": isPublicValues.reverse[isPublic],
    "sno": sno,
  };
}

enum IsPublic { N, Y }

final isPublicValues = EnumValues({
  "N": IsPublic.N,
  "Y": IsPublic.Y
});

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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
