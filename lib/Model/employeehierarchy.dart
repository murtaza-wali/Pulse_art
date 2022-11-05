// To parse this JSON data, do
//
//     final employeeHierarchy = employeeHierarchyFromJson(jsonString);

import 'dart:convert';

EmployeeHierarchy employeeHierarchyFromJson(String str) => EmployeeHierarchy.fromJson(json.decode(str));

String employeeHierarchyToJson(EmployeeHierarchy data) => json.encode(data.toJson());

class EmployeeHierarchy {
  EmployeeHierarchy({
    this.employeeHierarchyitem,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<EmployeeHierarchyitem> employeeHierarchyitem;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory EmployeeHierarchy.fromJson(Map<String, dynamic> json) => EmployeeHierarchy(
    employeeHierarchyitem: List<EmployeeHierarchyitem>.from(json["EmployeeHierarchyitem"].map((x) => EmployeeHierarchyitem.fromJson(x))),
    hasMore: json["hasMore"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "EmployeeHierarchyitem": List<dynamic>.from(employeeHierarchyitem.map((x) => x.toJson())),
    "hasMore": hasMore,
    "limit": limit,
    "offset": offset,
    "count": count,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
  };
}

class EmployeeHierarchyitem {
  EmployeeHierarchyitem({
    this.level,
    this.employeeName,
    this.employeecode,
    this.employeeid,
    this.reporttoemployeeid,
  });

  int level;
  String employeeName;
  String employeecode;
  int employeeid;
  int reporttoemployeeid;

  factory EmployeeHierarchyitem.fromJson(Map<String, dynamic> json) => EmployeeHierarchyitem(
    level: json["level"],
    employeeName: json["employee_name"],
    employeecode: json["employeecode"],
    employeeid: json["employeeid"],
    reporttoemployeeid: json["reporttoemployeeid"],
  );

  Map<String, dynamic> toJson() => {
    "level": level,
    "employee_name": employeeName,
    "employeecode": employeecode,
    "employeeid": employeeid,
    "reporttoemployeeid": reporttoemployeeid,
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
