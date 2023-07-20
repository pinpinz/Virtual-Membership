import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

var titleList = [
  "Sidoarjo",
  "Surabaya",
  "Surabaya",
  "Jakarta",
  "Bali",
  "Malang x",
  "Pasuruan",
];

var descList = [
  "Komplek Industri & Pergudangan Sinar Buduran Blok B1-B6 Jl. Raya, Jalan Lingkar Timur, Gesing, Banjarsari, Kec. Sidoarjo, Kabupaten Sidoarjo, Jawa Timur 61252",
  "Jalan Dokter Ir. Haji Soekarno No.409-411, Kedung Baruk, Rungkut, Penjaringan Sari, Kec. Rungkut, Kota SBY, Jawa Timur 60298",
  "Jl. Mayjen HR. Muhammad, Pradahkalikendal, Kec. Dukuhpakis, Kota SBY, Jawa Timur 60226",
  "Ruko The Icon Business PArk Blok K No.15, Sampora, Cisauk, Tangerang",
  "Jl. Imam Bonjol No.515 A, Pemecutan Klod, Kec. Denpasar Bar., Kota Denpasar, Bali 80119",
  "Jl. Brigjen Slamet Riadi No.108, Oro-oro Dowo, Kec Klojen, Malang",
  "Jl. Raya Surabaya-Malang, Karangploso, Ngerong, Kec Gempol, Pasuruan",
];

var direction;

var telp = [
  "Telp : (031) 8921995",
  "Telp : (031) 99044633",
  "Telp : (031) 99147338",
  "Telp : -",
  "Telp : (0361) 8452770",
  "Telp : (0341) 358080",
  "Telp : (0343) 636766",
];

var btn, open;

class store_page_ extends StatefulWidget {
  const store_page_({Key? key}) : super(key: key);

  @override
  _store_page_State createState() => _store_page_State();
}

class _store_page_State extends State<store_page_> {
  void iniState() {
    super.initState();
  }

  getlogo() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.07,
        child: Image.asset(
          "assets/images/logoheader.png",
          fit: BoxFit.cover,
        ));
  }

  int indexCarousel = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: getlogo(),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 103, 9, 29),
        elevation: 3,
      ),
      body: Container(
        decoration: BoxDecoration(
          // color :Color.fromARGB(255, 247, 240, 240),
          image: DecorationImage(
              image: AssetImage('assets/images/back_motif.jpeg'),
              fit: BoxFit.fitWidth),
        ),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                child: Text(
                  "STORE",
                  style: TextStyle(fontSize: 25, fontFamily: 'Gotham'),
                ),
              ),

              Container(

                  // width: MediaQuery.of(context).size.width * 0.70,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 4),
                      aspectRatio: 6 / 9,
                      // height: MediaQuery.of(context).size.height * 0.6,
                      onPageChanged: (index, reason) {
                        setState(() {
                          indexCarousel = index;
                        });
                      },
                    ),
                    items: [0, 1, 2, 3, 4, 5, 6].map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return InkWell(
                            onTap: () {
                              showDialogFunc(context, titleList[i], descList[i],
                                  btn, telp[i], i);
                            },
                            // child: Container(
                            //   // width: MediaQuery.of(context).size.width* 0.5,
                            //   margin: EdgeInsets.symmetric(horizontal: 5.0),
                            //   decoration: BoxDecoration(
                            //       color: Color.fromARGB(255, 255, 255, 255),
                            //       image: DecorationImage(
                            //           image: AssetImage(
                            //             "assets/images/store/toko" +
                            //                 i.toString() +
                            //                 ".png",
                            //           ),
                            //           fit: BoxFit.cover)),
                            // ),

                            child: Card(
                              clipBehavior: Clip.hardEdge,
                              elevation: 3,
                              // shadowColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Image.asset(
                                  "assets/images/store/toko" +
                                      i.toString() +
                                      ".png",
                                  fit: BoxFit.fitWidth),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  )),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lokasi(indexCarousel),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "AYO TERUS BERBELANJA NIKMATI PROMONYA DAN DAPATKAN CASHBACK POINYA. MAKIN BANYAK POIN MAKIN UNTUK BERBELANJA",
                      style:
                          TextStyle(fontSize: 12, fontFamily: 'Cabin-Medium'),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.08,
              //   width: MediaQuery.of(context).size.width,
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: AssetImage('assets/images/footer.png'),
              //         fit: BoxFit.fill),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}

showDialogFunc(context, title, desc, btn, telp, direction) {
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.6,
              child: Column(
                children: <Widget>[
                  AutoSizeText(
                    "Klik Map (Direction to GMAP)",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        // top: MediaQuery.of(context).size.height * 0.2,
                        // left: MediaQuery.of(context).size.width * (65 / 100)
                        ),
                    child: IconButton(
                      onPressed: () {
                        _launchURL(direction);
                      },
                      icon: Image.asset(
                        'assets/images/icon/map.png',
                      ),
                      iconSize: (MediaQuery.of(context).size.height * 0.2),
                    ),
                  ),
                  AutoSizeText(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AutoSizeText(
                    desc,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AutoSizeText("Jam : 08.00 - 20.00",
                      maxLines: 1,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black)),
                  const SizedBox(
                    height: 5,
                  ),
                  AutoSizeText(telp,
                      textAlign: TextAlign.left,
                      maxLines: 1,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.black)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: MaterialButton(
                          onPressed: () {
                            _launchWA(direction, context);
                          },
                          child: const Text('        Chat (WhatsApp)         ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16)),
                          color: Color.fromARGB(255, 103, 9, 29),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          padding: const EdgeInsets.all(5),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      });
}

_launchURL(int arr) async {
  if (arr == 0) {
    const url = 'https://goo.gl/maps/WjNz9D7VHJU238APA';
    await launch(url);
  } else if (arr == 1) {
    const url = 'https://goo.gl/maps/6oCbR2Yrq12w6dRJ8';
    await launch(url);
  } else if (arr == 2) {
    const url = 'https://goo.gl/maps/mTQEypDAMAe7vnhM6';
    await launch(url);
  } else if (arr == 3) {
    const url = 'https://goo.gl/maps/bL2GchJJMFLr7GKP6';
    await launch(url);
  } else if (arr == 4) {
    const url = 'https://goo.gl/maps/Was2cV6pfWrWP8Rp7';
    await launch(url);
  } else if (arr == 5) {
    const url = 'https://goo.gl/maps/2G4a1TMfCXKmnPYq8';
    await launch(url);
  } else if (arr == 6) {
    const url = 'https://goo.gl/maps/1AwsDaxrowhFgHph8';
    await launch(url);
  }
}

// "Factory Shop Sidoarjo",

// "Factory Shop Surabaya MER",

// "Factory Shop Surabaya HR",

// "Factory Shop Bsd-Serpong",

// "Factory Shop Bali",

// "Factory Shop Malang",

// "Factory Shop Pasuruan",

_launchWA(int arr, context) async {
  if (arr == 0) {
    const url =
        "whatsapp://send?phone=+6285334841864&text=Bagi info Promo dong Kakak?";
    await launch(url);
  } else if (arr == 1) {
    const url =
        "whatsapp://send?phone=+628113346898&text=Bagi info Promo dong Kakak?";
    await launch(url);
  } else if (arr == 2) {
    const url =
        "whatsapp://send?phone=+6282337063506&text=Bagi info Promo dong Kakak?";
    await launch(url);
  } else if (arr == 3) {
    const url =
        "whatsapp://send?phone=+628111203900&text=Bagi info Promo dong Kakak?";
    await launch(url);
  } else if (arr == 4) {
    const url =
        "whatsapp://send?phone=+628113880680&text=Bagi info Promo dong Kakak?";
    await launch(url);
  } else if (arr == 5) {
    const url =
        "whatsapp://send?phone=+628113650501&text=Bagi info Promo dong Kakak?";
    await launch(url);
  } else if (arr == 6) {
    const url =
        "whatsapp://send?phone=+6281217247671&text=Bagi info Promo dong Kakak?";
    await launch(url);
  }
}

void openWhatsapp(
    {required BuildContext context,
    required String text,
    required String number}) async {
  var whatsapp = number; //+92xx enter like this
  var whatsappURlAndroid = "whatsapp://send?phone=" + whatsapp + "&text=$text";
  var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
  if (Platform.isIOS) {
    // for iOS phone only
    if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
      await launchUrl(Uri.parse(
        whatsappURLIos,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Whatsapp not installed")));
    }
  } else {
    // android , web
    if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
      await launchUrl(Uri.parse(whatsappURlAndroid));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Whatsapp not installed")));
    }
  }
}

Lokasi(lokasi) {
  if (lokasi == 0) {
    return Text(
      "Factory Shop Sidoarjo",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin-Medium',
          fontSize: 20),
    );
  } else if (lokasi == 1) {
    return Text(
      "Factory Shop Surabaya MER",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin-Medium',
          fontSize: 20),
    );
  } else if (lokasi == 2) {
    return Text(
      "Factory Shop Surabaya HR",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin-Medium',
          fontSize: 20),
    );
  } else if (lokasi == 3) {
    return Text(
      "Factory Shop Bsd-Serpong",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin-Medium',
          fontSize: 20),
    );
  } else if (lokasi == 4) {
    return Text(
      "Factory Shop Bali",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin-Medium',
          fontSize: 20),
    );
  } else if (lokasi == 5) {
    return Text(
      "Factory Shop Malang",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin-Medium',
          fontSize: 20),
    );
  } else if (lokasi == 6) {
    return Text(
      "Factory Shop Pasuruan",
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Cabin-Medium',
          fontSize: 20),
    );
  }
}
