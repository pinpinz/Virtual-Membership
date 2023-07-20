import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:member_ebs/menu_utama/page_home/login_page.dart';
import 'package:member_ebs/menu_utama/page_promo/promo_instore/promo_instore.dart';
import 'package:member_ebs/menu_utama/page_promo/promo_nasional/promo_nasional.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../main.dart';

class home_page_ extends StatefulWidget {
  const home_page_({Key? key}) : super(key: key);

  @override
  _home_page_State createState() => _home_page_State();
}

//deklarasi variable --------------------------------------------------------------------------------
List itemList = [1, 2, 3, 4, 5];

late Timer _rootTimer;

var tujuan = "";
var listData1 = [];
var listData2 = [];
var idmember = "";
var nama = "";

class _home_page_State extends State<home_page_> {
// deklarasi class

  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    // TODO: implement initState

    super.initState();

    loadSharedPreference();
  }

// list Fuction --------------------------------------------------------------------------------------------------------------------------

  Future _fetchListItems1(path) async {
    var dio = Dio();
    print(ip + path);
    Response response = await dio.get(
      ip + path, //endpoint api Login
      options: Options(contentType: Headers.jsonContentType),
    );

    Map<String, dynamic> map = jsonDecode(response.data);
    //print("member 0:");
    //print("bkembalian");
    //print(map["member"]);

    print(response.data);
    List<dynamic> kembalian = [];
    try {
      kembalian = map["member"] as List<dynamic>;
    } catch (ex) {
      print("error");
      print(ex);
    }

    //#print("kembalian");
    //print(kembalian);
    // List<dynamic> kembalian = jsonDecode(response.data);
    return kembalian;
  }

  loadSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      try {
        var userindex = jsonDecode(prefs.getString('user')!);
        idmember = userindex["idMember"];
      } catch (ex) {
        idmember = "";
      }
      //token = prefs.getString('token');
    });
  }

//list Wigdet --------------------------------------------------------------------------------------------------------------------------

  Widget getlogin() {
    if (idmember != "") {
      return Text(
        '',
        style: TextStyle(color: Colors.white, fontSize: 20),
      );
    } else {
      return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        // Icon(
        //   Icons.merge_outlined,
        //   size: 25,
        //   color: Colors.black,
        // ),
        TextButton(
            onPressed: () {
              Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => const login_page_()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset(
                "assets/images/icon/user.png",
                color: Color.fromARGB(255, 245, 240, 225),
                height: 28,
              ),
            ))
      ]);
    }
  }

  Widget getlogo() {
    return Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.00,
            left: 0,
            right: 0,
            bottom: 0),
        height: MediaQuery.of(context).size.height * 0.07,
        child: Image.asset(
          "assets/images/logoheader.png",
          fit: BoxFit.cover,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          //wrap with PreferredSize
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.06),

          child: AppBar(
            //                    shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.vertical(
            //     bottom: Radius.circular(30),
            //   ),
            // ),

            title: getlogo(),
            actions: [getlogin()],
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 103, 9, 29),
            elevation: 3,
          ),
        ),
        // drawer: const navigationdrawer(),
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/back_motif2.jpeg'),
                fit: BoxFit.cover),
            // color: Color.fromARGB(255, 243, 241, 241),
          ),
          child: SingleChildScrollView(
            // physics: ScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width -
                      (MediaQuery.of(context).size.width * 0.35),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/home.jpg'),
                      fit: BoxFit.fill,
                    ),
                    // borderRadius: BorderRadius.all(Radius.circular(25)),color: Color.fromARGB(255, 179, 177, 177),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                      top: 0,
                      left: 5,
                      right: 5,
                      bottom: 0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //  borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: FutureBuilder(
                        future: _fetchListItems1("gambarpromo.php"),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            listData1 = snapshot.data;
                            print(listData1.length);
                            return CarouselSlider.builder(
                              itemCount: listData1.length,
                              itemBuilder:
                                  (BuildContext, int index, int jumlah) {
                                return InkWell(
                                    onTap: () {
                                      // _launchURL(1);
                                    },
                                    splashColor: Colors.redAccent,
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        //  color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15)),
                                      ),

                                      // child: Text(index.toString()),
                                      // child: Card(

                                      child: Image.network(
                                        ip.toString() +
                                            "gambar/" +
                                            listData1[index]["pathGambar"]
                                                .toString(),
                                        fit: BoxFit.fitWidth,
                                        errorBuilder:
                                            (BuildContext, Object, StackTrace) {
                                          return Text("Connection Error");
                                        },
                                      ),
                                      // )
                                    ));
                              },
                              options: CarouselOptions(
                                scrollDirection: Axis.horizontal,
                                enlargeCenterPage: false,
                                aspectRatio: 16 / 8,
                                autoPlay: true,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll:
                                    true, //jika diset true dan tidak ada data gambar maka akan error
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 600),
                                viewportFraction: 1,
                              ),
                            );
                          }
                        })),

                Container(
                  margin: EdgeInsets.only(
                    top: 0,
                    left: MediaQuery.of(context).size.width * 0.04,
                    right: MediaQuery.of(context).size.width * 0.04,
                    bottom: 0,
                  ),
                  clipBehavior: Clip.hardEdge,
                  height: MediaQuery.of(context).size.width -
                      (MediaQuery.of(context).size.width * 0.52),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/benefit.jpg'),
                        fit: BoxFit.fitWidth),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 0,
                    right: 0,
                    bottom: 0,
                  ),
                  // height: MediaQuery.of(context).size.height * 0.38,
                  width: MediaQuery.of(context).size.width * 1,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  AutoSizeText(
                                    "Bernardi The Factory Shop",
                                    style: TextStyle(
                                        fontSize: 25, fontFamily: 'gotham'),
                                  ),
                                  AutoSizeText(
                                    "Youtube Channel",
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: 'gotham'),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(
                      top: 0,
                      left: 5,
                      right: 5,
                      bottom: 0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      //  borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: FutureBuilder(
                        future: _fetchListItems1("youtube.php"),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            listData2 = snapshot.data;
                            print(listData2[0]["deskripsi"]);
                            return CarouselSlider.builder(
                              itemCount: listData2.length,
                              itemBuilder:
                                  (BuildContext, int index, int jumlah) {
                                return InkWell(
                                    onTap: () {
                                      // _launchURL(1);
                                    },
                                    splashColor: Colors.redAccent,
                                    child: Container(
                                        margin:
                                            EdgeInsets.only(top: 5, bottom: 5),
                                        // clipBehavior: Clip.hardEdge,
                                        // decoration: BoxDecoration(
                                        //                                           borderRadius: BorderRadius.all(Radius.circular(15)),                  ),

                                        // child: Text(listData2[index]["deskripsi"].toString()),
                                        // child: Card(

                                        child: YoutubePlayer(
                                            controller: YoutubePlayerController(
                                              // initialVideoId: '8iQb6CderPA',
                                              initialVideoId: listData2[index]
                                                      ["deskripsi"]
                                                  .toString(),
                                              flags: YoutubePlayerFlags(
                                                autoPlay: false,
                                                mute: false,
                                                isLive: false,
                                                disableDragSeek: true,
                                              ),
                                            ),
                                            showVideoProgressIndicator: true)
                                        // )
                                        ));
                              },
                              options: CarouselOptions(
                                scrollDirection: Axis.horizontal,
                                enlargeCenterPage: false,
                                aspectRatio: 16 / 8,
                                autoPlay: false,
                                autoPlayCurve: Curves.fastOutSlowIn,
                                enableInfiniteScroll:
                                    true, //jika diset true dan tidak ada data gambar maka akan error
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 600),
                                viewportFraction: 1,
                              ),
                            );
                          }
                        })),
                // Container(
                //     margin: EdgeInsets.only(
                // top: 0,
                // left: 5,
                // right: 5,
                // bottom: 0,
                // ),
                // clipBehavior: Clip.hardEdge,
                //                       decoration: BoxDecoration(
                //                          color: Colors.white,
                //                           //  borderRadius: BorderRadius.all(Radius.circular(15)),
                //   ),
                //     // height: 200,
                //     // decoration: BoxDecoration(
                //     // borderRadius: BorderRadius.all(Radius.circular(20))),

                //     child: YoutubePlayer(
                //         controller: _ycontroller,
                //         showVideoProgressIndicator: true)
                //         ),
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                    left: 0,
                    right: 0,
                    bottom: 10,
                  ),
                  width: MediaQuery.of(context).size.width * 1,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  AutoSizeText(
                                    "SERU-SERUAN",
                                    style: TextStyle(
                                        fontSize: 30, fontFamily: 'gotham'),
                                  ),
                                  AutoSizeText(
                                    "BARENG KAMI",
                                    style: TextStyle(
                                        fontSize: 30, fontFamily: 'gotham'),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  AutoSizeText(
                                    "follow us :",
                                    style: TextStyle(
                                        fontSize: 20, fontFamily: 'gotham'),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.search,
                              size: 60,
                            )
                          ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.23),
                              height: 30,
                              child: Image.asset(
                                "assets/images/sosmed/youtube.png",
                              )),
                          TextButton(
                            onPressed: () {
                              _launchURL(4);
                            },
                            child: Text("Bernardi The Factory Shop",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Cabin-Medium',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.23),
                              height: 30,
                              child: Image.asset(
                                "assets/images/sosmed/tiktok.png",
                              )),
                          TextButton(
                            onPressed: () {
                              _launchURL(1);
                            },
                            child: Text("thefactoryshop_",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Cabin-Medium',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.23),
                              height: 30,
                              child: Image.asset(
                                "assets/images/sosmed/instagram.png",
                              )),
                          TextButton(
                            onPressed: () {
                              _launchURL(2);
                            },
                            child: Text("thefactoryshop_",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Cabin-Medium',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.23),
                              height: 30,
                              child: Image.asset(
                                "assets/images/sosmed/facebook.png",
                              )),
                          TextButton(
                            onPressed: () {
                              _launchURL(3);
                            },
                            child: Text("TheFactoryShop.ID",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'Cabin-Medium',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                // Container(
                //    margin: EdgeInsets.only(
                // top: 0,
                // left: 0,
                // right: 0,
                // bottom: 10,
                // ),
                //   // height: MediaQuery.of(context).size.height * 0.38,
                //   width: MediaQuery.of(context).size.width * 1,
                //   color: Colors.white,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Row(
                //           mainAxisAlignment: MainAxisAlignment.center,
                //           children: [
                //             Padding(
                //               padding: const EdgeInsets.only(left: 30),
                //               child: Column(
                //                 children: [
                //                   Text(
                //                     "Hayuuuuuukkk !!",
                //                     style: TextStyle(
                //                         fontSize: 20, fontFamily: 'BaksoSapi'),
                //                   ),

                //                   SizedBox(
                //                     height: 10,
                //                   ),
                //                 ],
                //               ),
                //             ),

                //           ]),

                //     ],
                //   ),
                // ),
                Container(
                    // color : Color.fromARGB(255, 233, 231, 231),
                    margin: EdgeInsets.only(bottom: 10),
                    height: 80,
                    child: Image.asset(
                      "assets/images/bnd.png",
                    )),
                // Container(
                //   height: MediaQuery.of(context).size.height * 0.1,
                //   color: Colors.white,
                //   child: Image.asset(
                //     "assets/images/footer.png",
                //     fit: BoxFit.fill,
                //   ),
                // ),
              ],
            ),
          ),
        ));
  }
}

class navigationdrawer extends StatelessWidget {
  const navigationdrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildheader(context),
              buildmenuitems(context),
            ],
          ),
        ),
      );
  Widget buildheader(BuildContext context) => Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        color: Color.fromARGB(255, 245, 240, 225),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 103, 9, 29)),
              ),
              Text(
                "Factory Shoppers",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 103, 9, 29)),
              )
            ],
          ),
        ),
      );

  Widget buildmenuitems(BuildContext context) => Container(
        padding: const EdgeInsets.all(10),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: Icon(Icons.store_sharp),
              title: const Text(
                "Promo Nasional",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const promo_nasional_()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.local_grocery_store_sharp),
              title: const Text(
                "Promo Instore",
                style: TextStyle(fontSize: 16),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const promo_instore_()),
                );
              },
            ),
            Divider(
              height: 1,
              color: Colors.black54,
            )
          ],
        ),
      );
}

_launchURL(tujuan) async {
  if (tujuan == 1) {
    const url = 'https://www.tiktok.com/@thefactoryshop_';
    await launch(url);
  } else if (tujuan == 2) {
    const url = 'https://www.instagram.com/thefactoryshop_/';
    await launch(url);
  } else if (tujuan == 3) {
    const url = 'https://www.facebook.com/thefactoryshop.id';
    await launch(url);
  } else if (tujuan == 4) {
    const url = 'https://youtube.com/channel/UCCcNdYiGOCXR4cp6DLUBMuA';
    await launch(url);
  }
}
// final Uri _url = Uri.parse('https://www.thefactoryshop.co.id/');
// void _launchUrl() async {
//   if (!await launchUrl(_url)) throw 'Could not launch $_url';
//
//https://www.instagram.com/thefactoryshop_/
