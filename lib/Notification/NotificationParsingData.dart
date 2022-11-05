import 'dart:async';

import 'package:art/APIUri/BaseUrl.dart';
import 'package:art/Notification/NotificationURL.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class postNotification {
  Future<String> postplayer_id(int userId, qty, int cardID) async {
    var url = Uri.parse(Url().add_device);
    final http.Response response = await http.post(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('The given data was invalid');
    }
  }

  Future<http.Response> postRequest(String external_user_id, String model,
      String os, String unique_identifier) async {
    var url = Uri.parse('https://onesignal.com/api/v1/players');
    //REST API KEY
    var header = {
      "Content-Type": "application/json; charset=utf-8",
      "Authorization": "Basic OWViMjcxYmEtOWViZC00YzYxLWJmOTUtODEwMDJmMzk4NTll"
    };
    // app id
    Map data = {
      "app_id": "2ff7d472-f741-4952-bfdd-0103b40fbf7d",
      "identifier": unique_identifier,
      "device_type": 1,
      "external_user_id": external_user_id,
      "device_model": model,
      "device_os": os,
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url, headers: header, body: body);
    return response;
  }

  //https://onesignal.com/api/v1/players/PLAYER_ID?app_id=APP_ID

  Future<http.Response> getDeviceData(String PlayerID, String AppID) async {
    // Uri.parse must when you are passing URL.
    var deviceURL = Uri.parse("https://onesignal.com/api/v1/players/" +
        PlayerID.toString() +
        '?app_id=' +
        AppID.toString());
    var deviceresult = await http.get(deviceURL);
    if (deviceresult.statusCode == 200) {
      return deviceresult;
    }
  }

  Future<http.Response> PostEmployeeImage(String employeeCode) async {
    // Uri.parse must when you are passing URL.
    var employeeImageURL = Uri.parse(BaseURL().Auth +"ess/pic/?ecode=" +
        employeeCode.toString() );

    var employeeresult = await http.post(employeeImageURL);
    if (employeeresult.statusCode == 200) {
      return employeeresult;
    }
  }

}
