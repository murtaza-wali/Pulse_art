// To parse this JSON data, do
//
//     final workboardTicket = workboardTicketFromJson(jsonString);

import 'dart:convert';

WorkboardTicket workboardTicketFromJson(String str) => WorkboardTicket.fromJson(json.decode(str));

String workboardTicketToJson(WorkboardTicket data) => json.encode(data.toJson());

class WorkboardTicket {
  WorkboardTicket({
    this.workboardticketitems,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<Workboardticketitem> workboardticketitems;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory WorkboardTicket.fromJson(Map<String, dynamic> json) => WorkboardTicket(
    workboardticketitems: List<Workboardticketitem>.from(json["Workboardticketitems"].map((x) => Workboardticketitem.fromJson(x))),
    hasMore: json["hasMore"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "Workboardticketitems": List<dynamic>.from(workboardticketitems.map((x) => x.toJson())),
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

class Workboardticketitem {
  Workboardticketitem({
    this.ticketId,
    this.unit,
    this.fromDepartment,
    this.toDepartment,
    this.complainType,
    this.description,
    this.statusId,
    this.creationDate,
    this.lastUpdatedBy,
    this.updationDate,
    this.ticketDate,
    this.ticketBy,
    this.subject,
    this.severity,
    this.toDepartmentId,
    this.orgId,
    this.assignTo,
    this.ticketDeadline,
    this.completionDate,
  });

  int ticketId;
  String unit;
  String fromDepartment;
  dynamic toDepartment;
  dynamic complainType;
  String description;
  String statusId;
  DateTime creationDate;
  String lastUpdatedBy;
  DateTime updationDate;
  DateTime ticketDate;
  String ticketBy;
  String subject;
  String severity;
  int toDepartmentId;
  int orgId;
  String assignTo;
  DateTime ticketDeadline;
  dynamic completionDate;

  factory Workboardticketitem.fromJson(Map<String, dynamic> json) => Workboardticketitem(
    ticketId: json["ticket_id"],
    unit: json["unit"],
    fromDepartment: json["from_department"],
    toDepartment: json["to_department"],
    complainType: json["complain_type"],
    description: json["description"],
    statusId: json["status_id"],
    creationDate: DateTime.parse(json["creation_date"]),
    lastUpdatedBy: json["last_updated_by"],
    updationDate: DateTime.parse(json["updation_date"]),
    ticketDate: DateTime.parse(json["ticket_date"]),
    ticketBy: json["ticket_by"],
    subject: json["subject"],
    severity: json["severity"],
    toDepartmentId: json["to_department_id"],
    orgId: json["org_id"],
    assignTo: json["assign_to"],
    ticketDeadline: DateTime.parse(json["ticket_deadline"]),
    completionDate: json["completion_date"],
  );

  Map<String, dynamic> toJson() => {
    "ticket_id": ticketId,
    "unit": unit,
    "from_department": fromDepartment,
    "to_department": toDepartment,
    "complain_type": complainType,
    "description": description,
    "status_id": statusId,
    "creation_date": creationDate.toIso8601String(),
    "last_updated_by": lastUpdatedBy,
    "updation_date": updationDate.toIso8601String(),
    "ticket_date": ticketDate.toIso8601String(),
    "ticket_by": ticketBy,
    "subject": subject,
    "severity": severity,
    "to_department_id": toDepartmentId,
    "org_id": orgId,
    "assign_to": assignTo,
    "ticket_deadline": ticketDeadline.toIso8601String(),
    "completion_date": completionDate,
  };
}
