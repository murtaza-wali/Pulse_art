
class AttendanceCorrectionReport {
  AttendanceCorrectionReport({
      this.items, 
      this.hasMore, 
      this.limit, 
      this.offset, 
      this.count, 
      this.links,});

  AttendanceCorrectionReport.fromJson(dynamic json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items.add(ExampleItems.fromJson(v));
      });
    }
    hasMore = json['hasMore'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    if (json['links'] != null) {
      links = [];
      json['links'].forEach((v) {
        links.add(Links.fromJson(v));
      });
    }
  }
  List<ExampleItems> items;
  bool hasMore;
  int limit;
  int offset;
  int count;
  List<Links> links;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (items != null) {
      map['items'] = items.map((v) => v.toJson()).toList();
    }
    map['hasMore'] = hasMore;
    map['limit'] = limit;
    map['offset'] = offset;
    map['count'] = count;
    if (links != null) {
      map['links'] = links.map((v) => v.toJson()).toList();
    }
    return map;
  }

 }


class ExampleItems {
  ExampleItems({
    this.requestNo,
    this.orgId,
    this.employeename,
    this.companyname,
    this.correctionDate,
    this.correctionTi,
    this.correctionTo,
    this.correctionRemarks,
    this.status,
    this.correctionId,});

  ExampleItems.fromJson(dynamic json) {
    requestNo = json['request_no'];
    orgId = json['org_id'];
    employeename = json['employeename'];
    companyname = json['companyname'];
    correctionDate = json['correction_date'];
    correctionTi = json['correction_ti'];
    correctionTo = json['correction_to'];
    correctionRemarks = json['correction_remarks'];
    status = json['status'];
    correctionId = json['correction_id'];
  }
  String requestNo;
  int orgId;
  String employeename;
  String companyname;
  String correctionDate;
  String correctionTi;
  String correctionTo;
  dynamic correctionRemarks;
  String status;
  int correctionId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['request_no'] = requestNo;
    map['org_id'] = orgId;
    map['employeename'] = employeename;
    map['companyname'] = companyname;
    map['correction_date'] = correctionDate;
    map['correction_ti'] = correctionTi;
    map['correction_to'] = correctionTo;
    map['correction_remarks'] = correctionRemarks;
    map['status'] = status;
    map['correction_id'] = correctionId;
    return map;
  }
}

class Links {
  Links({
    this.rel,
    this.href,});

  Links.fromJson(dynamic json) {
    rel = json['rel'];
    href = json['href'];
  }

  String rel;
  String href;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rel'] = rel;
    map['href'] = href;
    return map;
  }
}