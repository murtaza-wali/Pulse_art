import 'package:art/APIUri/BaseUrl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class postJSON {
  Future<String> postqty(int userId, qty, int lineID) async {
    var url = Uri.parse(BaseURL().Auth +
        'depreq' +
        '/' +
        'aprqty' +
        '/' +
        userId.toString() +
        '/' +
        qty.toString() +
        '/' +
        lineID.toString());
    print('POST URL${url}');
    final http.Response response = await http.post(url);
    print('Response body: ${response.body}');
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('The given data was invalid');
    }
  }

  /*https://art.artisticmilliners.com:8081/ords/art/apis/approvals/deptreq/fwd/1110/134/R/50/abc*/

  Future<String> postRemark(
      int userId, int hid, String status, int transID, String remark) async {
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
        transID.toString() +
        '/' +
        remark);
    print('POST URL${url}');
    final http.Response response = await http.post(url);
    print('Response body: ${response.body}');
    print('Response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      return json.encode(jsonDecode(response.body));
    } else {
      throw Exception('The given data was invalid');
    }
  }
}
