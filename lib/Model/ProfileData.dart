// To parse this JSON data, do
//
//     final profileData = profileDataFromJson(jsonString);

import 'dart:convert';

ProfileData profileDataFromJson(String str) =>
    ProfileData.fromJson(json.decode(str));

String profileDataToJson(ProfileData data) => json.encode(data.toJson());

class ProfileData {
  ProfileData({
    this.profileitems,
    this.first,
  });

  List<Profileitem> profileitems;
  First first;

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        profileitems: List<Profileitem>.from(
            json["profileitems"].map((x) => Profileitem.fromJson(x))),
        first: First.fromJson(json["first"]),
      );

  Map<String, dynamic> toJson() => {
        "profileitems": List<dynamic>.from(profileitems.map((x) => x.toJson())),
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

class Profileitem {
  Profileitem({
    this.conveyance,
    this.nationality,
    this.religion,
    this.qualification,
    this.gender,
    this.fathername,
    this.relation,
    this.address,
    this.cnicexpire,
    this.companyname,
    this.dateofbirth,
    this.dateofjoining,
    this.departmentName,
    this.designationName,
    this.division,
    this.email,
    this.employeecode,
    this.employeename,
    this.meritalstatus,
    this.mobile,
    this.nic,
    this.phone,
    this.userId,
    this.userName,
    this.reporttoemployeeid,
    this.eobidate,
    this.eobino,
    this.branchname,
    this.sessidate,
    this.sessino,
    this.duration,
  });

  String conveyance;
  String nationality;
  String religion;
  String qualification;
  String gender;
  String fathername;
  String relation;
  String address;
  DateTime cnicexpire;
  String companyname;
  DateTime dateofbirth;
  DateTime dateofjoining;
  String departmentName;
  String designationName;
  String division;
  String email;
  String employeecode;
  String employeename;
  String meritalstatus;
  String mobile;
  String nic;
  String phone;
  int userId;
  String userName;
  int reporttoemployeeid;
  DateTime eobidate;
  String eobino;
  String branchname;
  DateTime sessidate;
  String sessino;
  String duration;

  factory Profileitem.fromJson(Map<String, dynamic> json) => Profileitem(
        conveyance:
            json["conveyance"] == null ? null : json['conveyance'] as String,
        nationality:
            json["nationality"] == null ? null : json['nationality'] as String,
        religion: json["religion"] == null ? null : json['religion'] as String,
        qualification: json["qualification"] == null
            ? null
            : json['qualification'] as String,
        gender: json["gender"] == null ? null : json['gender'] as String,
        fathername:
            json["fathername"] == null ? null : json['fathername'] as String,
        relation: json["relation"] == null ? null : json['relation'] as String,
        address: json["address"] == null ? null : json['address'] as String,
        cnicexpire: DateTime.parse(json["cnicexpire"]),
        companyname:
            json["companyname"] == null ? null : json['companyname'] as String,
        dateofbirth: DateTime.parse(json["dateofbirth"]),
        dateofjoining: DateTime.parse(json["dateofjoining"]),
        departmentName: json["department_name"] == null
            ? null
            : json['department_name'] as String,
        designationName: json["designation_name"] == null
            ? null
            : json['designation_name'] as String,
        division: json["division"] == null ? null : json['division'] as String,
        email: json["email"] == null ? null : json['email'] as String,
        employeecode: json["employeecode"] == null
            ? null
            : json['employeecode'] as String,
        employeename: json["employeename"] == null
            ? null
            : json['employeename'] as String,
        meritalstatus: json["meritalstatus"] == null
            ? null
            : json['meritalstatus'] as String,
        mobile: json["mobile"] == null ? null : json['mobile'] as String,
        nic: json["nic"] == null ? null : json['nic'] as String,
        phone: json["phone"] == null ? null : json['phone'] as String,
        userId: json["user_id"] == null ? null : json['user_id'] as int,
        userName: json["user_name"] == null ? null : json['name'] as String,
        reporttoemployeeid: json["reporttoemployeeid"] == null
            ? null
            : json['reporttoemployeeid'] as int,
        eobidate: DateTime.parse(json["eobidate"]),
        eobino: json["eobino"] == null ? null : json['name'] as String,
        branchname: json["branchname"] == null ? null : json['name'] as String,
        sessidate: DateTime.parse(json["sessidate"]),
        sessino: json["sessino"] == null ? null : json['sessino'] as String,
        duration: json["duration"] == null ? null : json['duration'] as String,
      );

  Map<String, dynamic> toJson() => {
        "conveyance": conveyance,
        "nationality": nationality,
        "religion": religion,
        "qualification": qualification,
        "gender": gender,
        "fathername": fathername,
        "relation": relation,
        "address": address,
        "cnicexpire": cnicexpire.toIso8601String(),
        "companyname": companyname,
        "dateofbirth": dateofbirth.toIso8601String(),
        "dateofjoining": dateofjoining.toIso8601String(),
        "department_name": departmentName,
        "designation_name": designationName,
        "division": division,
        "email": email,
        "employeecode": employeecode,
        "employeename": employeename,
        "meritalstatus": meritalstatus,
        "mobile": mobile,
        "nic": nic,
        "phone": phone,
        "user_id": userId,
        "user_name": userName,
        "reporttoemployeeid": reporttoemployeeid,
        "eobidate": eobidate.toIso8601String(),
        "eobino": eobino,
        "branchname": branchname,
        "sessidate": sessidate.toIso8601String(),
        "sessino": sessino,
        "duration": duration,
      };
}
