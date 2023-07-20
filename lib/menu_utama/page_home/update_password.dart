import 'dart:async';
import 'package:flutter/material.dart';
import 'package:member_ebs/menu_bar_page.dart';
import '../../main.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

var listData = [];

class update_password_ extends StatefulWidget {
  const update_password_({Key? key}) : super(key: key);

  @override
  _update_password_State createState() => _update_password_State();
}

var _idMember;
var totalp;
var indox = 0;

class _update_password_State extends State<update_password_> {
  final username1Controller = TextEditingController();
  final password0Controller = TextEditingController();
  final password1Controller = TextEditingController();
  final password2Controller = TextEditingController();
  final pin1Controller = TextEditingController();
  late bool obscureText0,obscureText1, obscureText2, obscureText3;

  String currentText = "";

  final formKey = GlobalKey<FormState>();
  TextEditingController textEditingController = TextEditingController();

  void initState() {
    // TODO: implement initState
    obscureText0 = true;
    obscureText1 = true;
    obscureText2 = true;
    obscureText3 = true;
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

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  updateuser() async {
    var dio = Dio();
    print("id member " + idmember.toString());
    print("username " + username1Controller.text);
    print("password1 " + password1Controller.text);
    print("pin " + pin1Controller.text);

    var paramIDMember = Uri.encodeComponent(idmember.toString());
    var paramUsername = Uri.encodeComponent(username1Controller.text);
    var paramOldPassword = Uri.encodeComponent(password0Controller.text);
    var paramPassword = Uri.encodeComponent(password1Controller.text);
    var paramPin = Uri.encodeComponent(pin1Controller.text);
    var url = ip +
        "updatepassword.php?idmember=" +
        paramIDMember +
        "&username=" +
        paramUsername +
        "&oldPassword=" +
        paramOldPassword +
        "&password=" +
        paramPassword +
        "&pin=" +
        paramPin;
    print("url " + url);
    Response response = await dio.get(
      url, //endpoint api Login
      // options: Options(contentType: Headers.jsonContentType),
    );
    var hasil = jsonDecode(response.data);
    print("found " + hasil["hasil"].toString());
    if (pin1Controller.text.toString().length < 6) {
      showupdateuser(context, 5);
    } else {
      if (password1Controller.text.toString() !=
          password2Controller.text.toString()) {
        showupdateuser(context, 4);
      } else {
        if(password1Controller.text.toString().length < 6){
showupdateuser(context, 7);
        } else {
        if (hasil["hasil"].toString() == "pin terlalu mudah") {
          showupdateuser(context, 1);
        } else if (hasil["hasil"].toString() == "password terlalu mudah") {
          showupdateuser(context, 2);
        } else if (hasil["hasil"].toString() == "username sudah ada") {
          showupdateuser(context, 3);
        } else if (hasil["hasil"].toString() == "pass old salah") {
          showupdateuser(context, 6);
        } else if (hasil["hasil"].toString() == "ok") {
          _onWidgetDidBuild(() {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Update Berhasil'),
                backgroundColor: Colors.green,
              ),
            );
          });
           Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => menu_bar_page_()),
                                   ModalRoute.withName('/'));
        }
      }
    }
    }

    /*
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StarbucksApp()),
    );*/
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
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => menu_bar_page_()),
                                   ModalRoute.withName('/'));
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
        // child : Expanded(
          child: SingleChildScrollView(
        child : Column (
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
                 Container(
                  height: MediaQuery.of(context).size.width - (MediaQuery.of(context).size.width * 0.7) ,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/home_pendek.jpg'),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "" + idmember,
                    style: TextStyle(color: Color.fromARGB(255, 31, 30, 30), fontSize: 16),
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
                      "UserName",
                      style: TextStyle(color: Color.fromARGB(255, 103, 9, 29), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [                
                Container(
                  
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: '...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8),
                    ),
                    controller: username1Controller,
                    keyboardType: TextInputType.name,
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
                      "Old Password",
                      style: TextStyle(color: Color.fromARGB(255, 103, 9, 29), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                   
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: '...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        controller: password0Controller,
                        keyboardType: TextInputType.name,
                        obscureText: obscureText0,
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: !obscureText0
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText0 = !obscureText0;
                      });
                    },
                  ),
                )
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
                      "Password",
                      style: TextStyle(color: Color.fromARGB(255, 103, 9, 29), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                   
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: '...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        controller: password1Controller,
                        keyboardType: TextInputType.name,
                        obscureText: obscureText1,
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: !obscureText1
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText1 = !obscureText1;
                      });
                    },
                  ),
                )
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
                      "Konfirmasi Password",
                      style: TextStyle(color: Color.fromARGB(255, 103, 9, 29), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                   
                    Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: '...',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        controller: password2Controller,
                        keyboardType: TextInputType.name,
                        obscureText: obscureText2,
                      ),
                    ),
                  ],
                ),
                Container(
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: !obscureText2
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText2 = !obscureText2;
                      });
                    },
                  ),
                )
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
                      "Set PIN",
                      style: TextStyle(color: Color.fromARGB(255, 103, 9, 29), fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextFormField(
                    maxLength: 6,
                  
                    decoration: const InputDecoration(
                      hintText: '...',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(8),
                    ),
                    controller: pin1Controller,
                    keyboardType: TextInputType.number,
                    obscureText: obscureText3,
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: !obscureText3
                          ? Colors.black.withOpacity(0.3)
                          : Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText3 = !obscureText3;
                      });
                    },
                  ),
                )
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                margin: const EdgeInsets.all(25),
                width: MediaQuery.of(context).size.width * 0.45,
                child: MaterialButton(
                  onPressed: () {
                    /*
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StarbucksApp()),
                    );*/
                    updateuser();
                  },
                  child: const Text("Update",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16)),
                   color: Color.fromARGB(255, 103, 9, 29),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  padding: const EdgeInsets.all(16),
                )),
          ])
        ],
      ),
      ),
      ),
    );
  }

  showupdateuser(context, kode) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color.fromARGB(255, 247, 247, 247),
                ),
                padding: const EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width * 0.80,
                height: MediaQuery.of(context).size.height * 0.13,
                child: Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      if (kode == 1) ...[
                        Text(
                          "Pin Terlalu Mudah",
                          style: TextStyle(
                              color: Color.fromARGB(255, 54, 54, 54),
                              fontSize: 24,
                              fontFamily: 'gothamMedium'),
                        ),
                      ] else if (kode == 2) ...[
                        Text(
                          "password Terlalu Mudah",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 54, 54, 54),
                              fontSize: 24,
                              fontFamily: 'gothamMedium'),
                        ),
                      ] else if (kode == 3) ...[
                        Text(
                          "USERNAME Sudah Ada",
                          style: TextStyle(
                              color: Color.fromARGB(255, 54, 54, 54),
                              fontSize: 24,
                              fontFamily: 'gothamMedium'),
                        ),
                      ] else if (kode == 4) ...[
                        Text(
                          "Validasi Password Tidak Sama",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 54, 54, 54),
                              fontSize: 24,
                              fontFamily: 'gothamMedium'),
                        ),
                      ] else if (kode == 5) ...[
                        Text(
                          "Pin Harus 6 Angka",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 54, 54, 54),
                              fontSize: 24,
                              fontFamily: 'gothamMedium'),
                        ),
                         ] else if (kode == 6) ...[
                        Text(
                          "Password Lama anda salah",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 54, 54, 54),
                              fontSize: 24,
                              fontFamily: 'gothamMedium'),
                        ),
                        ] else if (kode == 7) ...[
                        Text(
                          "Password Minimal 6 huruf/angka",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 54, 54, 54),
                              fontSize: 24,
                              fontFamily: 'gothamMedium'),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
