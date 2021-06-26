// To parse this JSON data, do
//
//     final count = countFromJson(jsonString);

import 'dart:convert';

Count countFromJson(String str) => Count.fromJson(json.decode(str));

String countToJson(Count data) => json.encode(data.toJson());

class Count {
  Count({
    this.totalcount,
    this.first,
  });

  List<Totalcount> totalcount;
  First first;

  factory Count.fromJson(Map<String, dynamic> json) => Count(
    totalcount: List<Totalcount>.from(json["totalcount"].map((x) => Totalcount.fromJson(x))),
    first: First.fromJson(json["first"]),
  );

  Map<String, dynamic> toJson() => {
    "totalcount": List<dynamic>.from(totalcount.map((x) => x.toJson())),
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

class Totalcount {
  Totalcount({
    this.totCount,
  });

  int totCount;

  factory Totalcount.fromJson(Map<String, dynamic> json) => Totalcount(
    totCount: json["tot_count"],
  );

  Map<String, dynamic> toJson() => {
    "tot_count": totCount,
  };
}
