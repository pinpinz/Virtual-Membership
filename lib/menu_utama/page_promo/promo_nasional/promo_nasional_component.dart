import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

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
var pilih;
var listData = [];
Widget katalogshow() {
  if (check == "1") {
    return Expanded(
      child: FutureBuilder(
        future: _fetchListItems("promonasional.php"),
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
                          borderRadius: BorderRadius.circular(17),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: PhotoView(
                          backgroundDecoration:
                              BoxDecoration(color: Colors.transparent),
                          imageProvider: NetworkImage(
                            ip.toString() +
                                "gambar/" +
                                listData[index]["pathGambar"].toString(),
                          ),
                          // enableRotation: true,
                          minScale: PhotoViewComputedScale.contained * 0.8,
                          maxScale: PhotoViewComputedScale.covered * 1.8,
                          initialScale: PhotoViewComputedScale.contained,
                          basePosition: Alignment.center,
                        )),
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
