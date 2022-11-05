/// type_counts : 1.0

class PerformanceModel {
  double _typeCounts;

  double get typeCounts => _typeCounts;

  PerformanceModel({
      double typeCounts}){
    _typeCounts = typeCounts;
}

  PerformanceModel.fromJson(dynamic json) {
    _typeCounts = json["type_counts"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["type_counts"] = _typeCounts;
    return map;
  }

}