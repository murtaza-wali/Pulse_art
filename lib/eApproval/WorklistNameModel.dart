// ignore: camel_case_types
class worklistnameModel {
  final String worklistName;

  worklistnameModel({
    this.worklistName,
  });

  List<worklistnameModel> loadWorklistNameList(){
    var _worklistnameModelList = <worklistnameModel>[
      worklistnameModel(worklistName: 'All Employees and users'),
      worklistnameModel(worklistName: 'Employee'),
      worklistnameModel(worklistName: 'Oracle Application User'),
      worklistnameModel(worklistName: 'public Sector Employee'),
    ];
    return _worklistnameModelList;
  }

}

