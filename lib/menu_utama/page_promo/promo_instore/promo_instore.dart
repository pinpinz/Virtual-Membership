import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../../../main.dart';

class promo_instore_ extends StatefulWidget {
  const promo_instore_({Key? key}) : super(key: key);

  @override
  _promo_instore_State createState() => _promo_instore_State();
}

class _promo_instore_State extends State<promo_instore_> {
  void initState() {
    super.initState();

    pilihan = "Sidoarjo - Buduran";
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
  var pilih;
  Widget katalogshow(pilih) {
    if (check == "1") {
      return Expanded(
        child: FutureBuilder(
          future: _fetchListItems("promolokal.php?jenis=" + pilih.toString()),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              listData = snapshot.data;
              return ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        showDialogFunc(
                            context, listData[index]["pathGambar"].toString());
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.75,
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          // color: Color.fromARGB(255, 233, 232, 231),
                          borderRadius: BorderRadius.circular(17),
                          //   image: DecorationImage(

                          //       image: NetworkImage(

                          //         ip.toString() +
                          //             "gambar/" +
                          //             listData[index]["pathGambar"].toString(),

                          //       ),

                          //       fit: BoxFit.fitWidth),
                        ),
                        child: PhotoView(
                          backgroundDecoration:
                              BoxDecoration(color: Colors.transparent),
                          imageProvider: NetworkImage(
                            ip.toString() +
                                "gambar/" +
                                listData[index]["pathGambar"].toString(),
                          ),
                          // enableRotation: true,

                          minScale: PhotoViewComputedScale.contained * 1,
                          maxScale: PhotoViewComputedScale.covered * 1.8,
                          initialScale: PhotoViewComputedScale.contained,
                          basePosition: Alignment.center,
                        ),
                        clipBehavior: Clip.hardEdge,
                      ),
                    );
                  }));
            }
          },
        ),
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

  var tujuan = "";
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
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "# Promo Instore #",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // ktg(context),
              katalogshow(pilihan),
              Container(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.28,
                        margin: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.1),
                        child: AutoSizeText(
                          "Lokasi Promo  : ",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                          maxLines: 1,
                        ),
                      ),
                      DropdownButton(
                        hint: Text(' Please choose a location '),
                        alignment: Alignment.center,
                        // iconEnabledColor: Color.fromARGB(255, 66, 63, 63),
                        // iconSize: 40,
                        dropdownColor: Colors.white,
                        items: categories.map((categories) {
                          return DropdownMenuItem(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                categories,
                                style: (TextStyle(
                                    fontSize: 14, fontFamily: "Gotham")),
                              ),
                            ),
                            value: categories,
                          );
                        }).toList(),
                        value: pilihan,
                        onChanged: (newValue) {
                          setState(() {
                            pilihan = newValue;
                          });
                          print("Pilihan saya ...");
                          print(pilihan);
                        },
                      ),
                    ],
                  ),
                ],
              )),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AutoSizeText(
                    "- Segera kunjungi The Factory Shop terdekat di kota anda -",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  List<String> categories = [
    "Sidoarjo - Buduran",
    "Surabaya - Merr",
    "Surabaya - HR Muhammad",
    "Denpasar - Imam Bonjol",
    "Pasuruan - Gempol",
    "Malang - Oro-Oro Dowo",
    // "Bekasi - Tambun Selatan",
    "Tangerang - Serpong",
  ];

  int indexkepilih = 0;
  // Widget ktg(BuildContext context) {
  //   return SizedBox(
  //     height: 35,
  //     child: ListView.builder(
  //       scrollDirection: Axis.horizontal,
  //       itemCount: categories.length,
  //       itemBuilder: (context, index) => buildCategory(index),
  //     ),
  //   );
  // }

  var pilihan;
  // Widget buildCategory(int index) {
  //   return GestureDetector(
  //     onTap: () {
  //       setState(() {
  //         indexkepilih = index;
  //         pilihan = categories[index].toLowerCase();
  //         print("pilihan saya adalah ......");
  //         print(pilihan);
  //       });
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.all(5),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             categories[index],
  //             style: TextStyle(
  //                 color: indexkepilih == index ? Colors.black : Color.fromARGB(255, 180, 37, 37),
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 20),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

showDialogFunc(context, desc) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 51, 9, 9),
              ),
              padding: const EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.width +
                  (MediaQuery.of(context).size.width * 0.6),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 13,
                  ),
                  AutoSizeText(
                    "PREVIEW",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AutoSizeText(
                    "Ketuk 2x untuk Zoom / Cubit",
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.width +
                          (MediaQuery.of(context).size.width * 0.4),
                      child: PhotoView(
                        backgroundDecoration:
                            BoxDecoration(color: Colors.transparent),
                        imageProvider: NetworkImage(
                          ip.toString() + "gambar/" + desc,
                        ),
                        // enableRotation: true,
                        minScale: PhotoViewComputedScale.contained * 1,
                        maxScale: PhotoViewComputedScale.covered * 2,
                        initialScale: PhotoViewComputedScale.contained,
                        basePosition: Alignment.center,
                      )),
                ],
              ),
            ),
          ),
        );
      });
}
