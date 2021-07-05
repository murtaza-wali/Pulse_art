// To parse this JSON data, do
//
//     final dataByType = dataByTypeFromJson(jsonString);

import 'dart:convert';

DataByType dataByTypeFromJson(String str) => DataByType.fromJson(json.decode(str));

String dataByTypeToJson(DataByType data) => json.encode(data.toJson());

class DataByType {
  DataByType({
    this.dataByTypeitem,
    this.first,
  });

  List<DataByTypeitem> dataByTypeitem;
  First first;

  factory DataByType.fromJson(Map<String, dynamic> json) => DataByType(
    dataByTypeitem: List<DataByTypeitem>.from(json["DataByTypeitem"].map((x) => DataByTypeitem.fromJson(x))),
    first: First.fromJson(json["first"]),
  );

  Map<String, dynamic> toJson() => {
    "DataByTypeitem": List<dynamic>.from(dataByTypeitem.map((x) => x.toJson())),
    "first": first.toJson(),
  };
}

class DataByTypeitem {
  DataByTypeitem({
    this.type,
    this.subject,
    this.fromUserName,
    this.sentDate,
    this.remarks,
    this.transactionId,
    this.hid,
    this.departmentName,
    this.documentNumber,
    this.notificationId,
    this.forwarderRemarks,
  });

  String type;
  String subject;
  String fromUserName;
  DateTime sentDate;
  dynamic remarks;
  int transactionId;
  int hid;
  String departmentName;
  String documentNumber;
  int notificationId;
  String forwarderRemarks;

  factory DataByTypeitem.fromJson(Map<String, dynamic> json) => DataByTypeitem(
    type: json["type"],
    subject: json["subject"],
    fromUserName: json["from_user_name"],
    sentDate: DateTime.parse(json["sent_date"]),
    remarks: json["remarks"],
    transactionId: json["transaction_id"],
    hid: json["hid"],
    departmentName: json["department_name"],
    documentNumber: json["document_number"],
    notificationId: json["notification_id"],
    forwarderRemarks: json["forwarder_remarks"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "subject": subject,
    "from_user_name": fromUserName,
    "sent_date": sentDate.toIso8601String(),
    "remarks": remarks,
    "transaction_id": transactionId,
    "hid": hid,
    "department_name": departmentName,
    "document_number": documentNumber,
    "notification_id": notificationId,
    "forwarder_remarks": forwarderRemarks,
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
