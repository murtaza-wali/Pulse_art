// To parse this JSON data, do
//
//     final trainingList = trainingListFromJson(jsonString);

import 'dart:convert';

TrainingList trainingListFromJson(String str) => TrainingList.fromJson(json.decode(str));

String trainingListToJson(TrainingList data) => json.encode(data.toJson());

class TrainingList {
  TrainingList({
    this.trainingListitems,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<TrainingListitem> trainingListitems;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory TrainingList.fromJson(Map<String, dynamic> json) => TrainingList(
    trainingListitems: List<TrainingListitem>.from(json["trainingListitems"].map((x) => TrainingListitem.fromJson(x))),
    hasMore: json["hasMore"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "trainingListitems": List<dynamic>.from(trainingListitems.map((x) => x.toJson())),
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

class TrainingListitem {
  TrainingListitem({
    this.trainingTitle,
    this.scheduleId,
  });

  String trainingTitle;
  int scheduleId;

  factory TrainingListitem.fromJson(Map<String, dynamic> json) => TrainingListitem(
    trainingTitle: json["training_title"],
    scheduleId: json["schedule_id"],
  );

  Map<String, dynamic> toJson() => {
    "training_title": trainingTitle,
    "schedule_id": scheduleId,
  };
}
