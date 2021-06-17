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
    this.fromUser,
    this.sentDate,
    this.remarks,
    this.transactionId,
    this.hid,
  });

  String type;
  String subject;
  String fromUser;
  DateTime sentDate;
  String remarks;
  int transactionId;
  int hid;

  factory DataByTypeitem.fromJson(Map<String, dynamic> json) => DataByTypeitem(
    type: json["type"],
    subject: json["subject"],
    fromUser: json["from_user"],
    sentDate: DateTime.parse(json["sent_date"]),
    remarks: json["remarks"],
    transactionId: json["transaction_id"],
    hid: json["hid"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "subject": subject,
    "from_user": fromUser,
    "sent_date": sentDate.toIso8601String(),
    "remarks": remarks,
    "transaction_id": transactionId,
    "hid": hid,
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
