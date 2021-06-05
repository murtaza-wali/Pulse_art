import 'dart:convert';
import 'dart:io';

import 'package:art/APIUri/BaseUrl.dart';
import 'package:http/http.dart' as http;

import 'LoginUser.dart';
import 'MenuCardsModel.dart';

class LoginAuth {
  Future<List<Item>> getLoginUser(String username, String password) async {
    // parse URI .....
    var loginURL =
        Uri.parse(BaseURL().Auth + 'auth' + '/' + username + '/' + password);

    final result = await http.get(loginURL);
    print(result.statusCode);

    if (result.statusCode == 200) {
      var parse = json.decode(result.body);
      print("parse :- " + parse.toString());
      var data = parse['items'] as List;
      print("data :- " + data.toString());
      var map = data.map<Item>((json) => Item.fromJson(json));
      print('map ${map.toList()}');
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

class MenuCard {
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
}
