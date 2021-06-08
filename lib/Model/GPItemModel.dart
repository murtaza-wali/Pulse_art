// To parse this JSON data, do
//
//     final gpItemModel = gpItemModelFromJson(jsonString);

import 'dart:convert';

GpItemModel gpItemModelFromJson(String str) => GpItemModel.fromJson(json.decode(str));

String gpItemModelToJson(GpItemModel data) => json.encode(data.toJson());

class GpItemModel {
  GpItemModel({
    this.items,
    this.first,
  });

  List<GPItem> items;
  First first;

  factory GpItemModel.fromJson(Map<String, dynamic> json) => GpItemModel(
    items: List<GPItem>.from(json["items"].map((x) => GPItem.fromJson(x))),
    first: First.fromJson(json["first"]),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
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

class GPItem {
  GPItem({
    this.orgCode,
    this.sno,
    this.serialnopk,
    this.outdate,
    this.deptname,
    this.partyname,
    this.requestedBy,
    this.rtnable,
    this.authorisedBy,
    this.approvedStatus,
  });

  String orgCode;
  String sno;
  int serialnopk;
  DateTime outdate;
  String deptname;
  String partyname;
  String requestedBy;
  String rtnable;
  String authorisedBy;
  String approvedStatus;

  factory GPItem.fromJson(Map<String, dynamic> json) => GPItem(
    orgCode: json["org_code"],
    sno: json["sno"],
    serialnopk: json["serialnopk"],
    outdate: DateTime.parse(json["outdate"]),
    deptname: json["deptname"],
    partyname: json["partyname"],
    requestedBy: json["requested_by"],
    rtnable: json["rtnable"],
    authorisedBy: json["authorised_by"],
    approvedStatus: json["approved_status"],
  );

  Map<String, dynamic> toJson() => {
    "org_code": orgCode,
    "sno": sno,
    "serialnopk": serialnopk,
    "outdate": outdate.toIso8601String(),
    "deptname": deptname,
    "partyname": partyname,
    "requested_by": requestedBy,
    "rtnable": rtnable,
    "authorised_by": authorisedBy,
    "approved_status": approvedStatus,
  };
}
