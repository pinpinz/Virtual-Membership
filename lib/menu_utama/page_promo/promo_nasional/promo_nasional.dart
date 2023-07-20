import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:member_ebs/menu_utama/page_promo/promo_nasional/promo_nasional_component.dart';
import '../../../main.dart';

class promo_nasional_ extends StatefulWidget {
  const promo_nasional_({Key? key}) : super(key: key);

  @override
  _promo_nasional_State createState() => _promo_nasional_State();
}

class _promo_nasional_State extends State<promo_nasional_> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: getlogo(),
          leading: backbutton(),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 103, 9, 29),
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back_motif.jpeg'),
                fit: BoxFit.fitWidth),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "# Promo Nasional #",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              katalogshow(),
              // Container(
              //     margin: EdgeInsets.only(bottom: 10),
              //               height: 50,
              //               child: Image.asset(
              //                 "assets/images/bnd.png",
              //               )),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: AutoSizeText(
                  "- Segera kunjungi The Factory Shop terdekat di kota anda -",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ));
  }
}
