import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:art/APIUri/BaseUrl.dart';
import 'package:art/Error/Error.dart';
import 'package:art/Model/AttendanceCorrectionReport.dart';
import 'package:art/Model/AttendenceModel.dart';
import 'package:art/Model/Count.dart';
import 'package:art/Model/DAM/DAMunitlist.dart';
import 'package:art/Model/DetailCards.dart';
import 'package:art/Model/FPCmODEL/FpcSeasonModel.dart';
import 'package:art/Model/FPCmODEL/fpcBrandModel.dart';
import 'package:art/Model/FPCmODEL/fpcForwardToModel.dart';
import 'package:art/Model/FPCmODEL/fpcglobalparamModel.dart';
import 'package:art/Model/LoginUser.dart';
import 'package:art/Model/MenuCardsModel.dart';
import 'package:art/Model/TraceabilityModels/OrderDropdownList.dart';
import 'package:art/Model/WorkBoard/WorkboardTicket.dart';
import 'package:art/Model/WorkBoard/ticket_workboard_list.dart';
import 'package:art/Model/WorkBoard/workboard_status.dart';
import 'package:art/Model/attendencetotal.dart';
import 'package:art/Model/calendar_model.dart';
import 'package:art/Model/databy_type.dart';
import 'package:art/Model/denim_sales_total.dart';
import 'package:art/Model/e_s_s_model.dart';
import 'package:art/Model/employee_training_model.dart';
import 'package:art/Model/employeehierarchy.dart';
import 'package:art/Model/fabric_library/fabric_lib_card_items.dart';
import 'package:art/Model/ipolicyModel.dart';
import 'package:art/Model/level_model.dart';
import 'package:art/Model/systemAttachedModel.dart';
import 'package:art/Model/ticket/assign.dart';
import 'package:art/Model/ticket/department.dart';
import 'package:art/Model/ticket/severity.dart';
import 'package:art/Model/ticket/unit.dart';
import 'package:art/Model/trainingList.dart';
import 'package:art/Model/typeModel.dart';
import 'package:art/Model/unit_model.dart';
import 'package:art/Model/version.dart';
import 'package:art/Model/wms_am5_model/warehouse_rack_list.dart';
import 'package:art/Model/wms_am5_model/warehouse_racks.dart';
import 'package:art/Model/wms_am5_model/warehouse_types.dart';
import 'package:art/ParsingJSON/PostJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:minimize_app/minimize_app.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Model/GPbyID.dart';

class GetJSON {
  Future<List<GPbyIDitem>> getGpItemsById(int userid) async {
    try {
      // Uri.parse must when you are passing URL.
      var gpURL = Uri.parse(BaseURL().Auth +
          'approvals' +
          '/' +
          'depreq' +
          '/' +
          userid.toString());

      final GPresult = await http.get(gpURL);

      var parse = json.decode(GPresult.body);
      var data = parse['items'] as List;
      var GPmap = data.map<GPbyIDitem>((json) => GPbyIDitem.fromJson(json));
      if (GPresult.statusCode == 200) {
        return GPmap.toList();
      } else if (GPresult.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (GPresult.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (GPresult.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

//line wali api hai yeh ....
  Future<List<Detailcardsitem>> getTrasactionByNotifyId(int notifyID) async {
    //https://art.artisticmilliners.com:8081/ords/art/apis/detailcard/:notf_id
    try {
      // Uri.parse must when you are passing URL.
      var transactionURL =
          Uri.parse(BaseURL().Auth + 'detailcard' + '/' + notifyID.toString());
      print('transactionURL: ${transactionURL}');
      final transactionresult = await http.get(transactionURL);

      var parse = json.decode(transactionresult.body);
      var data = parse['items'] as List;
      print('checking${data}');

      List<Detailcardsitem> Transactionmap = data
          .map<Detailcardsitem>((json) => Detailcardsitem.fromJson(json))
          .toList();
      print('Transactionmap: ${Transactionmap}');
      if (transactionresult.statusCode == 200) {
        return Transactionmap;
      } else if (transactionresult.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (transactionresult.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (transactionresult.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

//yahan artlive krna hai
  Future<List<Versionitem>> getVersionitem(BuildContext context) async {
    try {
      final response = Uri.parse(BaseURL().Auth + 'version/101');
      print('response: ${response}');
      var atttime = await http.get(response);

      var parse = json.decode(atttime.body);
      var data = parse["items"] as List;
      print('check logging${data}');
      var map = data.map<Versionitem>((json) => Versionitem.fromJson(json));
      if (atttime.statusCode == 200) {
        return map.toList();
      } else if (atttime.statusCode == 503) {
        // throw HttpException('503 Service Unavailable error');
        throw closePopup(
            context, 'Error', '503 Service Unavailable error', 'OK');
      }
    } on SocketException catch (e) {
      throw closePopup(
          context, 'Connection Error', 'No Internet connection', 'OK');
    }
  }

  Future<List<Warehouse_types_items>> getWareHouseTypes(int org_id) async {
    try {
      // parse URI .....
      //https://art.artisticmilliners.com:8081/ords/art/bscan/warehouse/types/?org_id=84
      var menuURL = Uri.parse(BaseURL().WarehouseAuth +
          'types' +
          '/' +
          '?org_id=' +
          org_id.toString());
      final result = await http.get(menuURL);
      var parse = json.decode(result.body);
      var data = parse['items'] as List;
      var map = data.map<Warehouse_types_items>(
          (json) => Warehouse_types_items.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Warehouse_rack_list_items>> getWareHouseRackList(
      int org_id, String wh_type) async {
    try {
      // parse URI .....
      //https://art.artisticmilliners.com:8081/ords/art/bscan/warehouse/rack_list/?org_id=84&wh_type=50
      var menuURL = Uri.parse(BaseURL().WarehouseAuth +
          'rack_list' +
          '/' +
          '?org_id=' +
          org_id.toString() +
          '&wh_type=' +
          wh_type.toString());
      final result = await http.get(menuURL);
      var parse = json.decode(result.body);
      var data = parse['items'] as List;
      var map = data.map<Warehouse_rack_list_items>(
          (json) => Warehouse_rack_list_items.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Warehouse_racks_items>> getWareHouseRack(
      String rack_id, int org_id, String wh_type) async {
    try {
      // parse URI .....
//https://art.artisticmilliners.com:8081/ords/art/bscan/warehouse/racks/?rack_id=A1&wh_type=50&org_id=84
      var menuURL = Uri.parse(BaseURL().WarehouseAuth +
          'racks' +
          '/' +
          '?rack_id=' +
          rack_id.toString() +
          '&wh_type=' +
          wh_type.toString() +
          '&org_id=' +
          org_id.toString());
      final result = await http.get(menuURL);
      var parse = json.decode(result.body);
      var data = parse['items'] as List;
      var map = data.map<Warehouse_racks_items>(
          (json) => Warehouse_racks_items.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<CardsMenuItem>> getMenus(int userId) async {
    try {
      // parse URI .....
      var menuURL = Uri.parse(
          BaseURL().Auth + 'base' + '/' + 'cards' + '/' + userId.toString());

      print('Value of user ID is: ${userId.toString()}');
      final result = await http.get(menuURL);
      var parse = json.decode(result.body);
      var data = parse['items'] as List;
      var map = data.map<CardsMenuItem>((json) => CardsMenuItem.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Typeitem>> gettypeItem(dialogContext, int userId) async {
    try {
      // parse URI .....
      var menuURL = Uri.parse(
          BaseURL().NewAuth + 'EApprovals/typelist/' + userId.toString());
      final result = await http.get(menuURL);
      var parse = json.decode(result.body);
      var data = parse['items'] as List;
      var map = data.map<Typeitem>((json) => Typeitem.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        // throw HttpException('400 Bad Request error');
        throw ErrorPopup(dialogContext, 'Error', '400 Bad Request error', 'OK');
      } else if (result.statusCode == 404) {
        // throw HttpException('404 NOT FOUND');
        throw ErrorPopup(dialogContext, 'Error', '404 NOT FOUND', 'OK');
      } else if (result.statusCode == 503) {
        // throw HttpException('503 Service Unavailable error');
        throw ErrorPopup(
            dialogContext, 'Error', '503 Service Unavailable error', 'OK');
      } else {
        throw ErrorPopup(dialogContext, 'Error',
            'An http error occurred.Page not found. Please try again.', 'OK');
      }
    } on SocketException catch (e) {
      throw ErrorPopup(
          dialogContext, 'Connection Error', 'No Internet connection', 'OK');
    } on HttpException catch (e) {
      throw ErrorPopup(dialogContext, 'Server Error', 'No Service Found', 'OK');
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw ErrorPopup(
          dialogContext, 'Unknown Error', 'An Unknown error occurred.', 'OK');
    }
  }

  Future<List<Essitems>> getProfileData(dialogContext, int userId) async {
    try {
      // parse URI .....
      var menuURL = Uri.parse(BaseURL().Auth + 'ess' + '/' + userId.toString());
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map = data.map<Essitems>((json) => Essitems.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        // throw HttpException('400 Bad Request error');
        throw ErrorPopup(dialogContext, 'Error', '400 Bad Request error', 'OK');
      } else if (result.statusCode == 404) {
        // throw HttpException('404 NOT FOUND');
        throw ErrorPopup(dialogContext, 'Error', '404 NOT FOUND', 'OK');
      } else if (result.statusCode == 503) {
        // throw HttpException('503 Service Unavailable error');
        throw ErrorPopup(
            dialogContext, 'Error', '503 Service Unavailable error', 'OK');
      } else {
        throw ErrorPopup(dialogContext, 'Error',
            'An http error occurred.Page not found. Please try again.', 'OK');
      }
    } on SocketException catch (e) {
      throw ErrorPopup(
          dialogContext, 'Connection Error', 'No Internet connection', 'OK');
    } on HttpException catch (e) {
      throw ErrorPopup(dialogContext, 'Server Error', 'No Service Found', 'OK');
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw ErrorPopup(
          dialogContext, 'Unknown Error', 'An Unknown error occurred.', 'OK');
    }
  }

  Future<List<EmployeeHierarchyitem>> getEmployeeHierarchy(
      String EMPLOYEEcODE) async {
    try {
      // parse URI .....
      var employeeHierarchyURL =
          Uri.parse(BaseURL().Auth + 'empH' + '/' + EMPLOYEEcODE.toString());
      print('Hierarchy url${employeeHierarchyURL}');
      final result = await http.get(employeeHierarchyURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      print('Hierarchy data${data}');
      var map = data.map<EmployeeHierarchyitem>(
          (json) => EmployeeHierarchyitem.fromJson(json));

      if (result.statusCode == 200) {
        print('Hierarchy list${parse}');
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<EmployeeHierarchyitem>> getEmployeeHierarchyLevel(
      String EMPLOYEEcODE, int level) async {
    try {
      // parse URI .....
      var employeeHierarchyURL = Uri.parse(BaseURL().Auth +
          'empH' +
          '/' +
          EMPLOYEEcODE.toString() +
          '/' +
          level.toString());
      print('Hierarchy url${employeeHierarchyURL}');
      final result = await http.get(employeeHierarchyURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      print('Hierarchy data${data}');
      var map = data.map<EmployeeHierarchyitem>(
          (json) => EmployeeHierarchyitem.fromJson(json));

      if (result.statusCode == 200) {
        print('Hierarchy list${parse}');
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<http.Response> gettabular(String EMPLOYEEcODE) async {
    try {
      // parse URI .....
      var performanaceURL = Uri.parse(
          BaseURL().Auth + 'getEmpPerformance' + '/' + EMPLOYEEcODE.toString());
      print('Hierarchy url${performanaceURL}');
      final result = await http.get(performanaceURL);
      if (result.statusCode == 200) {
        print('Hierarchy list${result}');
        return result;
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Items>> getHierarchyLevel(String EMPLOYEEcODE) async {
    //https://art.artisticmilliners.com:8081/ords/art/apis/empH/levels/0109000188
    try {
      // parse URI .....
      var employeeHierarchyURL = Uri.parse(
          BaseURL().Auth + 'empH' + '/levels/' + EMPLOYEEcODE.toString());
      print('Hierarchy level url${employeeHierarchyURL}');
      final result = await http.get(employeeHierarchyURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      print('Hierarchy level data${data}');
      var map = data.map<Items>((json) => Items.fromJson(json));

      if (result.statusCode == 200) {
        print('Hierarchylevel list${parse}');
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<DamUnitListitem>> getDAMUnitList(int userId) async {
    try {
      // parse URI .....
      var menuURL = Uri.parse(
          BaseURL().Auth + 'dam/manager-org' + '/' + userId.toString());
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map =
          data.map<DamUnitListitem>((json) => DamUnitListitem.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Workboardticketitem>> getWorkboardTicketList(
      int orgId, int userId) async {
    try {
      // parse URI .....
      var menuURL = Uri.parse(BaseURL().Auth +
          'ticket/list' +
          '/' +
          orgId.toString() +
          '/' +
          userId.toString());
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map = data.map<Workboardticketitem>(
          (json) => Workboardticketitem.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Statusitems>> getWorkboardStatus(int userId) async {
    try {
      // parse URI .....
      var menuURL = Uri.parse(BaseURL().Auth +
          'ticket/workboard/filters/' +
          userId.toString() +
          '/' +
          '2');
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map = data.map<Statusitems>((json) => Statusitems.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<TicketWorkboarditem>> getTicketWorkboardList(int userId) async {
    try {
      // parse URI .....
      var menuURL =
          Uri.parse(BaseURL().Auth + 'ticket/workboard/' + userId.toString());
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map = data.map<TicketWorkboarditem>(
          (json) => TicketWorkboarditem.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<UnitItems>> getTicketUnit(int userId) async {
    try {
      // parse URI .....
      var menuURL =
          Uri.parse(BaseURL().Auth + 'ticket/unit' + '/' + userId.toString());
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map = data.map<UnitItems>((json) => UnitItems.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<IPolicyitem>> getiPolicy(int userId) async {
    try {
      // parse URI .....
      var menuURL =
          Uri.parse(BaseURL().Auth + 'ipolicy' + '/' + userId.toString());
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map =
          data.map<IPolicyitem>((json) => IPolicyitem.fromJson(json)).toList();
      map.sort((b, a) {
        return a.docNo.toLowerCase().compareTo(b.docNo.toLowerCase());
      });

      if (result.statusCode == 200) {
        return map;
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Deptitems>> getTicketDept(String unitID) async {
    try {
      // parse URI .....
      unitID == null ? '' : unitID;
      var menuURL =
          Uri.parse(BaseURL().Auth + 'ticket/dept' + '/' + unitID.toString());
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map = data.map<Deptitems>((json) => Deptitems.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Severityitems>> getTicketSeverity() async {
    try {
      // parse URI .....
      var menuURL = Uri.parse(BaseURL().Auth + 'ticket/severity');
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map = data.map<Severityitems>((json) => Severityitems.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<AssignItems>> getTicketAssign(String unitID, int deptID) async {
    try {
      // parse URI .....
      deptID == null ? '' : deptID;
      var menuURL = Uri.parse(BaseURL().Auth +
          'ticket/assign' +
          '/' +
          unitID.toString() +
          '/' +
          deptID.toString());
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map = data.map<AssignItems>((json) => AssignItems.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Orderitem>> getorderItemsList(
      String id, String fancyName, String baseBrand) async {
    try {
      var menuURL = Uri.parse(BaseURL().NewAuth +
          'traceability/orders/' +
          id.toString() +
          '/' +
          fancyName +
          '/' +
          baseBrand);
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map = data.map<Orderitem>((json) => Orderitem.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Fpcbranditem>> getFpcBrandModel() async {
    try {
      var menuURL = Uri.parse(BaseURL().NewAuth + 'fpc/brands');
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map = data.map<Fpcbranditem>((json) => Fpcbranditem.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Fpcseasonitem>> getFpcSeasonModel() async {
    try {
      var menuURL = Uri.parse(BaseURL().NewAuth + 'fpc/seasons');
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map = data.map<Fpcseasonitem>((json) => Fpcseasonitem.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Globalparamitem>> getFpcGlobalParamModel(int unitID) async {
    try {
      var menuURL =
          Uri.parse(BaseURL().NewAuth + 'fpc/gb_params' + unitID.toString());
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map =
          data.map<Globalparamitem>((json) => Globalparamitem.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Forwardtoitem>> getFpcForwardToModel(int hSeq) async {
    try {
      var menuURL = Uri.parse(BaseURL().NewAuth + 'fpc/fto' + hSeq.toString());
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map = data.map<Forwardtoitem>((json) => Forwardtoitem.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<DataByTypeitem>> getDatabytypeItem(
      int userId, String type) async {
    try {
      // parse URI .....
      var menuURL = Uri.parse(BaseURL().Auth +
          'approvals' +
          '/' +
          'depreq' +
          '/' +
          userId.toString() +
          '/' +
          type.toString());
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      print('check logging${data}');
      var map =
          data.map<DataByTypeitem>((json) => DataByTypeitem.fromJson(json));
      if (result.statusCode == 200) {
        print('check logging1${map}');
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Totalcount>> getTotalCount(dialogContext, int userId) async {
    try {
      //network request
      // parse URI .....
      //https://artlive.artisticmilliners.com:8081/ords/art/apis/cio/amd2021
      var menuURL = Uri.parse(BaseURL().Auth +
          'approvals' +
          '/' +
          'pendingCounts' +
          '/' +
          userId.toString());
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map = data.map<Totalcount>((json) => Totalcount.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        // throw HttpException('400 Bad Request error');
        throw ErrorPopup(dialogContext, 'Error', '400 Bad Request error', 'OK');
      } else if (result.statusCode == 404) {
        // throw HttpException('404 NOT FOUND');
        throw ErrorPopup(dialogContext, 'Error', '404 NOT FOUND', 'OK');
      } else if (result.statusCode == 503) {
        // throw HttpException('503 Service Unavailable error');
        throw ErrorPopup(
            dialogContext, 'Error', '503 Service Unavailable error', 'OK');
      } else {
        throw ErrorPopup(dialogContext, 'Error',
            'An http error occurred.Page not found. Please try again.', 'OK');
      }
    } on SocketException catch (e) {
      throw ErrorPopup(dialogContext, 'Connection Error',
          'No Internet connection.Kindly refresh the page.', 'OK');
    } on HttpException catch (e) {
      throw ErrorPopup(dialogContext, 'Server Error', 'No Service Found', 'OK');
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw ErrorPopup(
          dialogContext, 'Unknown Error', 'An Unknown error occurred.', 'OK');
    }
  }

  Future<List<AttendenceTotalitem>> getTotalattendence(
      String employeeCode) async {
    try {
      // parse URI .....
      var menuURL = Uri.parse(
          BaseURL().Auth + 'attendance' + '/' + employeeCode.toString());
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map = data.map<AttendenceTotalitem>(
          (json) => AttendenceTotalitem.fromJson(json));
      return map.toList();
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    }
  }


  Future<List<AttendanceCorrectionReport>> getAttendanceReport(String employeeCode) async {
    try {
      // parse URI .....
      var correctionURL = Uri.parse(
          BaseURL().attendanceCorrection  + employeeCode.toString());
      final result = await http.get(correctionURL);

      print(correctionURL);
      var parse = json.decode(result.body);
      var data = parse["items"] as List;

      var map =
      data.map<AttendanceCorrectionReport>((json) => AttendanceCorrectionReport.fromJson(json));
      return map.toList();
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    }
  }
  Future<List<Attendenceitem>> getattendenceData(String employeeCode) async {
    try {
      // parse URI .....
      var menuURL = Uri.parse(
          BaseURL().Auth + 'attendance/status' + '/' + employeeCode.toString());
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      var data = parse["items"] as List;
      var map =
          data.map<Attendenceitem>((json) => Attendenceitem.fromJson(json));
      return map.toList();
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    }
  }

  Future<List<Loginitems>> getLoginUser(
      BuildContext dialogContext, String username, String password) async {
    try {
      //network request
      // parse URI .....
      //https://artlive.artisticmilliners.com:8081/ords/art/apis/cio/amd2021
      var loginURL =
          Uri.parse(BaseURL().Auth + 'auth' + '/' + username + '/' + password);
      print('url: ${loginURL}');
      final result = await http.get(loginURL);
      print('result: ${result.body}');
      var parse = json.decode(result.body);
      print('parse: ${parse}');
      var data = parse['items'] as List;
      print('data: ${data}');
      var map = data.map<Loginitems>((json) => Loginitems.fromJson(json));
      print('map: ${map}');
      if (result.statusCode == 200) {
        print('map list: ${map.toList()}');
        return map.toList();
      } else if (result.statusCode == 400) {
        // throw HttpException('400 Bad Request error');
        throw ErrorPopup(dialogContext, 'Error', '400 Bad Request error', 'OK');
      } else if (result.statusCode == 404) {
        // throw HttpException('404 NOT FOUND');
        throw ErrorPopup(dialogContext, 'Error', '404 NOT FOUND', 'OK');
      } else if (result.statusCode == 503) {
        // throw HttpException('503 Service Unavailable error');
        throw ErrorPopup(
            dialogContext, 'Error', '503 Service Unavailable error', 'OK');
      } else {
        throw ErrorPopup(dialogContext, 'Error',
            'An http error occurred.Page not found. Please try again.', 'OK');
      }
    } on SocketException catch (e) {
      throw ErrorPopup(
          dialogContext, 'Connection Error', 'No Internet connection', 'OK');
    } on HttpException catch (e) {
      throw ErrorPopup(dialogContext, 'Server Error', 'No Service Found', 'OK');
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw ErrorPopup(
          dialogContext, 'Unknown Error', 'An Unknown error occurred.', 'OK');
    }
  }

/*https://artlive.artisticmilliners.com:8081/ords/art/fabric-library/card-result/?org_id=83&flex_vm=&art_desc=&sample_ref=&wanr=&danr=&art_dyecolor=&art_color=&art_weave=&art_picks=&art_reed=&art_reed_width=&art_epi=&art_wvuse=&art_loom=&art_route=&art_stdweight=&art_cut=&art_stdwidth=&art_shrink1=&art_shrink2=&art_comp=*/
  Future<List<FabricCarditems>> getFabricLibCardResult(
      BuildContext dialogContext,
      int org_id,
      String flex_vm,
      String art_desc,
      String sample_ref,
      String wanr,
      String danr,
      String art_dyecolor,
      String art_color,
      String art_weave,
      String art_picks,
      String art_reed,
      String art_reed_width,
      String art_epi,
      String art_wvuse,
      String art_loom,
      String art_route,
      String art_stdweight,
      String art_cut,
      String art_stdwidth,
      String art_shrink1,
      String art_shrink2,
      String art_comp) async {
    try {
      //network request
      // parse URI .....
      //https://artlive.artisticmilliners.com:8081/ords/art/apis/cio/amd2021
      print('value check ${org_id}');
      var loginURL = Uri.parse(BaseURL().NewAuth +
          'fabric-library/card-result/?' +
          'org_id=' +
          org_id.toString() +
          '&flex_vm=' +
          flex_vm +
          '&art_desc=' +
          art_desc +
          '&sample_ref=' +
          sample_ref +
          '&wanr=' +
          wanr +
          '&danr=' +
          danr +
          '&art_dyecolor=' +
          art_dyecolor +
          '&art_color=' +
          art_color +
          '&art_weave=' +
          art_weave +
          '&art_picks=' +
          art_picks +
          '&art_reed=' +
          art_reed +
          '&art_reed_width=' +
          art_reed_width +
          '&art_epi=' +
          art_epi +
          '&art_wvuse=' +
          art_wvuse +
          '&art_loom=' +
          art_loom +
          '&art_route=' +
          art_route +
          '&art_stdweight=' +
          art_stdweight +
          '&art_shrink1=' +
          art_shrink1 +
          '&art_shrink2=' +
          art_shrink2 +
          '&art_comp=' +
          art_comp);
      print('url: ${loginURL}');
      final result = await http.get(loginURL);
      print('result: ${result.body}');
      var parse = json.decode(result.body);
      print('parse: ${parse}');
      var data = parse['items'] as List;
      print('data: ${data}');
      var map =
          data.map<FabricCarditems>((json) => FabricCarditems.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        // throw HttpException('400 Bad Request error');
        throw ErrorPopup(dialogContext, 'Error', '400 Bad Request error', 'OK');
      } else if (result.statusCode == 404) {
        // throw HttpException('404 NOT FOUND');
        throw ErrorPopup(dialogContext, 'Error', '404 NOT FOUND', 'OK');
      } else if (result.statusCode == 503) {
        // throw HttpException('503 Service Unavailable error');
        throw ErrorPopup(
            dialogContext, 'Error', '503 Service Unavailable error', 'OK');
      } else {
        throw ErrorPopup(dialogContext, 'Error',
            'An http error occurred.Page not found. Please try again.', 'OK');
      }
    } on SocketException catch (e) {
      throw ErrorPopup(
          dialogContext, 'Connection Error', 'No Internet connection', 'OK');
    } on HttpException catch (e) {
      throw ErrorPopup(dialogContext, 'Server Error', 'No Service Found', 'OK');
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      print('eror${e.toString()}');
      throw ErrorPopup(
          dialogContext, 'Unknown Error', 'An Unknown error occurred.', 'OK');
    }
  }

  Future<String> fetcheApprovaldepRequestList(
      dialogContext, http.Client client, int userId, int type) async {
    try {
      //https://artlive.artisticmilliners.com:8081/ords/art/EApprovals/notificationlist/5227/1
      final response = await client.get(Uri.parse(BaseURL().NewAuth +
          'EApprovals/notificationlist/' +
          userId.toString() +
          '/' +
          type.toString()));
      print("userID${userId.toString()}");
      print(" type.toString()${type.toString()}");
      // Use the compute function to run parsePhotos in a separate isolate
      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 400) {
        // throw HttpException('400 Bad Request error');
        throw ErrorPopup(dialogContext, 'Error', '400 Bad Request error', 'OK');
      } else if (response.statusCode == 404) {
        // throw HttpException('404 NOT FOUND');
        throw ErrorPopup(dialogContext, 'Error', '404 NOT FOUND', 'OK');
      } else if (response.statusCode == 503) {
        // throw HttpException('503 Service Unavailable error');
        throw ErrorPopup(
            dialogContext, 'Error', '503 Service Unavailable error', 'OK');
      } else {
        throw ErrorPopup(dialogContext, 'Error',
            'An http error occurred.Page not found. Please try again.', 'OK');
      }
    } on SocketException catch (e) {
      throw ErrorPopup(dialogContext, 'Connection Error',
          'No Internet connection.Kindly refresh the page.', 'OK');
    } on HttpException catch (e) {
      throw ErrorPopup(dialogContext, 'Server Error', 'No Service Found', 'OK');
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw ErrorPopup(
          dialogContext, 'Unknown Error', 'An Unknown error occurred.', 'OK');
    }
  }

  Future<String> fetchTicketWorkboard(
      Context, http.Client client, int userId) async {
    try {
      final response = await client.get(
          Uri.parse(BaseURL().Auth + 'ticket/workboard/' + userId.toString()));
      // Use the compute function to run parsePhotos in a separate isolate
      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 400) {
        // throw HttpException('400 Bad Request error');
        throw ErrorPopup(Context, 'Error', '400 Bad Request error', 'OK');
      } else if (response.statusCode == 404) {
        // throw HttpException('404 NOT FOUND');
        throw ErrorPopup(Context, 'Error', '404 NOT FOUND', 'OK');
      } else if (response.statusCode == 503) {
        // throw HttpException('503 Service Unavailable error');
        throw ErrorPopup(
            Context, 'Error', '503 Service Unavailable error', 'OK');
      } else {
        throw ErrorPopup(Context, 'Error',
            'An http error occurred.Page not found. Please try again.', 'OK');
      }
    } on SocketException catch (e) {
      throw ErrorPopup(Context, 'Connection Error',
          'No Internet connection.Kindly refresh the page.', 'OK');
    } on HttpException catch (e) {
      throw ErrorPopup(Context, 'Server Error', 'No Service Found', 'OK');
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw ErrorPopup(
          Context, 'Unknown Error', 'An Unknown error occurred.', 'OK');
    }
  }

  Future<String> ONCLICKfetcheApprovaldepRequestList(dialogContext,
      http.Client client, int userId, int type, int offset, String url) async {
    try {
      final response = await client.get(Uri.parse(url));
      print('reponse of list${response}');
      // Use the compute function to run parsePhotos in a separate isolate
      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 400) {
        // throw HttpException('400 Bad Request error');
        throw ErrorPopup(dialogContext, 'Error', '400 Bad Request error', 'OK');
      } else if (response.statusCode == 404) {
        // throw HttpException('404 NOT FOUND');
        throw ErrorPopup(dialogContext, 'Error', '404 NOT FOUND', 'OK');
      } else if (response.statusCode == 503) {
        // throw HttpException('503 Service Unavailable error');
        throw ErrorPopup(
            dialogContext, 'Error', '503 Service Unavailable error', 'OK');
      } else {
        throw ErrorPopup(dialogContext, 'Error',
            'An http error occurred.Page not found. Please try again.', 'OK');
      }
    } on SocketException catch (e) {
      throw ErrorPopup(dialogContext, 'Connection Error',
          'No Internet connection.Kindly refresh the page.', 'OK');
    } on HttpException catch (e) {
      throw ErrorPopup(dialogContext, 'Server Error', 'No Service Found', 'OK');
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw ErrorPopup(
          dialogContext, 'Unknown Error', 'An Unknown error occurred.', 'OK');
    }
  }

  ErrorPopup(
      BuildContext dialogContext, String title, String msg, String okbtn) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'titlefont'),
      descStyle: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'titlefont'),
      animationDuration: Duration(milliseconds: 400),
    );
    Alert(
        context: dialogContext,
        style: alertStyle,
        title: title,
        desc: msg,
        buttons: [
          DialogButton(
            child: Text(
              okbtn,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              Navigator.pop(dialogContext);
            },
            color: ReColors().appMainColor,
          ),
        ]).show();
  }

  closePopup(
      BuildContext dialogContext, String title, String msg, String okbtn) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'titlefont'),
      descStyle: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'titlefont'),
      animationDuration: Duration(milliseconds: 400),
    );
    Alert(
        context: dialogContext,
        style: alertStyle,
        title: title,
        desc: msg,
        buttons: [
          DialogButton(
            child: Text(
              okbtn,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              closeApp();
              /*Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ListenLocationWidget()),
                  (Route<dynamic> route) => false);*/
            },
            color: Colors.black,
          ),
        ]).show();
  }

  void closeApp() {
    if (Platform.isAndroid) {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    } else {
      MinimizeApp.minimizeApp();
    }
  }

  Future<List<TrainingListitem>> getTrainingList() async {
    try {
      //network request
      // parse URI .....
      //https://artlive.artisticmilliners.com:8081/ords/art/apis/cio/amd2021
      var loginURL = Uri.parse(BaseURL().Auth + 'dhr/training_list');
      print('url: ${loginURL}');
      final result = await http.get(loginURL);
      var parse = json.decode(result.body);
      var data = parse['items'] as List;
      var map =
          data.map<TrainingListitem>((json) => TrainingListitem.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<EmployeeTrainingitems>> getEmployeeTrainingid(int id) async {
    try {
      //network request
      // parse URI .....
      //https://artlive.artisticmilliners.com:8081/ords/art/apis/cio/amd2021
      var loginURL = Uri.parse(BaseURL().Auth +
          'dhr/training/employee_list/?training_id=' +
          id.toString());
      print('url: ${loginURL}');
      final result = await http.get(loginURL);
      var parse = json.decode(result.body);
      var data = parse['items'] as List;
      var map = data.map<EmployeeTrainingitems>(
          (json) => EmployeeTrainingitems.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<SystemAttachedModelitem>> getsystemgeneratedItem(
      int notifyId, int cat_id) async {
    try {
      //network request
      // parse URI .....
      //https://artlive.artisticmilliners.com:8081/ords/art/apis/cio/amd2021
      var loginURL = Uri.parse(BaseURL().Auth +
          'approval/sysattach/' +
          notifyId.toString() +
          '/' +
          cat_id.toString());
      print('url: ${loginURL}');
      final result = await http.get(loginURL);
      var parse = json.decode(result.body);
      print('parsing dataof system attached: ${parse}');
      var data = parse['items'] as List;
      var map = data.map<SystemAttachedModelitem>(
          (json) => SystemAttachedModelitem.fromJson(json));
      if (result.statusCode == 200) {
        print('list of system attached: ${map.toList()}');
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Calendaritems>> getHRCalendar() async {
    try {
      //network request
      // parse URI .....
      //https://artlive.artisticmilliners.com:8081/ords/art/apis/dhr/calendar
      var loginURL = Uri.parse(BaseURL().Auth + 'dhr/calendar');
      print('HR Calndar url: ${loginURL}');
      final result = await http.get(loginURL);
      var parse = json.decode(result.body);
      var data = parse['items'] as List;
      var map = data.map<Calendaritems>((json) => Calendaritems.fromJson(json));
      print('HR Calndar url: ${map.toList()}');
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<http.Response> PostEitdashboardvalue(int org_id, int type) async {
    try {
      //network request
      // parse URI .....
      var employeeImageURL = Uri.parse(BaseURL().Auth +
          "ticket/stats/?orgid=" +
          org_id.toString() +
          "&type_id=" +
          type.toString());
      print('Result${employeeImageURL}');
      final result = await http.get(employeeImageURL);
      if (result.statusCode == 200) {
        print('Result${result.body}');
        return result;
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<http.Response> getAttendancePerfomance(
      String EmployeeId, int type_id) async {
    try {
      //network request
      // parse URI .....
      var employeeImageURL = Uri.parse(BaseURL().Auth +
          "ess/performance/" +
          EmployeeId.toString() +
          '/' +
          type_id.toString());
      print('Result${employeeImageURL}');
      final result = await http.get(employeeImageURL);
      if (result.statusCode == 200) {
        print('Result${result.body}');
        return result;
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<http.Response> getdayWiseUnit(int unit_id) async {
    try {
      //network request
      // parse URI .....
      var employeeImageURL = Uri.parse(BaseURL().NewAuth +
          "dashboard/denim_sales/daywiseunit/" +
          unit_id.toString());
      print('Result${employeeImageURL}');
      final result = await http.get(employeeImageURL);
      if (result.statusCode == 200) {
        print('Result${result.body}');
        return result;
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<UnitModelitems>> getUnit(dialogContext) async {
    try {
      //network request
      // parse URI .....
      var loginURL =
          Uri.parse(BaseURL().NewAuth + 'dashboard/denim_sales/units');
      final result = await http.get(loginURL);
      var parse = json.decode(result.body);
      var data = parse['items'] as List;
      var map =
          data.map<UnitModelitems>((json) => UnitModelitems.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw ErrorPopup(dialogContext, 'Connection Error',
          'No Internet connection.Kindly refresh the page.', 'OK');
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<DenimSalesTotalitems>> getDenimSalesTotal(
      dialogContext, int orgId) async {
    try {
      //network request
      // parse URI .....
      //https://artlive.artisticmilliners.com:8081/ords/art/apis/dhr/calendar
      var loginURL = Uri.parse(BaseURL().NewAuth +
          'dashboard/denim_sales/total' +
          '/' +
          orgId.toString());
      final result = await http.get(loginURL);
      var parse = json.decode(result.body);
      var data = parse['items'] as List;
      var map = data.map<DenimSalesTotalitems>(
          (json) => DenimSalesTotalitems.fromJson(json));
      if (result.statusCode == 200) {
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Bad Request error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Service Unavailable error');
      } else {
        throw HttpException(
            'An http error occurred.Page not found. Please try again.');
      }
    } on SocketException catch (e) {
      throw ErrorPopup(dialogContext, 'Connection Error',
          'No Internet connection.Kindly refresh the page.', 'OK');
    } on HttpException catch (e) {
      throw NoServiceFoundException(e.message);
    } on FormatException catch (e) {
      throw InvalidFormatException(e.message);
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<http.Response> getOneClickSales() async {
    // Uri.parse must when you are passing URL.
    var TargetSalesURL =
        Uri.parse(BaseURL().NewAuth + 'dashboard/denim_sales/targetvssales');
    var TargetSalesresult = await http.get(TargetSalesURL);
    if (TargetSalesresult.statusCode == 200) {
      return TargetSalesresult;
    }
  }
}
