import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:member_ebs/menu_utama/page_catalog/catalog/catalog_show.dart';
import 'package:member_ebs/main.dart';

import 'catalog/catalog_show_component.dart';

class catalog_page_ extends StatefulWidget {
  const catalog_page_({Key? key}) : super(key: key);

  @override
  _catalog_page_State createState() => _catalog_page_State();
}

class _catalog_page_State extends State<catalog_page_> {
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

  List<String> categories = [
    "Sosis",
    "Bakso",
    "Slice",
    "Cake",
    "Dimsum",
    "Instan",
    "Canned",
    "Snack",
    "Freshmeat",
    "Sauce"
  ];
  Widget katalogshow() {
    if (check == "1") {
      return Expanded(
          child: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              choice1 = categories[i];
              print(choice1);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const catalog_show_()),
              );
            },
            child: Container(
              height: MediaQuery.of(context).size.width -
                  (MediaQuery.of(context).size.width * 0.75),
              padding: EdgeInsets.only(bottom: 0, top: 0, right: 10, left: 10),
              child: Card(
                clipBehavior: Clip.hardEdge,
                elevation: 3,
                // shadowColor: Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Image.asset(
                    'assets/images/button/' +
                        categories[i].toString() +
                        '-button.jpeg',
                    fit: BoxFit.fitWidth),
              ),
            ),
          );
        },
      )
          //     GridView(
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //     crossAxisCount: 2,
          //     mainAxisSpacing: 0.5,
          //     crossAxisSpacing: 2,
          //   ),
          //   children: <Widget>[
          //     InkWell(
          //       onTap: () {
          //         choice1 = "sosis";
          //         print(choice1);
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => const katalogpage()),
          //         );
          //       },
          //       child: Card(
          //         color: Colors.transparent,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: const BorderRadius.all(
          //           Radius.circular(50.0),
          //         )),
          //         child: Text("INI SOSIS"),
          //       ),
          //     ),
          //     InkWell(
          //       onTap: () {
          //         choice1 = "bakso";
          //         print(choice1);
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(builder: (context) => const katalogpage()),
          //         );
          //       },
          //       child: Card(
          //         color: Colors.transparent,
          //         shape: RoundedRectangleBorder(
          //             borderRadius: const BorderRadius.all(
          //           Radius.circular(50.0),
          //         )),
          //         child: Text("INI Bakso"),
          //       ),
          //     ),
          //   ],
          // )
          );
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
            color: Color.fromARGB(255, 243, 241, 241),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "#Product Catalog",
                  style: TextStyle(
                      color: Color.fromARGB(255, 103, 9, 29),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              katalogshow(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Produk of BERNARDI",
                  style: TextStyle(
                      color: Color.fromRGBO(48, 46, 46, 1),
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ));
  }
}
