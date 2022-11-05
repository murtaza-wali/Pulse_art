/// denimSalesTotalitems : [{"dispatch_approval":83826,"export_sales":67462,"indirect_export_sale":27436,"inter_unit_sale":62972,"total_exports":94898}]
/// hasMore : false
/// limit : 25
/// offset : 0
/// count : 1
/// links : [{"rel":"self","href":"https://art.artisticmilliners.com:8081/ords/art/dashboard/denim_sales/total/83"},{"rel":"describedby","href":"https://art.artisticmilliners.com:8081/ords/art/metadata-catalog/dashboard/denim_sales/total/item"},{"rel":"first","href":"https://art.artisticmilliners.com:8081/ords/art/dashboard/denim_sales/total/83"}]

class DenimSalesTotal {
  List<DenimSalesTotalitems> _denimSalesTotalitems;
  bool _hasMore;
  int _limit;
  int _offset;
  int _count;
  List<Links> _links;

  List<DenimSalesTotalitems> get denimSalesTotalitems => _denimSalesTotalitems;
  bool get hasMore => _hasMore;
  int get limit => _limit;
  int get offset => _offset;
  int get count => _count;
  List<Links> get links => _links;

  DenimSalesTotal({
      List<DenimSalesTotalitems> denimSalesTotalitems, 
      bool hasMore, 
      int limit, 
      int offset, 
      int count, 
      List<Links> links}){
    _denimSalesTotalitems = denimSalesTotalitems;
    _hasMore = hasMore;
    _limit = limit;
    _offset = offset;
    _count = count;
    _links = links;
}

  DenimSalesTotal.fromJson(dynamic json) {
    if (json["denimSalesTotalitems"] != null) {
      _denimSalesTotalitems = [];
      json["denimSalesTotalitems"].forEach((v) {
        _denimSalesTotalitems.add(DenimSalesTotalitems.fromJson(v));
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
    if (_denimSalesTotalitems != null) {
      map["denimSalesTotalitems"] = _denimSalesTotalitems.map((v) => v.toJson()).toList();
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
/// href : "https://art.artisticmilliners.com:8081/ords/art/dashboard/denim_sales/total/83"

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

/// dispatch_approval : 83826
/// export_sales : 67462
/// indirect_export_sale : 27436
/// inter_unit_sale : 62972
/// total_exports : 94898

class DenimSalesTotalitems {
  int _dispatchApproval;
  int _exportSales;
  int _indirectExportSale;
  int _interUnitSale;
  int _totalExports;

  int get dispatchApproval => _dispatchApproval;
  int get exportSales => _exportSales;
  int get indirectExportSale => _indirectExportSale;
  int get interUnitSale => _interUnitSale;
  int get totalExports => _totalExports;

  DenimSalesTotalitems({
      int dispatchApproval, 
      int exportSales, 
      int indirectExportSale, 
      int interUnitSale, 
      int totalExports}){
    _dispatchApproval = dispatchApproval;
    _exportSales = exportSales;
    _indirectExportSale = indirectExportSale;
    _interUnitSale = interUnitSale;
    _totalExports = totalExports;
}

  DenimSalesTotalitems.fromJson(dynamic json) {
    _dispatchApproval = json["dispatch_approval"];
    _exportSales = json["export_sales"];
    _indirectExportSale = json["indirect_export_sale"];
    _interUnitSale = json["inter_unit_sale"];
    _totalExports = json["total_exports"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["dispatch_approval"] = _dispatchApproval;
    map["export_sales"] = _exportSales;
    map["indirect_export_sale"] = _indirectExportSale;
    map["inter_unit_sale"] = _interUnitSale;
    map["total_exports"] = _totalExports;
    return map;
  }

}