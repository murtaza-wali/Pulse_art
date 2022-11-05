/// employeeTrainingitems : [{"emp_code":"0113000452","ename":"ZIA UD DIN","enroll_id":"0113000452-1","status":"A"},{"emp_code":"0102000526","ename":"AYAZ AHMED","enroll_id":"0102000526-1","status":"A"},{"emp_code":"0113000345","ename":"AQIB SAJJAD","enroll_id":"0113000345-1","status":"P"},{"emp_code":"0102000792","ename":"SYED IRSHAD UL HAQ","enroll_id":"0102000792-1","status":"P"},{"emp_code":"0102000999","ename":"MUHAMMAD IMRAN BAIG","enroll_id":"0102000999-1","status":"P"},{"emp_code":"0102000011","ename":"ZEESHAN AHMED CHISHTI","enroll_id":"0102000011-1","status":"P"},{"emp_code":"0102000175","ename":"ARSHAD HUSSAIN","enroll_id":"0102000175-1","status":"A"},{"emp_code":"0116000145","ename":"SYED ASGHAR MEHDI","enroll_id":"0116000145-1","status":"A"},{"emp_code":"0113000284","ename":"AAMIR AWAN","enroll_id":"0113000284-1","status":"A"},{"emp_code":"0113000396","ename":"LABEEB MOHAMMAD","enroll_id":"0113000396-1","status":"P"},{"emp_code":"0113000169","ename":"OWAIS AHMED SIDDIQUI","enroll_id":"0113000169-1","status":"P"},{"emp_code":"0113000395","ename":"FAAREHA FATIMA","enroll_id":"0113000395-1","status":"P"},{"emp_code":"0102000167","ename":"SIRAJ UDDIN HASHMI","enroll_id":"0102000167-1","status":"P"},{"emp_code":"0102000287","ename":"SYED MUHAMMAD TAHA ALI SHAH","enroll_id":"0102000287-1","status":"A"},{"emp_code":"0102000385","ename":"SARFARAZ ALI","enroll_id":"0102000385-1","status":"A"},{"emp_code":"0102000478","ename":"ASIF IQBAL","enroll_id":"0102000478-1","status":"A"},{"emp_code":"0102000586","ename":"MUHAMMAD KASHIF","enroll_id":"0102000586-1","status":"P"},{"emp_code":"0102000653","ename":"MUHAMMAD KHALID","enroll_id":"0102000653-1","status":"A"},{"emp_code":"0102000669","ename":"MUHAMMAD ZUBAIR AKRAM KHAN ZADA","enroll_id":"0102000669-1","status":"P"},{"emp_code":"0102001000","ename":"MUHAMMAD MUZAMMIL NASIR","enroll_id":"0102001000-1","status":"A"},{"emp_code":"0102000997","ename":"MUHAMMED RAHEEL","enroll_id":"0102000997-1","status":"A"},{"emp_code":"0113000349","ename":"SHAHID MOIN","enroll_id":"0113000349-1","status":"A"},{"emp_code":"0102000745","ename":"OSAMA HASAN KHAN","enroll_id":"0102000745-1","status":"P"},{"emp_code":"0102000772","ename":"MUHAMMAD OMER","enroll_id":"0102000772-1","status":"P"},{"emp_code":"0102000994","ename":"ZIA SHADAB","enroll_id":"0102000994-1","status":"A"},{"emp_code":"0102000658","ename":"FAHEEM KARIM","enroll_id":"0102000658-1","status":"A"}]
/// hasMore : false
/// limit : 100
/// offset : 0
/// count : 26
/// links : [{"rel":"self","href":"https://art.artisticmilliners.com:8081/ords/art/apis/dhr/training/employee_list/?training_id=1"},{"rel":"edit","href":"https://art.artisticmilliners.com:8081/ords/art/apis/dhr/training/employee_list/?training_id=1"},{"rel":"describedby","href":"https://art.artisticmilliners.com:8081/ords/art/metadata-catalog/apis/dhr/training/employee_list/"},{"rel":"first","href":"https://art.artisticmilliners.com:8081/ords/art/apis/dhr/training/employee_list/?training_id=1"}]

class EmployeeTrainingModel {
  List<EmployeeTrainingitems> _employeeTrainingitems;
  bool _hasMore;
  int _limit;
  int _offset;
  int _count;
  List<Links> _links;

  List<EmployeeTrainingitems> get employeeTrainingitems => _employeeTrainingitems;
  bool get hasMore => _hasMore;
  int get limit => _limit;
  int get offset => _offset;
  int get count => _count;
  List<Links> get links => _links;

  EmployeeTrainingModel({
      List<EmployeeTrainingitems> employeeTrainingitems, 
      bool hasMore, 
      int limit, 
      int offset, 
      int count, 
      List<Links> links}){
    _employeeTrainingitems = employeeTrainingitems;
    _hasMore = hasMore;
    _limit = limit;
    _offset = offset;
    _count = count;
    _links = links;
}

  EmployeeTrainingModel.fromJson(dynamic json) {
    if (json["employeeTrainingitems"] != null) {
      _employeeTrainingitems = [];
      json["employeeTrainingitems"].forEach((v) {
        _employeeTrainingitems.add(EmployeeTrainingitems.fromJson(v));
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
    if (_employeeTrainingitems != null) {
      map["employeeTrainingitems"] = _employeeTrainingitems.map((v) => v.toJson()).toList();
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
/// href : "https://art.artisticmilliners.com:8081/ords/art/apis/dhr/training/employee_list/?training_id=1"

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

/// emp_code : "0113000452"
/// ename : "ZIA UD DIN"
/// enroll_id : "0113000452-1"
/// status : "A"

class EmployeeTrainingitems {
  String _empCode;
  String _ename;
  String _enrollId;
  String _status;

  String get empCode => _empCode;
  String get ename => _ename;
  String get enrollId => _enrollId;
  String get status => _status;

  EmployeeTrainingitems({
      String empCode, 
      String ename, 
      String enrollId, 
      String status}){
    _empCode = empCode;
    _ename = ename;
    _enrollId = enrollId;
    _status = status;
}

  EmployeeTrainingitems.fromJson(dynamic json) {
    _empCode = json["emp_code"];
    _ename = json["ename"];
    _enrollId = json["enroll_id"];
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["emp_code"] = _empCode;
    map["ename"] = _ename;
    map["enroll_id"] = _enrollId;
    map["status"] = _status;
    return map;
  }

}