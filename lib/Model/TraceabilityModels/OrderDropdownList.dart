// To parse this JSON data, do
//
//     final orderList = orderListFromJson(jsonString);

import 'dart:convert';

OrderList orderListFromJson(String str) => OrderList.fromJson(json.decode(str));

String orderListToJson(OrderList data) => json.encode(data.toJson());

class OrderList {
  OrderList({
    this.orderitems,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<Orderitem> orderitems;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory OrderList.fromJson(Map<String, dynamic> json) => OrderList(
    orderitems: List<Orderitem>.from(json["Orderitems"].map((x) => Orderitem.fromJson(x))),
    hasMore: json["hasMore"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Orderitems": List<dynamic>.from(orderitems.map((x) => x.toJson())),
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

class Orderitem {
  Orderitem({
    this.orderNumber,
    this.headerId,
  });

  int orderNumber;
  int headerId;

  factory Orderitem.fromJson(Map<String, dynamic> json) => Orderitem(
    orderNumber: json["order_number"],
    headerId: json["header_id"],
  );

  Map<String, dynamic> toJson() => {
    "order_number": orderNumber,
    "header_id": headerId,
  };
  static List<Orderitem> fromJsonList(List list) {
    return list.map((item) => Orderitem.fromJson(item)).toList();
  }

  String userAsString() {
    return '${this.orderNumber}';
  }

  bool isEqual(Orderitem model) {
    return this.orderNumber == model.orderNumber;
  }
}
