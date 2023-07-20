import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:member_ebs/menu_utama/page_catalog/catalog/catalog_show.dart';

import '../../../main.dart';

Future _fetchListItems(path) async {
  var dio = Dio();
  print(ip + path);
  Response response = await dio.get(
    ip + path, //endpoint api Login
    // options: Options(contentType: Headers.jsonContentType),
  );
  print(response.data);
  Map<String, dynamic> map = jsonDecode(response.data);
  List<dynamic> kembalian = map["member"];
  // List<dynamic> kembalian = jsonDecode(response.data);
  return kembalian;
}

var check = "1";
var choice1 = "null";
