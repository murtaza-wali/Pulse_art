import 'dart:convert';
import 'dart:io';

import 'package:art/APIUri/BaseUrl.dart';
import 'package:art/Error/Error.dart';
import 'package:art/Model/ApkItem.dart';
import 'package:art/Model/Count.dart';
import 'package:art/Model/DatabyType.dart';
import 'package:art/Model/LoginUser.dart';
import 'package:art/Model/MenuCardsModel.dart';
import 'package:art/Model/transactionByID.dart';
import 'package:art/Model/typeModel.dart';
import 'package:http/http.dart' as http;

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

      if (GPresult.statusCode == 200) {
        var parse = json.decode(GPresult.body);
        var data = parse['items'] as List;
        var GPmap = data.map<GPbyIDitem>((json) => GPbyIDitem.fromJson(json));
        return GPmap.toList();
      } else {
        throw Exception('Failed to create album.');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<DepReqItem>> getTransationItemsById(int userid) async {
    try {
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
        throw HttpException('400 Error');
      } else if (transactionresult.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (transactionresult.statusCode == 503) {
        throw HttpException('503 Error');
      } else {
        throw HttpException('Http Error');
      }
    } on SocketException catch (e) {
      throw NoInternetException('No Internet');
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException('Data Not Found');
    }
  }

  Future<List<CardsMenuItem>> getMenus(int userId) async {
    try {
      // parse URI .....
      var menuURL = Uri.parse(
          BaseURL().Auth + 'base' + '/' + 'cards' + '/' + userId.toString());
      print(menuURL);
      final result = await http.get(menuURL);
      var parse = json.decode(result.body);
      var data = parse['items'] as List;
      var map =
      data.map<CardsMenuItem>((json) => CardsMenuItem.fromJson(json));
      return map.toList();
     /* if (result.statusCode == 200) {

      } else if (result.statusCode == 400) {
        throw HttpException('400 Error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 NOT FOUND');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Error');
      } else {
        throw HttpException('Http Error');
      }*/
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<Typeitem>> gettypeItem(int userId) async {
    // try {
    // parse URI .....
    var menuURL = Uri.parse(BaseURL().Auth +
        'approvals' +
        '/' +
        'typelist' +
        '/' +
        userId.toString());
    print('Type URL${menuURL}');
    final result = await http.get(menuURL);
    print(result);
    var parse = json.decode(result.body);
    print("type item :- " + parse.toString());
    var data = parse['items'] as List;
    print("type data :- " + data.toString());
    var map = data.map<Typeitem>((json) => Typeitem.fromJson(json));
    print('type map ${map.toList()}');
    return map.toList();
/*
      if (result.statusCode == 200) {
        var parse = json.decode(result.body);
        print("type item :- " + parse.toString());
        var data = parse['items'] as List;
        print("type data :- " + data.toString());
        var map = data.map<Typeitem>((json) => Typeitem.fromJson(json));
        print('type map ${map.toList()}');
        return map.toList();
      } else if (result.statusCode == 400) {
        throw HttpException('400 Error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 Error');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Error');
      } else {
        throw HttpException('Http Error');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException(e.message);
    }*/
  }

  Future<List<DataByTypeitem>> getDatabytypeItem(int userId, String type) async {
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
      print(menuURL);
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      print('DATA: ${parse}');
      var data = parse["items"] as List;
      print('DATA: ${data}');
      var map =
          data.map<DataByTypeitem>((json) => DataByTypeitem.fromJson(json));
      // print('data by map ${map.toList()}');
      return map.toList();
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    }
    /*  if (result.statusCode == 200) {

      } else if (result.statusCode == 400) {
        throw HttpException('400 Error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 Error');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Error');
      } else {
        throw HttpException('Http Error');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException(e.message);
    }*/
  }
  Future<List<Totalcount>> getTotalCount(int userId) async {
    try {
      // parse URI .....
      var menuURL = Uri.parse(BaseURL().Auth +
          'approvals' +
          '/' +
          'pendingCounts' +
          '/' +
          userId.toString());
      print(menuURL);
      final result = await http.get(menuURL);

      var parse = json.decode(result.body);
      print('DATA: ${parse}');
      var data = parse["items"] as List;
      print('DATA: ${data}');
      var map =
          data.map<Totalcount>((json) => Totalcount.fromJson(json));
      print('data b ${map.toList()}');
      // print('data by map ${map.toList()}');
      return map.toList();
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    }
    /*  if (result.statusCode == 200) {

      } else if (result.statusCode == 400) {
        throw HttpException('400 Error');
      } else if (result.statusCode == 404) {
        throw HttpException('404 Error');
      } else if (result.statusCode == 503) {
        throw HttpException('503 Error');
      } else {
        throw HttpException('Http Error');
      }
    } on SocketException catch (e) {
      throw NoInternetException(e.message);
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException(e.message);
    }*/
  }

  Future<List<Item>> getLoginUser(String username, String password) async {
    try {
      //network request
      // parse URI .....
      var loginURL =
          Uri.parse(BaseURL().Auth + 'auth' + '/' + username + '/' + password);

      final result = await http.get(loginURL);
      print('STATUSCODE : ${result.statusCode}');

      if (result.statusCode == 200) {
        var parse = json.decode(result.body);
        var data = parse['items'] as List;
        var map = data.map<Item>((json) => Item.fromJson(json));
        return map.toList();
      } else if (result.statusCode == 400) {
        throw Exception('400.');
      } else if (result.statusCode == 404) {
        throw Exception('404.');
      } else {
        throw Exception('ERROR.');
      }
    } on SocketException catch (e) {
      throw NoInternetException('No Internet');
    } on HttpException {
      throw NoServiceFoundException('No Service Found');
    } on FormatException {
      throw InvalidFormatException('Invalid Data Format');
    } catch (e) {
      throw UnknownException(e.message);
    }
  }

  Future<List<ApkItem>> getApkVersion() async {
    // parse URI .....
    var menuURL = Uri.parse(
        'https://art.artisticmilliners.com:8081/ords/art/apis/apkversion/');
    print(menuURL);
    final result = await http.get(menuURL);

    var parse = json.decode(result.body);
    print('DATA: ${parse}');
    var data = parse["items"] as List;
    print('DATA: ${data}');
    var map = data.map<ApkItem>((json) => ApkItem.fromJson(json));
    // print('data by map ${map.toList()}');
    return map.toList();
  }
}
