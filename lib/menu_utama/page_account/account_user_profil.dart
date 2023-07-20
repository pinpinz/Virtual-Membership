import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:member_ebs/menu_bar_page.dart';
import 'package:member_ebs/menu_utama/page_home/update_password.dart';
import '../../main.dart';
import '../page_home/home_page.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

var listData = [];

class account_user_profil_ extends StatefulWidget {
  const account_user_profil_({Key? key}) : super(key: key);

  @override
  _account_user_profil_State createState() => _account_user_profil_State();
}

var _idMember;
var totalp;
var indox = 0;

class _account_user_profil_State extends State<account_user_profil_> {
  void initState() {
    // TODO: implement initState
    super.initState();
    loadSharedPreference();
  }

  var username = "";
  var passw = "";
  var pin = "";
  var idmember = "";
  var nama = "";
  var _alamat = "";
  var hp = "";
  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      try {
        var userindex = jsonDecode(prefs.getString('user')!);
        var namaindex = jsonDecode(prefs.getString('user')!);
        idmember = userindex["idMember"];
        nama = namaindex["nama"];
        _alamat = userindex["alamat"];
        hp = userindex["hp"];
        username = userindex["username"];
        passw = userindex["pass"];
        pin = userindex["pin"];
      } catch (ex) {
        idmember = "";
      }

      //token = prefs.getString('token');
    });
  }

  Widget getNama() {
    if (idmember == "") {
      return Container(
          child: Text(
        "The Factory Shop Virtual Member",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ));
    } else {
      return Container(
          child: Text(
        "Hello " + nama,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ));
    }
  }

  Future _fetchListItems(idmember, path) async {
    var dio = Dio();
    print(ip + path + idmember);
    Response response = await dio.get(
      ip + path + idmember, //endpoint api Login
      // options: Options(contentType: Headers.jsonContentType),
    );
    print(response.data);
    Map<String, dynamic> map = jsonDecode(response.data);
    List<dynamic> kembalian = map["member"];
    // List<dynamic> kembalian = jsonDecode(response.data);
    return kembalian;
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
     appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          splashColor: Colors.green,
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: getlogo(),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 103, 9, 29),
        elevation: 3,
      ),
      body: Container(
              color: Colors.white,
        padding : EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05,left: MediaQuery.of(context).size.width * 0.05),
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Container(
               margin: EdgeInsets.only(top:15,bottom: 10),
              width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.6) ,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/home_profil.png'),
                        fit: BoxFit.fill,
                        ),
                  ),
                ),
            Container(
child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8,left: 8),
                    child: Text(
                      "ID Virtual Member",
                      style: TextStyle(color: Color.fromARGB(255, 103, 9, 29), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: Color.fromARGB(255, 255, 255, 249),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "" + idmember,
                      style: TextStyle(color: Color.fromARGB(255, 46, 46, 46), fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            Container(
child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8,left: 8),
                    child: Text(
                      "Nama Member (Sesuai KTP/SIM)",
                      style: TextStyle(color: Color.fromARGB(255, 103, 9, 29), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Card(
               color: Color.fromARGB(255, 255, 255, 249),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "" + nama,
                      style: TextStyle(color: Color.fromARGB(255, 46, 46, 46), fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
             Container(
child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8,left: 8),
                    child: Text(
                      "Nomor HP (AKtif)",
                      style: TextStyle(color: Color.fromARGB(255, 103, 9, 29), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Card(
               color: Color.fromARGB(255, 255, 255, 249),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "" + hp,
                      style: TextStyle(color: Color.fromARGB(255, 46, 46, 46), fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
             Container(
child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8,left: 8),
                    child: Text(
                      "Alamat Domisili (Sesuai KTP/SIM)",
                      style: TextStyle(color: Color.fromARGB(255, 103, 9, 29), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: Color.fromARGB(255, 255, 255, 249),
    
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                
                children: [
                  Expanded(
                   
                    child: Padding(
                                           padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "" + _alamat,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        textWidthBasis: TextWidthBasis.longestLine,
                        style: TextStyle(color: Color.fromARGB(255, 46, 46, 46), fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
             Container(
child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8,left: 8),
                    child: Text(
                      "Username",
                      style: TextStyle(color: Color.fromARGB(255, 103, 9, 29), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Card(
               color: Color.fromARGB(255, 255, 255, 249),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "" + username,
                      style: TextStyle(color:  Color.fromARGB(255, 46, 46, 46), fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            Container(

                margin: const EdgeInsets.only(top: 15),
                width: MediaQuery.of(context).size.width * 0.65,
                child: MaterialButton(
                  onPressed: () async {
                     SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove('user');
                prefs.remove('idmember');
                var idmember = "";
               Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => menu_bar_page_()),
                                   ModalRoute.withName('/'));
                  },
                  child: const Text("Sign Out",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18)),
                  color: Color.fromARGB(255, 103, 9, 29),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  padding: const EdgeInsets.all(10),
                )),
                Container(

                margin: const EdgeInsets.only(top: 15,bottom: 30),
                width: MediaQuery.of(context).size.width * 0.65,
                child: MaterialButton(
                  onPressed: () async {
                   
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => update_password_()));
                  },
                  child: const Text("Change Password & PIN",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18)),
                  color: Color.fromARGB(255, 207, 154, 8),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  padding: const EdgeInsets.all(10),
                )),
          ],
        ),
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
                borderRadius: BorderRadius.circular(2),
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
