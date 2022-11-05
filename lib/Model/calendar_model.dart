/// calendaritems : [{"sno":4,"training_id":1,"training_title":"Traditional Leadership vs. Digital Leadership","training_date":"2021-07-02T19:00:00Z","training_duration":"3","companycode":"AM5","location_id":84,"group_title":null,"training_participants":41},{"sno":7,"training_id":6,"training_title":"Hazard & Risk Management","training_date":"2021-08-20T19:00:00Z","training_duration":"3","companycode":"AM2","location_id":83,"group_title":null,"training_participants":15},{"sno":6,"training_id":5,"training_title":"Behavioral Change Management","training_date":"2021-07-30T19:00:00Z","training_duration":"3","companycode":"AM5","location_id":84,"group_title":null,"training_participants":23},{"sno":5,"training_id":2,"training_title":"Non-verbal Communication & Interpersonal Skills","training_date":"2021-07-09T19:00:00Z","training_duration":"3","companycode":"AM5","location_id":84,"group_title":null,"training_participants":32},{"sno":3,"training_id":4,"training_title":"Effective Delegating & SV Skills","training_date":"2021-07-30T19:00:00Z","training_duration":"3","companycode":"AM2","location_id":83,"group_title":null,"training_participants":26},{"sno":1,"training_id":3,"training_title":"Introduction to leadership","training_date":"2021-07-09T19:00:00Z","training_duration":"3","companycode":"AM2","location_id":83,"group_title":null,"training_participants":26},{"sno":2,"training_id":4,"training_title":"Effective Delegating & SV Skills","training_date":"2021-07-16T19:00:00Z","training_duration":"3","companycode":"AM5","location_id":84,"group_title":null,"training_participants":48}]
/// hasMore : false
/// limit : 100
/// offset : 0
/// count : 7
/// links : [{"rel":"self","href":"https://art.artisticmilliners.com:8081/ords/art/apis/dhr/calendar"},{"rel":"describedby","href":"https://art.artisticmilliners.com:8081/ords/art/metadata-catalog/apis/dhr/item"},{"rel":"first","href":"https://art.artisticmilliners.com:8081/ords/art/apis/dhr/calendar"}]

class CalendarModel {
  List<Calendaritems> _calendaritems;
  bool _hasMore;
  int _limit;
  int _offset;
  int _count;
  List<Links> _links;

  List<Calendaritems> get calendaritems => _calendaritems;
  bool get hasMore => _hasMore;
  int get limit => _limit;
  int get offset => _offset;
  int get count => _count;
  List<Links> get links => _links;

  CalendarModel({
      List<Calendaritems> calendaritems,
      bool hasMore,
      int limit,
      int offset,
      int count,
      List<Links> links}){
    _calendaritems = calendaritems;
    _hasMore = hasMore;
    _limit = limit;
    _offset = offset;
    _count = count;
    _links = links;
}

  CalendarModel.fromJson(dynamic json) {
    if (json["calendaritems"] != null) {
      _calendaritems = [];
      json["calendaritems"].forEach((v) {
        _calendaritems.add(Calendaritems.fromJson(v));
      });
    }
    _hasMore = json["hasMore"];
    _limit = json["limit"];
    _offset = json["offset"];
    _count = json["count"];
    if (json["links"] != null) {
      _links = [];
      json["links"].forEach((v) {
        _links.add(Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_calendaritems != null) {
      map["calendaritems"] = _calendaritems.map((v) => v.toJson()).toList();
    }
    map["hasMore"] = _hasMore;
    map["limit"] = _limit;
    map["offset"] = _offset;
    map["count"] = _count;
    if (_links != null) {
      map["links"] = _links.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// rel : "self"
/// href : "https://art.artisticmilliners.com:8081/ords/art/apis/dhr/calendar"

class Links {
  String _rel;
  String _href;

  String get rel => _rel;
  String get href => _href;

  Links({
      String rel,
      String href}){
    _rel = rel;
    _href = href;
}

  Links.fromJson(dynamic json) {
    _rel = json["rel"];
    _href = json["href"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["rel"] = _rel;
    map["href"] = _href;
    return map;
  }

}

/// sno : 4
/// training_id : 1
/// training_title : "Traditional Leadership vs. Digital Leadership"
/// training_date : "2021-07-02T19:00:00Z"
/// training_duration : "3"
/// companycode : "AM5"
/// location_id : 84
/// group_title : null
/// training_participants : 41

class Calendaritems {
  int _sno;
  int _trainingId;
  String _trainingTitle;
  String _trainingDate;
  String _trainingDuration;
  String _companycode;
  int _locationId;
  dynamic _groupTitle;
  int _trainingParticipants;

  int get sno => _sno;
  int get trainingId => _trainingId;
  String get trainingTitle => _trainingTitle;
  String get trainingDate => _trainingDate;
  String get trainingDuration => _trainingDuration;
  String get companycode => _companycode;
  int get locationId => _locationId;
  dynamic get groupTitle => _groupTitle;
  int get trainingParticipants => _trainingParticipants;

  Calendaritems({
      int sno,
      int trainingId,
      String trainingTitle,
      String trainingDate,
      String trainingDuration,
      String companycode,
      int locationId,
      dynamic groupTitle,
      int trainingParticipants}){
    _sno = sno;
    _trainingId = trainingId;
    _trainingTitle = trainingTitle;
    _trainingDate = trainingDate;
    _trainingDuration = trainingDuration;
    _companycode = companycode;
    _locationId = locationId;
    _groupTitle = groupTitle;
    _trainingParticipants = trainingParticipants;
}

  Calendaritems.fromJson(dynamic json) {
    _sno = json["sno"];
    _trainingId = json["training_id"];
    _trainingTitle = json["training_title"];
    _trainingDate = json["training_date"];
    _trainingDuration = json["training_duration"];
    _companycode = json["companycode"];
    _locationId = json["location_id"];
    _groupTitle = json["group_title"];
    _trainingParticipants = json["training_participants"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["sno"] = _sno;
    map["training_id"] = _trainingId;
    map["training_title"] = _trainingTitle;
    map["training_date"] = _trainingDate;
    map["training_duration"] = _trainingDuration;
    map["companycode"] = _companycode;
    map["location_id"] = _locationId;
    map["group_title"] = _groupTitle;
    map["training_participants"] = _trainingParticipants;
    return map;
  }

}