// ignore: camel_case_types
class MaritalStatus {
  final String status;

  MaritalStatus({
    this.status,
  });

  List<MaritalStatus> loadWorklistNameList(){
    var _worklistnameModelList = <MaritalStatus>[
      MaritalStatus(status: 'Single'),
      MaritalStatus(status: 'Divorced'),
      MaritalStatus(status: 'Married'),
    ];
    return _worklistnameModelList;
  }

}

