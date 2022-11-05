// To parse this JSON data, do
//
//     final attendence = attendenceFromJson(jsonString);

import 'dart:convert';

Attendence attendenceFromJson(String str) =>
    Attendence.fromJson(json.decode(str));

String attendenceToJson(Attendence data) => json.encode(data.toJson());

class Attendence {
  Attendence({
    this.attendenceitem,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<Attendenceitem> attendenceitem;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory Attendence.fromJson(Map<String, dynamic> json) => Attendence(
        attendenceitem: List<Attendenceitem>.from(
            json["Attendenceitem"].map((x) => Attendenceitem.fromJson(x))),
        hasMore: json["hasMore"],
        limit: json["limit"],
        offset: json["offset"],
        count: json["count"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Attendenceitem":
            List<dynamic>.from(attendenceitem.map((x) => x.toJson())),
        "hasMore": hasMore,
        "limit": limit,
        "offset": offset,
        "count": count,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
      };
}

class Attendenceitem {
  Attendenceitem({
    this.employeeCode,
    this.employeeName,
    this.attendanceDate,
    this.timeIn,
    this.timeOut,
    this.status,
    this.isGazDay,
    this.isPresent,
    this.isHalfDay,
    this.isWithPy,
    this.isLeave,
    this.isLate,
  });

  String employeeCode;
  EmployeeName employeeName;
  DateTime attendanceDate;
  String timeIn;
  String timeOut;
  String status;
  int isGazDay;
  int isPresent;
  int isHalfDay;
  int isWithPy;
  double isLeave;
  int isLate;

  factory Attendenceitem.fromJson(Map<String, dynamic> json) => Attendenceitem(
        employeeCode: json["employee_code"],
        employeeName: employeeNameValues.map[json["employee_name"]],
        attendanceDate: DateTime.parse(json["attendance_date"]),
        timeIn: json["time_in"] == null ? null : json["time_in"],
        timeOut: json["time_out"] == null ? null : json["time_out"],
        status: json["status"],
        isGazDay: json["is_gaz_day"],
        isPresent: json["is_present"],
        isHalfDay: json["is_half_day"],
        isWithPy: json["is_with_py"],
        isLeave: json["is_leave"].toDouble(),
        isLate: json["is_late"],
      );

  Map<String, dynamic> toJson() => {
        "employee_code": employeeCode,
        "employee_name": employeeNameValues.reverse[employeeName],
        "attendance_date": attendanceDate.toIso8601String(),
        "time_in": timeIn == null ? null : timeIn,
        "time_out": timeOut == null ? null : timeOut,
        "status": status,
        "is_gaz_day": isGazDay,
        "is_present": isPresent,
        "is_half_day": isHalfDay,
        "is_with_py": isWithPy,
        "is_leave": isLeave,
        "is_late": isLate,
      };
}

enum EmployeeName { SYED_AMMAD_UDDIN_GRAMI }

final employeeNameValues =
    EnumValues({"Syed Ammad Uddin Grami": EmployeeName.SYED_AMMAD_UDDIN_GRAMI});

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
