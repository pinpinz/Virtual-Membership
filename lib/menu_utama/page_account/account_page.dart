import 'dart:convert';
import 'dart:developer';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:member_ebs/menu_utama/page_home/login_page.dart';
import 'package:member_ebs/menu_utama/page_account/account_purchase_hystory.dart';
// import 'package:member_ebs/slider.dart';
import 'package:member_ebs/menu_utama/page_account/account_user_profil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class account_page_ extends StatefulWidget {
  const account_page_({Key? key}) : super(key: key);

  @override
  _account_page_State createState() => _account_page_State();
}

class _account_page_State extends State<account_page_> {
  void initState() {
    super.initState();
    loadSharedPreference();
  }

  var _idMember;
  var idmember = "";
  var nama = "";
  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      try {
        var userindex = jsonDecode(prefs.getString('user')!);
        var namaindex = jsonDecode(prefs.getString('user')!);
        idmember = userindex["noBarcode"];
        nama = userindex["nama"];
      } catch (ex) {
        idmember = "";
      }

      //token = prefs.getString('token');
    });
  }

  int cc = 0;
  informasi(cc) {
    if (idmember == "") {
      Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => const login_page_()),
      );
    } else {
      if (cc == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const account_user_profil_()),
        );
      } else if (cc == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const account_purchase_hystory_()),
        );
      }
    }
  }

  getlogo() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.07,
        child: Image.asset(
          "assets/images/logoheader.png",
          fit: BoxFit.cover,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
            backgroundColor: Color.fromARGB(255, 103, 9, 29),
            elevation: 3,
            snap: false,
            floating: true,
            pinned: true,
            centerTitle: true,
            leading: InkWell(
              onTap: () async {
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // prefs.remove('user');
                // prefs.remove('idmember');
                // var idmember = "";
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext ctx) => MyApp()));
              },
              splashColor: Colors.green,
              // child: Icon(
              //   Icons.logout_rounded,
              //   color: Colors.white,
              // ),
            ),
            title: getlogo()),
        SliverToBoxAdapter(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/back_motif.jpeg'),
                  fit: BoxFit.cover),
              // color: Color.fromARGB(255, 243, 241, 241),
            ),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.64,
            child: Container(
              // padding: EdgeInsets.all(5),
              color: Colors.black12,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.85,
                    // color: Colors.amber,
                    child: Card(
                      shadowColor: Colors.black,
                      elevation: 5,
                      color: Color.fromARGB(255, 160, 160, 160),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: InkWell(
                        onTap: () {
                          showDialogFunc(context, _idMember = idmember);
                        },
                        child: Image.asset(
                          'assets/images/card.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (
              BuildContext context,
              int index,
            ) {
              return Column(
                children: [
                  Container(
                      color: Colors.white,
                      // height: MediaQuery.of(context).size.height * 0.08,
                      child: option(index)),
                  Container(
                    height: 1,
                    color: index <= 1 ? Colors.black12 : Colors.white,
                  )
                ],
              );
            },
            childCount: 10,
          ),
        )
      ],
    ));
  }

  option(menu) {
    if (menu == 0) {
      return InkWell(
        onTap: () {
          informasi(1);
        },
        child: ListTile(
          leading: Icon(
            Icons.manage_accounts,
            color: Color.fromARGB(255, 104, 56, 56),
          ),
          trailing: Icon(Icons.arrow_forward_ios_sharp,
              color: Color.fromARGB(255, 104, 56, 56)),
          title: Text(
            "PROFILE INFORMATION",
            style:
                TextStyle(fontSize: 18, color: Color.fromARGB(255, 53, 53, 53)),
          ),
        ),
      );
    } else if (menu == 1) {
      return InkWell(
        onTap: () {
          informasi(2);
        },
        child: ListTile(
          leading: Icon(Icons.work_history_sharp,
              color: Color.fromARGB(255, 104, 56, 56)),
          trailing: Icon(Icons.arrow_forward_ios_sharp,
              color: Color.fromARGB(255, 104, 56, 56)),
          title: Text(
            "MY POIN",
            style:
                TextStyle(fontSize: 18, color: Color.fromARGB(255, 53, 53, 53)),
          ),
        ),
      );
    }
  }

  showDialogFunc(context, _idMember) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 1,
                height: 250,
                child: Column(
                  children: [
                    if (_idMember == "") ...[
                      BarcodeWidget(
                        barcode: Barcode.code128(),
                        data: "-",
                        height: 200,
                        width: 350,
                      ),
                    ] else ...[
                      BarcodeWidget(
                        barcode: Barcode.code128(),
                        data: _idMember,
                        height: 200,
                        width: 350,
                      ),
                    ]
                  ],
                ),
              ),
            ),
          );
        });
  }

  showDialoghehe(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Center(
                    child: Text("Anda Belum Login!",
                        style: TextStyle(
                            color: Color.fromARGB(255, 103, 9, 29),
                            fontSize: 24,
                            fontFamily: 'Cabin-Medium'))),
              ),
            ),
          );
        });
  }
}
