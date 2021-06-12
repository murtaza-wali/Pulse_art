import 'dart:convert';
import 'dart:io';

import 'package:art/APIUri/BaseUrl.dart';
import 'package:art/Model/LoginUser.dart';
import 'package:art/Model/MenuCardsModel.dart';
import 'package:art/Model/transactionByID.dart';
import 'package:http/http.dart' as http;

import '../Model/GPbyID.dart';

class GetJSON {
  Future<List<GPbyIDitem>> getGpItemsById(int userid) async {
    // Uri.parse must when you are passing URL.
    var gpURL = Uri.parse(BaseURL().Auth +
        'approvals' +
        '/' +
        'depreq' +
        '/' +
        userid.toString());

    final GPresult = await http.get(gpURL);

    if (GPresult.statusCode == 200) {
      var parse = json.decode(GPresult.body);
      var data = parse['items'] as List;
      var GPmap = data.map<GPbyIDitem>((json) => GPbyIDitem.fromJson(json));
      return GPmap.toList();
    } else if (GPresult.statusCode == 400) {
      print('Data Not Found');
    } else if (GPresult.statusCode == 404) {
      print('Textfield is empty');
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<List<DepReqItem>> getTransationItemsById(int userid) async {
    // Uri.parse must when you are passing URL.
    var transactionURL = Uri.parse(BaseURL().Auth +
        'approvals' +
        '/' +
        'depreqd' +
        '/' +
        userid.toString());

    final transactionresult = await http.get(transactionURL);

    if (transactionresult.statusCode == 200) {
      var parse = json.decode(transactionresult.body);
      var data = parse['items'] as List;
      var Transactionmap =
          data.map<DepReqItem>((json) => DepReqItem.fromJson(json));
      return Transactionmap.toList();
    } else if (transactionresult.statusCode == 400) {
      print('Data Not Found');
    } else if (transactionresult.statusCode == 404) {
      print('Textfield is empty');
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<List<CardsMenuItem>> getMenus(int userId) async {
    // parse URI .....
    var menuURL = Uri.parse(
        BaseURL().Auth + 'base' + '/' + 'cards' + '/' + userId.toString());
    print(menuURL);
    final result = await http.get(menuURL);
    print(result);

    if (result.statusCode == 200) {
      var parse = json.decode(result.body);
      print("MenuItemparse :- " + parse.toString());
      var data = parse['items'] as List;
      print("MenuItemdata :- " + data.toString());
      var map = data.map<CardsMenuItem>((json) => CardsMenuItem.fromJson(json));
      print('MenuItemmap ${map.toList()}');
      return map.toList();
    } else if (result.statusCode == 400) {
      print('Data Not Found');
    } else if (result.statusCode == 404) {
      print('Textfield is empty');
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<List<Item>> getLoginUser(String username, String password) async {
    // parse URI .....
    var loginURL =
        Uri.parse(BaseURL().Auth + 'auth' + '/' + username + '/' + password);

    final result = await http.get(loginURL);
    print(result.statusCode);

    if (result.statusCode == 200) {
      var parse = json.decode(result.body);
      var data = parse['items'] as List;
      var map = data.map<Item>((json) => Item.fromJson(json));
      return map.toList();
    } else if (result.statusCode == 400) {
      print('Data Not Found');
    } else if (result.statusCode == 404) {
      final error = 'Textfield is empty';
    } else {
      throw Exception('Failed to create album.');
    }
  }
}
