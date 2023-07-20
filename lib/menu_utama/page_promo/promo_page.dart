import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:member_ebs/menu_utama/page_catalog/catalog/catalog_show.dart';
import 'package:member_ebs/main.dart';
import 'package:member_ebs/menu_utama/page_promo/promo_instore/promo_instore.dart';
import 'package:member_ebs/menu_utama/page_promo/promo_nasional/promo_nasional.dart';

class promo_page_ extends StatefulWidget {
  const promo_page_({Key? key}) : super(key: key);

  @override
  _promo_page_State createState() => _promo_page_State();
}

class _promo_page_State extends State<promo_page_> {
  void initState() {
    super.initState();
  }

  var listData = [];
  getlogo() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.07,
        child: Image.asset(
          "assets/images/logoheader.png",
          fit: BoxFit.cover,
        ));
  }

  backbutton() {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_sharp));
  }

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
  var choice1 = "nu";
  Widget katalogshow() {
    if (check == "1") {
      return Expanded(
          child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const promo_nasional_()),
              );
            },
            child: Container(
              margin: EdgeInsets.all(0),
              height: MediaQuery.of(context).size.width -
                  (MediaQuery.of(context).size.width * 0.385),
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                    image: AssetImage('assets/images/promo/promo_nas.png'),
                    fit: BoxFit.fitWidth),

                //  color: Colors.red,
                //  borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const promo_instore_()),
              );
            },
            child: Container(
              height: MediaQuery.of(context).size.width -
                  (MediaQuery.of(context).size.width * 0.385),
              margin: EdgeInsets.all(0),
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/promo/promo_ins.png'),
                    fit: BoxFit.fitWidth),
                color: Colors.transparent,

                // borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
          ),
        ],
      ));
    } else {
      return Center(
        heightFactor: 5,
        child: Text(
          "- Anda Belum Login -",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: getlogo(),
          // leading: backbutton(),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 103, 9, 29),
          elevation: 3,
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back_motif2.jpeg'),
                fit: BoxFit.cover),
            // color: Color.fromARGB(255, 243, 241, 241),
          ),
          child: Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              katalogshow(),
              Container(
                  // color : Color.fromARGB(255, 233, 231, 231),
                  margin: EdgeInsets.only(bottom: 10),
                  height: 80,
                  child: Image.asset(
                    "assets/images/bnd.png",
                  )),
            ],
          ),
        ));
  }
}
