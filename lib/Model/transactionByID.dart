// To parse this JSON data, do
//
//     final transactionbyId = transactionbyIdFromJson(jsonString);

import 'dart:convert';

TransactionbyId transactionbyIdFromJson(String str) =>
    TransactionbyId.fromJson(json.decode(str));

String transactionbyIdToJson(TransactionbyId data) =>
    json.encode(data.toJson());

class TransactionbyId {
  TransactionbyId({
    this.depReqItem,
    this.first,
  });

  List<DepReqItem> depReqItem;
  First first;

  factory TransactionbyId.fromJson(Map<String, dynamic> json) =>
      TransactionbyId(
        depReqItem: List<DepReqItem>.from(
            json["DepReqItem"].map((x) => DepReqItem.fromJson(x))),
        first: First.fromJson(json["first"]),
      );

  Map<String, dynamic> toJson() => {
        "DepReqItem": List<dynamic>.from(depReqItem.map((x) => x.toJson())),
        "first": first.toJson(),
      };
}

class DepReqItem {
  DepReqItem({
    this.itemCode,
    this.itemDesc,
    this.inventoryItemId,
    this.uomCode,
    this.requiredQuantity,
    this.needByDate,
    this.noteToBuyer,
    this.approvedQuantity,
    this.linesId,
    this.urgent,
  });

  String itemCode;
  String itemDesc;
  int inventoryItemId;
  String uomCode;
  int requiredQuantity;
  DateTime needByDate;
  String noteToBuyer;
  int approvedQuantity;
  int linesId;
  String urgent;

  factory DepReqItem.fromJson(Map<String, dynamic> json) => DepReqItem(
        itemCode: json["item_code"],
        itemDesc: json["item_desc"],
        inventoryItemId: json["inventory_item_id"],
        uomCode: json["uom_code"],
        requiredQuantity: json["required_quantity"],
        needByDate: DateTime.parse(json["need_by_date"]),
        noteToBuyer: json["note_to_buyer"],
        approvedQuantity: json["approved_quantity"],
        linesId: json["lines_id"],
        urgent: json["urgent"],
      );

  Map<String, dynamic> toJson() => {
        "item_code": itemCode,
        "item_desc": itemDesc,
        "inventory_item_id": inventoryItemId,
        "uom_code": uomCode,
        "required_quantity": requiredQuantity,
        "need_by_date": needByDate.toIso8601String(),
        "note_to_buyer": noteToBuyer,
        "approved_quantity": approvedQuantity,
        "lines_id": linesId,
        "urgent": urgent,
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
