import 'package:art/APIUri/BaseUrl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class postJSON {
  Future<String> postqty(int userId, qty, double cardID) async {
    //https://artlive.artisticmilliners.com:8081/ords/art/apis/depreq/aprqty/:userid/:qty/:cardID
    var url = Uri.parse(BaseURL().Auth +
        'depreq' +
        '/' +
        'aprqty' +
        '/' +
        userId.toString() +
        '/' +
        qty.toString() +
        '/' +
        cardID.toString());

    final http.Response response = await http.post(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('The given data was invalid');
    }
  }

  /*https://art.artisticmilliners.com:8081/ords/art/apis/approvals/deptreq/fwd/1110/134/R/50/abc*/
  Future<http.Response> postRemark(
      int userId, int hid, String status, int notifyID, String remark) async {
    var url = Uri.parse(BaseURL().Auth +
        'approvals' +
        '/' +
        'deptreq' +
        '/' +
        'fwd' +
        '/' +
        userId.toString() +
        '/' +
        hid.toString() +
        '/' +
        status +
        '/' +
        notifyID.toString() +
        '/' +
        remark);
    var response = await http.post(url);
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('The given data was invalid');
    }
  }

/*
  Future<String> postRemark(
      int userId, int hid, String status, int notifyID, String remark) async {
    var url = Uri.parse(BaseURL().Auth +
        'approvals' +
        '/' +
        'deptreq' +
        '/' +
        'fwd' +
        '/' +
        userId.toString() +
        '/' +
        hid.toString() +
        '/' +
        status +
        '/' +
        notifyID.toString() +
        '/' +
        remark);
    print('post check remark: ${url}');
    final http.Response response = await http.post(url);
    if (response.statusCode == 200) {
      print('post check remark123: ${json.encode(jsonDecode(response.body))}');
      return json.encode(jsonDecode(response.body));
    } else {
      throw Exception('The given data was invalid');
    }
  }
*/

  //https://artlive.artisticmilliners.com:8081/ords/art/apis/ticket/:emp_code/:subject/:t_description/:severity_id/:dept_id/:to_dept_id/:assign_to/:user_id/:org_id
  Future<String> postTicket(
      String emp_code,
      String subject,
      String description,
      int severity_id,
      int dept_code,
      int deptid,
      String assignid,
      int userId,
      String uni_id) async {
    var url = Uri.parse(BaseURL().Auth +
        'ticket' +
        '/' +
        emp_code.toString() +
        '/' +
        subject.toString() +
        '/' +
        description.toString() +
        '/' +
        severity_id.toString() +
        '/' +
        dept_code.toString() +
        '/' +
        deptid.toString() +
        '/' +
        assignid.toString() +
        '/' +
        userId.toString() +
        '/' +
        uni_id.toString());
    final http.Response response = await http.post(url);

    if (response.statusCode == 200) {
      return json.decode(json.encode(response.body));
    } else {
      throw Exception('The given data was invalid');
    }
  }

  //https://artlive.artisticmilliners.com:8081/ords/art/apis/add_device/:user_id/:player_id/:device_type/:device_model/:device_os/:invalid_identifier/:ip_address
  Future<String> postNotification(
      int user_id,
      String player_id,
      int device_type,
      String device_model,
      String device_os,
      String invalid_identifier,
      String ip_address,
      String isactive) async {
    var url = Uri.parse(BaseURL().Auth +
        'add_device' +
        '/' +
        user_id.toString() +
        '/' +
        player_id.toString() +
        '/' +
        device_type.toString() +
        '/' +
        device_model.toString() +
        '/' +
        device_os.toString() +
        '/' +
        invalid_identifier.toString() +
        '/' +
        ip_address.toString() +
        '/' +
        isactive.toString());
    final http.Response response = await http.post(url);

    if (response.statusCode == 200) {
      return json.decode(json.encode(response.body));
    } else {
      throw Exception('The given data was invalid');
    }
  }

  Future<int> PostAssets(int org_id, String employeeCode, int type) async {
    // Uri.parse must when you are passing URL.
    var employeeImageURL = Uri.parse(BaseURL().Auth +
        "dam/stats/?org_id=" +
        org_id.toString() +
        "&ecode=" +
        employeeCode.toString() +
        "&type_id=" +
        type.toString());
    print('Assets url${employeeImageURL}');
    var employeeresult = await http.post(employeeImageURL);
    print('Assets result${employeeresult.body}');
    if (employeeresult.statusCode == 200) {
      Map<String, dynamic> accessories_map = jsonDecode(employeeresult.body);
      return accessories_map['type_counts'];
    }
  }

  Future<int> PostEitdashboardvalue(int org_id, int type) async {
    // Uri.parse must when you are passing URL.
    var employeeImageURL = Uri.parse(BaseURL().Auth +
        "ticket/stats/?org_id=" +
        org_id.toString() +
        "&type_id=" +
        type.toString());
    print('Assets url${employeeImageURL}');
    var employeeresult = await http.post(employeeImageURL);
    print('Assets result${employeeresult.body}');
    if (employeeresult.statusCode == 200) {
      Map<String, dynamic> accessories_map = jsonDecode(employeeresult.body);
      return accessories_map['type_counts'];
    }
  }

  //https://art.artisticmilliners.com:8081/ords/art/apis/dhr/training/employee_list/?enroll_id=0113000452-1&user_id=5118&enroll_status=A

  Future<String> PostTriaingEmployee(BuildContext context, String enroll_id,
      int user_id, String enroll_status) async {
    // Uri.parse must when you are passing URL.
    var employeeImageURL = Uri.parse(BaseURL().Auth +
        "dhr/training/employee_list/?enroll_id=" +
        enroll_id.toString() +
        "&user_id=" +
        user_id.toString() +
        '&enroll_status=' +
        enroll_status);
    print('enroll url${employeeImageURL}');
    final http.Response employeeresult = await http.post(employeeImageURL);
    print('enroll result${employeeresult.body}');

    if (employeeresult.statusCode == 200) {
      print('enroll result.statusCode${employeeresult.statusCode}');
      return json.decode(json.encode(employeeresult.body));
    } else {
      throw Exception('The given data was invalid');
    }
  }

  Future<String> PostTupdatePassword(
      BuildContext context, String username, String updatePSW) async {
    // Uri.parse must when you are passing URL.
    var updatepswURL = Uri.parse(BaseURL().Auth +
        "auth/reset_password/" +
        username.toString() +
        "/" +
        updatePSW.toString());
    print('enroll url${updatepswURL}');
    final http.Response updatepswresult = await http.post(updatepswURL);
    print('update result${updatepswresult.body}');

    if (updatepswresult.statusCode == 200) {
      print('enroll result.statusCode${updatepswresult.statusCode}');
      return json.decode(json.encode(updatepswresult.body));
    } else {
      throw Exception('The given data was invalid');
    }
  }
}
