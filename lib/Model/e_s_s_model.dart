/// essitems : [{"conveyance":"None","nationality":"Pakistani","religion":"Islam","qualification":"M.S","gender":"Male","fathername":"S Mujahid Grami","relation":"S/o","address":"Flat # 111, Civic View Appartment Block C-4/2, Gulshan E Iqbal 13-D/2 Karachi..","cnicexpire":"06-APR-2022","companyname":"CO","dateofbirth":"22-APR-1978","dateofjoining":"05-SEP-2011","department_id":119,"department_name":"I.T (E.R.P)","designation_name":"General Manager","division":"Corporate Office","email":"ammad.grami@artisticmilliners.com","employeecode":"0109000188","employeename":"Syed Ammad Uddin Grami","meritalstatus":"Single","mobile":"0321-3762300","nic":"42101-3910197-1","phone":"____-_______","user_id":1110,"user_name":"CIO","reporttoemployeeid":157130,"eobidate":"05-SEP-2011","eobino":"0800B233252","branchname":"Head Office","sessidate":"23-NOV-2011","sessino":"-","duration":"9  Years 10  Months 4  Days"}]
/// first : {"$ref":"https://art.artisticmilliners.com:8081/ords/art/apis/ess/1110"}

class ESSModel {
  List<Essitems> _essitems;
  First _first;

  List<Essitems> get essitems => _essitems;
  First get first => _first;

  ESSModel({
      List<Essitems> essitems, 
      First first}){
    _essitems = essitems;
    _first = first;
}

  ESSModel.fromJson(dynamic json) {
    if (json["essitems"] != null) {
      _essitems = [];
      json["essitems"].forEach((v) {
        _essitems.add(Essitems.fromJson(v));
      });
    }
    _first = json["first"] != null ? First.fromJson(json["first"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_essitems != null) {
      map["essitems"] = _essitems.map((v) => v.toJson()).toList();
    }
    if (_first != null) {
      map["first"] = _first.toJson();
    }
    return map;
  }

}

/// $ref : "https://art.artisticmilliners.com:8081/ords/art/apis/ess/1110"

class First {
  String _$ref;

  String get $ref => _$ref;

  First({
      String $ref}){
    _$ref = $ref;
}

  First.fromJson(dynamic json) {
    _$ref = json["\u0024ref"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["\u0024ref"] = _$ref;
    return map;
  }

}

/// conveyance : "None"
/// nationality : "Pakistani"
/// religion : "Islam"
/// qualification : "M.S"
/// gender : "Male"
/// fathername : "S Mujahid Grami"
/// relation : "S/o"
/// address : "Flat # 111, Civic View Appartment Block C-4/2, Gulshan E Iqbal 13-D/2 Karachi.."
/// cnicexpire : "06-APR-2022"
/// companyname : "CO"
/// dateofbirth : "22-APR-1978"
/// dateofjoining : "05-SEP-2011"
/// department_id : 119
/// department_name : "I.T (E.R.P)"
/// designation_name : "General Manager"
/// division : "Corporate Office"
/// email : "ammad.grami@artisticmilliners.com"
/// employeecode : "0109000188"
/// employeename : "Syed Ammad Uddin Grami"
/// meritalstatus : "Single"
/// mobile : "0321-3762300"
/// nic : "42101-3910197-1"
/// phone : "____-_______"
/// user_id : 1110
/// user_name : "CIO"
/// reporttoemployeeid : 157130
/// eobidate : "05-SEP-2011"
/// eobino : "0800B233252"
/// branchname : "Head Office"
/// sessidate : "23-NOV-2011"
/// sessino : "-"
/// duration : "9  Years 10  Months 4  Days"

class Essitems {
  String _conveyance;
  String _nationality;
  String _religion;
  String _qualification;
  String _gender;
  String _fathername;
  String _relation;
  String _address;
  String _cnicexpire;
  String _companyname;
  String _dateofbirth;
  String _dateofjoining;
  int _departmentId;
  String _departmentName;
  String _designationName;
  String _division;
  String _email;
  String _employeecode;
  String _employeename;
  String _meritalstatus;
  String _mobile;
  String _nic;
  String _phone;
  int _userId;
  String _userName;
  int _reporttoemployeeid;
  String _eobidate;
  String _eobino;
  String _branchname;
  String _sessidate;
  String _sessino;
  String _duration;

  String get conveyance => _conveyance;
  String get nationality => _nationality;
  String get religion => _religion;
  String get qualification => _qualification;
  String get gender => _gender;
  String get fathername => _fathername;
  String get relation => _relation;
  String get address => _address;
  String get cnicexpire => _cnicexpire;
  String get companyname => _companyname;
  String get dateofbirth => _dateofbirth;
  String get dateofjoining => _dateofjoining;
  int get departmentId => _departmentId;
  String get departmentName => _departmentName;
  String get designationName => _designationName;
  String get division => _division;
  String get email => _email;
  String get employeecode => _employeecode;
  String get employeename => _employeename;
  String get meritalstatus => _meritalstatus;
  String get mobile => _mobile;
  String get nic => _nic;
  String get phone => _phone;
  int get userId => _userId;
  String get userName => _userName;
  int get reporttoemployeeid => _reporttoemployeeid;
  String get eobidate => _eobidate;
  String get eobino => _eobino;
  String get branchname => _branchname;
  String get sessidate => _sessidate;
  String get sessino => _sessino;
  String get duration => _duration;

  Essitems({
      String conveyance, 
      String nationality, 
      String religion, 
      String qualification, 
      String gender, 
      String fathername, 
      String relation, 
      String address, 
      String cnicexpire, 
      String companyname, 
      String dateofbirth, 
      String dateofjoining, 
      int departmentId, 
      String departmentName, 
      String designationName, 
      String division, 
      String email, 
      String employeecode, 
      String employeename, 
      String meritalstatus, 
      String mobile, 
      String nic, 
      String phone, 
      int userId, 
      String userName, 
      int reporttoemployeeid, 
      String eobidate, 
      String eobino, 
      String branchname, 
      String sessidate, 
      String sessino, 
      String duration}){
    _conveyance = conveyance;
    _nationality = nationality;
    _religion = religion;
    _qualification = qualification;
    _gender = gender;
    _fathername = fathername;
    _relation = relation;
    _address = address;
    _cnicexpire = cnicexpire;
    _companyname = companyname;
    _dateofbirth = dateofbirth;
    _dateofjoining = dateofjoining;
    _departmentId = departmentId;
    _departmentName = departmentName;
    _designationName = designationName;
    _division = division;
    _email = email;
    _employeecode = employeecode;
    _employeename = employeename;
    _meritalstatus = meritalstatus;
    _mobile = mobile;
    _nic = nic;
    _phone = phone;
    _userId = userId;
    _userName = userName;
    _reporttoemployeeid = reporttoemployeeid;
    _eobidate = eobidate;
    _eobino = eobino;
    _branchname = branchname;
    _sessidate = sessidate;
    _sessino = sessino;
    _duration = duration;
}

  Essitems.fromJson(dynamic json) {
    _conveyance = json["conveyance"];
    _nationality = json["nationality"];
    _religion = json["religion"];
    _qualification = json["qualification"];
    _gender = json["gender"];
    _fathername = json["fathername"];
    _relation = json["relation"];
    _address = json["address"];
    _cnicexpire = json["cnicexpire"];
    _companyname = json["companyname"];
    _dateofbirth = json["dateofbirth"];
    _dateofjoining = json["dateofjoining"];
    _departmentId = json["department_id"];
    _departmentName = json["department_name"];
    _designationName = json["designation_name"];
    _division = json["division"];
    _email = json["email"];
    _employeecode = json["employeecode"];
    _employeename = json["employeename"];
    _meritalstatus = json["meritalstatus"];
    _mobile = json["mobile"];
    _nic = json["nic"];
    _phone = json["phone"];
    _userId = json["user_id"];
    _userName = json["user_name"];
    _reporttoemployeeid = json["reporttoemployeeid"];
    _eobidate = json["eobidate"];
    _eobino = json["eobino"];
    _branchname = json["branchname"];
    _sessidate = json["sessidate"];
    _sessino = json["sessino"];
    _duration = json["duration"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["conveyance"] = _conveyance;
    map["nationality"] = _nationality;
    map["religion"] = _religion;
    map["qualification"] = _qualification;
    map["gender"] = _gender;
    map["fathername"] = _fathername;
    map["relation"] = _relation;
    map["address"] = _address;
    map["cnicexpire"] = _cnicexpire;
    map["companyname"] = _companyname;
    map["dateofbirth"] = _dateofbirth;
    map["dateofjoining"] = _dateofjoining;
    map["department_id"] = _departmentId;
    map["department_name"] = _departmentName;
    map["designation_name"] = _designationName;
    map["division"] = _division;
    map["email"] = _email;
    map["employeecode"] = _employeecode;
    map["employeename"] = _employeename;
    map["meritalstatus"] = _meritalstatus;
    map["mobile"] = _mobile;
    map["nic"] = _nic;
    map["phone"] = _phone;
    map["user_id"] = _userId;
    map["user_name"] = _userName;
    map["reporttoemployeeid"] = _reporttoemployeeid;
    map["eobidate"] = _eobidate;
    map["eobino"] = _eobino;
    map["branchname"] = _branchname;
    map["sessidate"] = _sessidate;
    map["sessino"] = _sessino;
    map["duration"] = _duration;
    return map;
  }

}