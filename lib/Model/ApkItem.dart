
// To parse this JSON data, do
//
//     final apkversion = apkversionFromJson(jsonString);

import 'dart:convert';

Apkversion apkversionFromJson(String str) =>
    Apkversion.fromJson(json.decode(str));

String apkversionToJson(Apkversion data) => json.encode(data.toJson());

class Apkversion {
  Apkversion({
    this.apkItems,
    this.first,
  });

  List<ApkItem> apkItems;
  First first;

  factory Apkversion.fromJson(Map<String, dynamic> json) => Apkversion(
    apkItems: List<ApkItem>.from(
        json["apkItems"].map((x) => ApkItem.fromJson(x))),
    first: First.fromJson(json["first"]),
  );

  Map<String, dynamic> toJson() => {
    "apkItems": List<dynamic>.from(apkItems.map((x) => x.toJson())),
    "first": first.toJson(),
  };
}

class ApkItem {
  ApkItem({
    this.versionCode,
  });

  String versionCode;

  factory ApkItem.fromJson(Map<String, dynamic> json) => ApkItem(
    versionCode: json["version_code"],
  );

  Map<String, dynamic> toJson() => {
    "version_code": versionCode,
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
