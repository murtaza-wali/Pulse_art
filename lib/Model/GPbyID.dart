// To parse this JSON data, do
//
//     final gPbyId = gPbyIdFromJson(jsonString);

import 'dart:convert';

GPbyId gPbyIdFromJson(String str) => GPbyId.fromJson(json.decode(str));

String gPbyIdToJson(GPbyId data) => json.encode(data.toJson());

class GPbyId {
  GPbyId({
    this.gPbyIDitems,
    this.first,
  });

  List<GPbyIDitem> gPbyIDitems;
  First first;

  factory GPbyId.fromJson(Map<String, dynamic> json) => GPbyId(
    gPbyIDitems: List<GPbyIDitem>.from(json["GPbyIDitems"].map((x) => GPbyIDitem.fromJson(x))),
    first: First.fromJson(json["first"]),
  );

  Map<String, dynamic> toJson() => {
    "GPbyIDitems": List<dynamic>.from(gPbyIDitems.map((x) => x.toJson())),
    "first": first.toJson(),
  };
}

class First {
  First({
    this.ref,
  });

  String ref;

  factory First.fromJson(Map<String, dynamic> json) => First(
    ref: json["\u0024ref"],
  );

  Map<String, dynamic> toJson() => {
    "\u0024ref": ref,
  };
}

class GPbyIDitem {
  GPbyIDitem({
    this.requisitionNumber,
    this.unitName,
    this.deptName,
    this.description,
    this.documentDate,
    this.preparerRemarks,
    this.orgId,
    this.departmentId,
    this.transactionId,
    this.preparer,
  });

  int requisitionNumber;
  String unitName;
  String deptName;
  String description;
  DateTime documentDate;
  String preparerRemarks;
  int orgId;
  int departmentId;
  int transactionId;
  String preparer;

  factory GPbyIDitem.fromJson(Map<String, dynamic> json) => GPbyIDitem(
    requisitionNumber: json["requisition_number"],
    unitName: json["unit_name"],
    deptName: json["dept_name"],
    description: json["description"],
    documentDate: DateTime.parse(json["document_date"]),
    preparerRemarks: json["preparer_remarks"],
    orgId: json["org_id"],
    departmentId: json["department_id"],
    transactionId: json["transaction_id"],
    preparer: json["preparer"],
  );

  Map<String, dynamic> toJson() => {
    "requisition_number": requisitionNumber,
    "unit_name": unitName,
    "dept_name": deptName,
    "description": description,
    "document_date": documentDate.toIso8601String(),
    "preparer_remarks": preparerRemarks,
    "org_id": orgId,
    "department_id": departmentId,
    "transaction_id": transactionId,
    "preparer": preparer,
  };
}
