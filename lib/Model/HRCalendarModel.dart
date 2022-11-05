// To parse this JSON data, do
//
//     final hrCalendarModel = hrCalendarModelFromJson(jsonString);

import 'dart:convert';

HrCalendarModel hrCalendarModelFromJson(String str) => HrCalendarModel.fromJson(json.decode(str));

String hrCalendarModelToJson(HrCalendarModel data) => json.encode(data.toJson());

class HrCalendarModel {
  HrCalendarModel({
    this.calendarItems,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<CalendarItem> calendarItems;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory HrCalendarModel.fromJson(Map<String, dynamic> json) => HrCalendarModel(
    calendarItems: List<CalendarItem>.from(json["Calendar_items"].map((x) => CalendarItem.fromJson(x))),
    hasMore: json["hasMore"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Calendar_items": List<dynamic>.from(calendarItems.map((x) => x.toJson())),
    "hasMore": hasMore,
    "limit": limit,
    "offset": offset,
    "count": count,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
  };
}

class CalendarItem {
  CalendarItem({
    this.sno,
    this.trainingId,
    this.trainingTitle,
    this.trainingDate,
    this.trainingDuration,
    this.companycode,
    this.locationId,
    this.groupTitle,
    this.trainingParticipants,
  });

  int sno;
  int trainingId;
  String trainingTitle;
  DateTime trainingDate;
  String trainingDuration;
  String companycode;
  int locationId;
  dynamic groupTitle;
  int trainingParticipants;

  factory CalendarItem.fromJson(Map<String, dynamic> json) => CalendarItem(
    sno: json["sno"],
    trainingId: json["training_id"],
    trainingTitle: json["training_title"],
    trainingDate: DateTime.parse(json["training_date"]),
    trainingDuration: json["training_duration"],
    companycode: json["companycode"],
    locationId: json["location_id"],
    groupTitle: json["group_title"],
    trainingParticipants: json["training_participants"],
  );

  Map<String, dynamic> toJson() => {
    "sno": sno,
    "training_id": trainingId,
    "training_title": trainingTitle,
    "training_date": trainingDate.toIso8601String(),
    "training_duration": trainingDuration,
    "companycode": companycode,
    "location_id": locationId,
    "group_title": groupTitle,
    "training_participants": trainingParticipants,
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
