// To parse this JSON data, do
//
//     final dataByTypeModel = dataByTypeModelFromJson(jsonString);

import 'dart:convert';

DataByTypeModel dataByTypeModelFromJson(String str) => DataByTypeModel.fromJson(json.decode(str));

String dataByTypeModelToJson(DataByTypeModel data) => json.encode(data.toJson());

class DataByTypeModel {
  DataByTypeModel({
    this.dataByTypeitem,
    this.hasMore,
    this.limit,
    this.offset,
    this.count,
    this.links,
  });

  List<DataByTypeitem> dataByTypeitem;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Link> links;

  factory DataByTypeModel.fromJson(Map<String, dynamic> json) => DataByTypeModel(
    dataByTypeitem: List<DataByTypeitem>.from(json["DataByTypeitem"].map((x) => DataByTypeitem.fromJson(x))),
    hasMore: json["hasMore"],
    limit: json["limit"],
    offset: json["offset"],
    count: json["count"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "DataByTypeitem": List<dynamic>.from(dataByTypeitem.map((x) => x.toJson())),
    "hasMore": hasMore,
    "limit": limit,
    "offset": offset,
    "count": count,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
  };
}

class DataByTypeitem {
  DataByTypeitem({
    this.type,
    this.subject,
    this.fromUserName,
    this.toUserName,
    this.sentDate,
    this.remarks,
    this.transactionId,
    this.hid,
    this.departmentName,
    this.documentNumber,
    this.notificationId,
    this.forwarderRemarks,
    this.attribute1Prompt,
    this.attribute1Value,
    this.attribute2Prompt,
    this.attribute2Value,
    this.attribute3Prompt,
    this.attribute3Value,
    this.attribute4Prompt,
    this.attribute4Value,
    this.attribute5Prompt,
    this.attribute5Value,
    this.attribute6Prompt,
    this.attribute6Value,
    this.attribute7Prompt,
    this.attribute7Value,
    this.attribute8Prompt,
    this.attribute8Value,
    this.attribute9Prompt,
    this.attribute9Value,
    this.attribute10Prompt,
    this.attribute10Value,
  });

  Type type;
  String subject;
  String fromUserName;
  ToUserName toUserName;
  DateTime sentDate;
  dynamic remarks;
  int transactionId;
  int hid;
  String departmentName;
  String documentNumber;
  int notificationId;
  String forwarderRemarks;
  Attribute1Prompt attribute1Prompt;
  String attribute1Value;
  Attribute2Prompt attribute2Prompt;
  String attribute2Value;
  Attribute3Prompt attribute3Prompt;
  String attribute3Value;
  Attribute4Prompt attribute4Prompt;
  String attribute4Value;
  Attribute5Prompt attribute5Prompt;
  String attribute5Value;
  Attribute6Prompt attribute6Prompt;
  Attribute6Value attribute6Value;
  Attribute7Prompt attribute7Prompt;
  dynamic attribute7Value;
  Attribute8Prompt attribute8Prompt;
  String attribute8Value;
  dynamic attribute9Prompt;
  dynamic attribute9Value;
  dynamic attribute10Prompt;
  dynamic attribute10Value;

  factory DataByTypeitem.fromJson(Map<String, dynamic> json) => DataByTypeitem(
    type: typeValues.map[json["type"]],
    subject: json["subject"],
    fromUserName: json["from_user_name"],
    toUserName: toUserNameValues.map[json["to_user_name"]],
    sentDate: DateTime.parse(json["sent_date"]),
    remarks: json["remarks"],
    transactionId: json["transaction_id"],
    hid: json["hid"],
    departmentName: json["department_name"],
    documentNumber: json["document_number"],
    notificationId: json["notification_id"],
    forwarderRemarks: json["forwarder_remarks"],
    attribute1Prompt: attribute1PromptValues.map[json["attribute1_prompt"]],
    attribute1Value: json["attribute1_value"],
    attribute2Prompt: attribute2PromptValues.map[json["attribute2_prompt"]],
    attribute2Value: json["attribute2_value"],
    attribute3Prompt: attribute3PromptValues.map[json["attribute3_prompt"]],
    attribute3Value: json["attribute3_value"],
    attribute4Prompt: attribute4PromptValues.map[json["attribute4_prompt"]],
    attribute4Value: json["attribute4_value"] == null ? null : json["attribute4_value"],
    attribute5Prompt: attribute5PromptValues.map[json["attribute5_prompt"]],
    attribute5Value: json["attribute5_value"],
    attribute6Prompt: attribute6PromptValues.map[json["attribute6_prompt"]],
    attribute6Value: attribute6ValueValues.map[json["attribute6_value"]],
    attribute7Prompt: attribute7PromptValues.map[json["attribute7_prompt"]],
    attribute7Value: json["attribute7_value"],
    attribute8Prompt: attribute8PromptValues.map[json["attribute8_prompt"]],
    attribute8Value: json["attribute8_value"],
    attribute9Prompt: json["attribute9_prompt"],
    attribute9Value: json["attribute9_value"],
    attribute10Prompt: json["attribute10_prompt"],
    attribute10Value: json["attribute10_value"],
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "subject": subject,
    "from_user_name": fromUserName,
    "to_user_name": toUserNameValues.reverse[toUserName],
    "sent_date": sentDate.toIso8601String(),
    "remarks": remarks,
    "transaction_id": transactionId,
    "hid": hid,
    "department_name": departmentName,
    "document_number": documentNumber,
    "notification_id": notificationId,
    "forwarder_remarks": forwarderRemarks,
    "attribute1_prompt": attribute1PromptValues.reverse[attribute1Prompt],
    "attribute1_value": attribute1Value,
    "attribute2_prompt": attribute2PromptValues.reverse[attribute2Prompt],
    "attribute2_value": attribute2Value,
    "attribute3_prompt": attribute3PromptValues.reverse[attribute3Prompt],
    "attribute3_value": attribute3Value,
    "attribute4_prompt": attribute4PromptValues.reverse[attribute4Prompt],
    "attribute4_value": attribute4Value == null ? null : attribute4Value,
    "attribute5_prompt": attribute5PromptValues.reverse[attribute5Prompt],
    "attribute5_value": attribute5Value,
    "attribute6_prompt": attribute6PromptValues.reverse[attribute6Prompt],
    "attribute6_value": attribute6ValueValues.reverse[attribute6Value],
    "attribute7_prompt": attribute7PromptValues.reverse[attribute7Prompt],
    "attribute7_value": attribute7Value,
    "attribute8_prompt": attribute8PromptValues.reverse[attribute8Prompt],
    "attribute8_value": attribute8Value,
    "attribute9_prompt": attribute9Prompt,
    "attribute9_value": attribute9Value,
    "attribute10_prompt": attribute10Prompt,
    "attribute10_value": attribute10Value,
  };
}

enum Attribute1Prompt { UNIT }

final attribute1PromptValues = EnumValues({
  "Unit": Attribute1Prompt.UNIT
});

enum Attribute2Prompt { DEPARTMENT }

final attribute2PromptValues = EnumValues({
  "Department": Attribute2Prompt.DEPARTMENT
});

enum Attribute3Prompt { PREPARER }

final attribute3PromptValues = EnumValues({
  "Preparer": Attribute3Prompt.PREPARER
});

enum Attribute4Prompt { FORWARDER_REMARKS }

final attribute4PromptValues = EnumValues({
  "Forwarder Remarks": Attribute4Prompt.FORWARDER_REMARKS
});

enum Attribute5Prompt { DESCRIPTION }

final attribute5PromptValues = EnumValues({
  "Description": Attribute5Prompt.DESCRIPTION
});

enum Attribute6Prompt { TYPE }

final attribute6PromptValues = EnumValues({
  "Type": Attribute6Prompt.TYPE
});

enum Attribute6Value { BUDGET }

final attribute6ValueValues = EnumValues({
  "Budget": Attribute6Value.BUDGET
});

enum Attribute7Prompt { PROJECT }

final attribute7PromptValues = EnumValues({
  "Project": Attribute7Prompt.PROJECT
});

enum Attribute8Prompt { REQ_AMOUNT }

final attribute8PromptValues = EnumValues({
  "Req. Amount": Attribute8Prompt.REQ_AMOUNT
});

enum ToUserName { GHOUS_MEHMOOD_SIDDIQUI }

final toUserNameValues = EnumValues({
  "Ghous Mehmood Siddiqui": ToUserName.GHOUS_MEHMOOD_SIDDIQUI
});

enum Type { DEPARTMENT_REQUISITION }

final typeValues = EnumValues({
  "Department Requisition": Type.DEPARTMENT_REQUISITION
});

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
