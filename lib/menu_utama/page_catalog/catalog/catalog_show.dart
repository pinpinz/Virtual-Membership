import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:member_ebs/menu_utama/page_catalog/catalog/catalog_show_component.dart';
import 'package:photo_view/photo_view.dart';

import '../../../main.dart';

class catalog_show_ extends StatefulWidget {
  const catalog_show_({Key? key}) : super(key: key);

  @override
  _catalog_show_State createState() => _catalog_show_State();
}

class _catalog_show_State extends State<catalog_show_> {
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
  var pilih;
  // Widget katalogshow() {
  //   if (check == "1") {
  //     return Expanded(
  //       child: FutureBuilder(
  //         future: _fetchListItems("katalog.php?jenis=" + choice1.toString()),
  //         builder: (context, AsyncSnapshot snapshot) {
  //           if (!snapshot.hasData) {
  //             return Center(child: CircularProgressIndicator());
  //           } else {
  //             listData = snapshot.data;
  //             return ListView.builder(
  //                 itemCount: listData.length,
  //                 itemBuilder: ((context, index) {
  //                   return Container(
  //                     height: MediaQuery.of(context).size.height * 0.765,
  //                     margin: EdgeInsets.all(5),
  //                     decoration: BoxDecoration(
  //                       shape: BoxShape.rectangle,
  //                       color: Color.fromARGB(255, 138, 127, 111),
  //                       borderRadius: BorderRadius.circular(7),
  //                       image: DecorationImage(
  //                           image: NetworkImage(
  //                             ip.toString() +
  //                                 "gambar/" +
  //                                 listData[index]["pathGambar"].toString(),
  //                           ),
  //                           fit: BoxFit.fill),
  //                     ),
  //                   );
  //                 }));
  //           }
  //         },
  //       ),
  //     );
  //   } else {
  //     return Center(
  //       heightFactor: 5,
  //       child: Text(
  //         "- Anda Belum Login -",
  //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //       ),
  //     );
  //   }
  // }

  Widget katalogshoww() {
    if (check == "1") {
      return Expanded(
        child: FutureBuilder(
          future: _fetchListItems("katalog.php?jenis=" + choice1.toString()),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              listData = snapshot.data;
              return Container(
                  color: Colors.transparent,
                  child: FutureBuilder(
                      future: _fetchListItems(
                          "katalog.php?jenis=" + choice1.toString()),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.red,
                            ),
                          );
                        } else {
                          listData = snapshot.data;
                          return CarouselSlider.builder(
                            itemCount: listData.length,
                            itemBuilder: (BuildContext, int index, int jumlah) {
                              return InkWell(
                                  onTap: () {
                                    showDialogFunc(
                                        context,
                                        listData[index]["pathGambar"]
                                            .toString());
                                  },
                                  child: PhotoView(
                                    backgroundDecoration: BoxDecoration(
                                        color: Colors.transparent),
                                    imageProvider: NetworkImage(
                                      ip.toString() +
                                          "gambar/" +
                                          listData[index]["pathGambar"]
                                              .toString(),
                                    ),
                                    // enableRotation: true,
                                    minScale:
                                        PhotoViewComputedScale.contained * 0.8,
                                    maxScale:
                                        PhotoViewComputedScale.covered * 1.8,
                                    initialScale:
                                        PhotoViewComputedScale.contained,
                                    basePosition: Alignment.center,
                                  ));
                            },
                            options: CarouselOptions(
                              scrollDirection: Axis.vertical,
                              aspectRatio: 16 / 24,
                              autoPlay: false,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: false,
                              viewportFraction: 1,
                            ),
                          );
                        }
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
  // List<Product> list = List.from(products);
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
            // color :Color.fromARGB(255, 247, 240, 240),
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
                  "# Catalog # ",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Cabin-Medium'),
                ),
              ),
              // ktg(context),
              katalogshoww(),
              // katalogshow(),
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  height: 50,
                  child: Image.asset(
                    "assets/images/bnd.png",
                  )),
            ],
          ),
        ));
  }
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
                  (MediaQuery.of(context).size.width * 0.76),
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 10,
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
                    height: 5,
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
                          (MediaQuery.of(context).size.width * 0.55),
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

                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // Container(
                  //     alignment: AlignmentDirectional.center,
                  //     child: TextButton(
                  //         onPressed: () {
                  //           Navigator.pop(context);
                  //         },
                  //         child: AutoSizeText("- Tutup -",
                  //             style: TextStyle(
                  //               fontSize: 16,
                  //               color: Color.fromARGB(255, 248, 247, 247),
                  //             )))),
                ],
              ),
            ),
          ),
        );
      });
}
