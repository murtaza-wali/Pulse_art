// To parse this JSON data, do
//
//     final detailsCard = detailsCardFromJson(jsonString);

import 'dart:convert';

DetailsCard detailsCardFromJson(String str) => DetailsCard.fromJson(json.decode(str));

String detailsCardToJson(DetailsCard data) => json.encode(data.toJson());

class DetailsCard {
  DetailsCard({
    this.detailcardsitem,
    this.first,
  });

  List<Detailcardsitem> detailcardsitem;
  First first;

  factory DetailsCard.fromJson(Map<String, dynamic> json) => DetailsCard(
    detailcardsitem: List<Detailcardsitem>.from(json["Detailcardsitem"].map((x) => Detailcardsitem.fromJson(x))),
    first: First.fromJson(json["first"]),
  );

  Map<String, dynamic> toJson() => {
    "Detailcardsitem": List<dynamic>.from(detailcardsitem.map((x) => x.toJson())),
    "first": first.toJson(),
  };
}

class Detailcardsitem {
  Detailcardsitem({
    this.notificationId,
    this.notificationTypeId,
    this.columnPrompt,
    this.columnVal,
    this.columnSequence,
    this.cardId,
    this.linesId,
  });

  int notificationId;
  int notificationTypeId;
  String columnPrompt;
  String columnVal;
  int columnSequence;
  double cardId;
  int linesId;

  factory Detailcardsitem.fromJson(Map<String, dynamic> json) => Detailcardsitem(
    notificationId: json["notification_id"],
    notificationTypeId: json["notification_type_id"],
    columnPrompt: json["column_prompt"],
    columnVal: json["column_val"],
    columnSequence: json["column_sequence"],
    cardId: json["card_id"].toDouble(),
    linesId: json["lines_id"],
  );

  Map<String, dynamic> toJson() => {
    "notification_id": notificationId,
    "notification_type_id": notificationTypeId,
    "column_prompt": columnPrompt,
    "column_val": columnVal,
    "column_sequence": columnSequence,
    "card_id": cardId,
    "lines_id": linesId,
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
