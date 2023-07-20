import 'dart:convert';
import 'dart:typed_data';
import 'package:audioplayers/audioplayers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:member_ebs/menu_bar_page.dart';
import 'package:member_ebs/menu_utama/page_home/update_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:member_ebs/main.dart';
import 'package:member_ebs/menu_utama/page_home/home_page.dart';
import 'package:simple_animations/simple_animations.dart';

class login_page_ extends StatefulWidget {
  const login_page_({Key? key}) : super(key: key);
  @override
  _login_page_State createState() => _login_page_State();
}

class _login_page_State extends State<login_page_> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late bool obscureText;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    super.initState();
    obscureText = true;
  }

  Future bunyi() async {
    AudioPlayer player = AudioPlayer();
    String audioasset = "assets/audio/yes.wav";
    ByteData bytes = await rootBundle.load(audioasset); //load sound from assets
    Uint8List soundbytes =
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
    int result = await player.playBytes(soundbytes);
    if (result == 1) {
      //play success
      print("Sound playing successful.");
    } else {
      print("Error while playing sound.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: Container(
          decoration: BoxDecoration(
              // color :Color.fromARGB(255, 247, 240, 240),
              // image: DecorationImage(
              //     image: AssetImage('assets/images/backgroundasd.jpeg'),
              //     fit: BoxFit.fitWidth),

              ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  //  width: MediaQuery.of(context).size.width * 1,
                  height: MediaQuery.of(context).size.width -
                      (MediaQuery.of(context).size.height * 0.05),

                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/login/header.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  alignment: AlignmentDirectional.bottomStart,
                  padding:
                      EdgeInsets.only(top: 30, left: 5, right: 5, bottom: 10),
                  child: Text(
                    "HI FACTORY SHOPPERS,",
                    style: TextStyle(fontSize: 20, fontFamily: 'gotham'),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  alignment: AlignmentDirectional.bottomStart,
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Text("Sign in to continue",
                      style: TextStyle(fontSize: 14, fontFamily: 'gotham')),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.87,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(children: <Widget>[
                      Container(
                        child: Material(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            elevation: 2,
                            child: Center(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.people_sharp,
                                      color: Color.fromARGB(255, 104, 56, 56)),
                                  fillColor: Color.fromARGB(255, 245, 240, 225),
                                  filled: true,
                                  // hintText: 'insert Username here',
                                  label: Text("Username"),
                                  labelStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 141, 140, 140)),

                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(2),
                                ),
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                              ),
                            )),
                      ),
                    ])),
                SizedBox(
                  height: 15,
                ),
                Container(
                    width: MediaQuery.of(context).size.width * 0.87,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Material(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5)),
                        elevation: 2,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Center(
                                  child: TextFormField(
                                textAlign: TextAlign.start,
                                decoration: const InputDecoration(
                                  // hintText: 'Password',
                                  label: Text("password"),
                                  labelStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 141, 140, 140)),
                                  prefixIcon: Icon(Icons.lock_open_rounded,
                                      color: Color.fromARGB(255, 104, 56, 56)),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.all(2),
                                  fillColor: Color.fromARGB(255, 245, 240, 225),
                                  filled: true,
                                ),
                                keyboardType: TextInputType.text,
                                controller: passwordController,
                                obscureText: obscureText,
                              )),
                            ),
                            Container(
                              color: Color.fromARGB(255, 245, 240, 225),
                              child: IconButton(
                                icon: Icon(
                                  Icons.remove_red_eye,
                                  color: !obscureText
                                      ? Colors.black.withOpacity(0.3)
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  setState(() {
                                    obscureText = !obscureText;
                                  });
                                },
                              ),
                            )
                          ],
                        ))),
                Container(
                    width: MediaQuery.of(context).size.width * 0.87,
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                        onPressed: () {
                          showDialogFunc(context);
                        },
                        child: Text("Forgot Password! ",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 163, 50, 50),
                            )))),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: MaterialButton(
                      onPressed: () {
                        loginValidation(context);
                      },
                      child: const Text("Sign In",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18)),
                      color: Color.fromARGB(255, 103, 9, 29),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      padding: const EdgeInsets.all(10),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => menu_bar_page_()),
                          (Route<dynamic> route) => false);
                    },
                    child: Text("Login sebagai Guest",
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 163, 50, 50)))),
                // Expanded(
                //   child: Container(),
                // ),
                Container(
                    margin: EdgeInsets.only(bottom: 10),
                    alignment: AlignmentDirectional.center,
                    child: TextButton(
                        onPressed: () async {
                          // final _loadedData = await rootBundle.loadString('assets/data.txt');

                          showTermAndContion(context);
                        },
                        child: Text(" - Term and conditions -",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 51, 50, 50))))),
              ],
            ),
          ),
        ));
  }

  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  void loginValidation(BuildContext context) async {
    bool isLoginValid = true;
    FocusScope.of(context).requestFocus(FocusNode());

    if (emailController.text.isEmpty) {
      isLoginValid = false;
      _onWidgetDidBuild(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Username Tidak Boleh Kosong'),
            backgroundColor: Colors.red,
          ),
        );
        passwordController.clear();
        emailController.clear();
      });
    }

    if (passwordController.text.isEmpty) {
      isLoginValid = false;
      _onWidgetDidBuild(() {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password Tidak Boleh Kosong'),
            backgroundColor: Colors.red,
          ),
        );
        passwordController.clear();
        emailController.clear();
      });
    }
    if (isLoginValid) {
      fetchLogin(context, emailController.text, passwordController.text);
      passwordController.clear();
      emailController.clear();
    }
  }

  fetchLogin(BuildContext context, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    showLoaderDialog(context);
    try {
      Response response;
      var dio = Dio();

      FormData formData = new FormData.fromMap({
        "username": email,
        "password": password,
      });

      response = await dio.post(
        ip + "checklogin.php", //endpoint api Login
        data: formData,
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode == 200) {
        //berhasil
        hideLoaderDialog(dialogContext);
        print("dismiss dialog");
        //setSharedPreference
        //String prefEmail = email;
        //String prefToken = response.data['token'];
        //await prefs.setString('email', prefEmail);
        //await prefs.setString('token', prefToken);
        //Messsage

        var hasil = jsonDecode(response.data);
        if (hasil["found"] == "ok") {
          //print("user " + hasil["user"].toString());
          dynamic user = jsonEncode(hasil["user"]);

          if (hasil["user"]["isValid"].toString() == "0") {
            await prefs.setString('user', jsonEncode(hasil["user"]));
            _onWidgetDidBuild(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login Berhasil'),
                  backgroundColor: Colors.green,
                ),
              );
            });
            // bunyi();
            //homePage
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const update_password_()));
          } else {
            await prefs.setString('user', jsonEncode(hasil["user"]));
            print("hasil dari invalid :");
            print(hasil["user"]["isValid"].toString());
            _onWidgetDidBuild(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login Berhasil'),
                  backgroundColor: Colors.green,
                ),
              );
            });
            // bunyi();
            //homePage
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => menu_bar_page_()),
                (Route<dynamic> route) => false);
          }
        } else {
          _onWidgetDidBuild(() {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login Gagal'),
                backgroundColor: Colors.red,
              ),
            );
          });
        }
      }
    } on DioError catch (e) {
      hideLoaderDialog(context);

      if (e.response?.statusCode == 400) {
        //gagal
        String errorMessage = e.response?.data['error'];
        _onWidgetDidBuild(() {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMessage),
              backgroundColor: Colors.red,
            ),
          );
        });
      } else {
        // print(e.message);
      }
    }
  }

  BuildContext? dialogContext;
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Sign in...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        dialogContext = context;
        return alert;
      },
    );
  }

  hideLoaderDialog(BuildContext? context) {
    if (context != null) {
      return Navigator.pop(context);
    }
  }
}

showDialogFunc(context) {
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
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Icon(Icons.location_history),
                    Text(
                      "MOHON MAAF",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Untuk saat ini",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Layanan hanya bisa dilakukan OFFLINE",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Kunjungi",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.normal),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "The Factory Shop \n Terdekat",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    )
                  ]),
            ),
          ),
        );
      });
}

showTermAndContion(context) {
  double x1 = 0;
  double x2 = 15;
  double x3 = 35;
  return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 58, 18, 18),
              ),
              clipBehavior: Clip.hardEdge,
              // padding: const EdgeInsets.all(5),
              // width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.width +
                  (MediaQuery.of(context).size.width * 0.7),

              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Icon(Icons.location_history),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.87,
                        alignment: AlignmentDirectional.center,
                        child: AutoSizeText(" KETENTUAN MEMBERSHIP ",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 248, 247, 247),
                            ))),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.87,
                        alignment: AlignmentDirectional.center,
                        child: AutoSizeText(" UNTUK CUSTOMER ",
                            style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 248, 247, 247),
                            ))),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width * 0.95,
                          decoration: BoxDecoration(
                            //   image: DecorationImage(
                            //       image: AssetImage('assets/images/TnC.jpg'),
                            //       fit: BoxFit.fitWidth),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '1. Pendahuluan',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: 'Selamat datang di ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                      TextSpan(
                                          text: 'PT Elmitra Benison Sejahtera ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              'Sejahtera (yang selanjutnya disebut sebagai “Perusahaan”, ”kami”, ”milik kami”, “kami”)',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Ketentuan Layanan ini ("Ketentuan", "Ketentuan Layanan") mengatur penggunaan Anda atas aplikasi kami yang terletak di ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                      TextSpan(
                                          text: 'factoryshoppers',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              ' (bersama-sama atau secara individual "Layanan") yang dioperasikan oleh ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                      TextSpan(
                                          text: 'PT Elmitra Benison Sejahtera.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Kebijakan Privasi kami juga mengatur penggunaan Anda atas Layanan kami dan menjelaskan bagaimana kami mengumpulkan, menjaga, dan mengungkapkan informasi yang dihasilkan dari penggunaan Anda atas halaman web kami.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Perjanjian Anda dengan kami mencakup Ketentuan ini dan Kebijakan Privasi kami ("Perjanjian"). Anda mengakui bahwa Anda telah membaca dan memahami Perjanjian, dan setuju untuk mengikatnya.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Jika Anda tidak setuju dengan (atau tidak dapat mematuhi) Perjanjian, maka Anda tidak boleh menggunakan Layanan, tetapi beri tahu kami dengan mengirim email ke ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                      TextSpan(
                                          text: 'customer.support@bernardi.id ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text:
                                              'sehingga kami dapat mencoba mencari solusi. Ketentuan ini berlaku untuk semua pengunjung, pengguna, dan orang lain yang ingin mengakses atau menggunakan Layanan.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '2. Komunikasi',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Dengan menggunakan Layanan kami, Anda setuju untuk berlangganan buletin, materi pemasaran atau promosi dan informasi lain yang mungkin kami kirimkan. Namun, Anda dapat memilih untuk tidak menerima salah satu, atau semua, komunikasi ini dari kami dengan mengikuti tautan berhenti berlangganan atau dengan mengirim email ke ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                      TextSpan(
                                          text: 'customer.support@bernardi.id.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '3. Kontes, Undian, dan Promosi',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Setiap kontes, undian, atau promosi lainnya (secara kolektif, "Promosi") yang disediakan melalui Layanan dapat diatur oleh aturan yang terpisah dari Ketentuan Layanan ini. Jika Anda berpartisipasi dalam Promosi apa pun, harap tinjau aturan yang berlaku serta Kebijakan Privasi kami. Jika aturan untuk Promosi bertentangan dengan Ketentuan Layanan ini, aturan Promosi akan berlaku.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '4. Konten',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Layanan kami memungkinkan Anda untuk memposting, menautkan, menyimpan, membagikan, dan menyediakan informasi, teks, grafik, video, atau materi tertentu lainnya ("Konten"). Anda bertanggung jawab atas Konten yang Anda posting di atau melalui Layanan, termasuk legalitas, keandalan, dan kesesuaiannya.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Dengan memposting Konten pada atau melalui Layanan, Anda menyatakan dan menjamin bahwa: (i) Konten adalah milik Anda (Anda memilikinya) dan/atau Anda memiliki hak untuk menggunakannya dan hak untuk memberi kami hak dan lisensi sebagaimana diatur dalam Ketentuan ini, dan (ii) bahwa posting Konten Anda pada atau melalui Layanan tidak melanggar hak privasi,  hak publisitas, hak cipta, hak kontrak, atau hak lain dari orang atau entitas mana pun. Kami berhak untuk menghentikan akun siapa pun yang ditemukan melanggar hak cipta.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Anda mempertahankan setiap dan semua hak Anda atas Konten apa pun yang Anda kirimkan, posting, atau tampilkan pada atau melalui Layanan dan Anda bertanggung jawab untuk melindungi hak-hak tersebut. Kami tidak bertanggung jawab dan tidak bertanggung jawab atas Konten yang Anda atau posting pihak ketiga mana pun di atau melalui Layanan. Namun, dengan memposting Konten menggunakan Layanan, Anda memberi kami hak dan lisensi untuk menggunakan, memodifikasi, mempertunjukkan secara publik, menampilkan secara publik, mereproduksi, dan mendistribusikan Konten tersebut di dan melalui Layanan. Anda setuju bahwa lisensi ini mencakup hak bagi kami untuk membuat Konten Anda tersedia bagi pengguna Layanan lainnya, yang juga dapat menggunakan Konten Anda dengan tunduk pada Ketentuan ini.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'PT Elmitra Benison Sejahtera berhak namun tidak berkewajiban untuk memantau dan mengedit seluruh Konten yang disediakan oleh pengguna.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Selain itu, Konten yang terdapat pada atau melalui Layanan ini adalah milik PT Elmitra Benison Sejahtera atau digunakan dengan izin. Anda tidak boleh mendistribusikan, memodifikasi, mengirimkan, menggunakan kembali, mengunduh, memposting ulang, menyalin, atau menggunakan Konten tersebut, baik secara keseluruhan atau sebagian, untuk tujuan komersial atau untuk keuntungan pribadi, tanpa izin tertulis sebelumnya dari kami.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '5. Penggunaan yang Dilarang',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Anda dapat menggunakan Layanan hanya untuk tujuan yang sah dan sesuai dengan Ketentuan. Anda setuju untuk tidak menggunakan Layanan:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '1. Dengan cara apa pun yang melanggar hukum atau peraturan nasional atau internasional yang berlaku.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '2. Untuk tujuan mengeksploitasi, merugikan, atau mencoba mengeksploitasi atau membahayakan anak di bawah umur dengan cara apa pun dengan mengekspos mereka ke konten yang tidak pantas atau sebaliknya.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '3. Untuk mengirimkan, atau mendapatkan pengiriman, materi iklan atau promosi apa pun, termasuk "surat sampah", "surat berantai", "spam", atau ajakan serupa lainnya.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '4. Untuk menyamar atau mencoba menyamar sebagai Perusahaan, karyawan Perusahaan, pengguna lain, atau orang atau entitas lain.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '5. Dengan cara apa pun yang melanggar hak orang lain, atau dengan cara apa pun ilegal, mengancam, curang, atau berbahaya, atau sehubungan dengan tujuan atau aktivitas yang melanggar hukum, ilegal, curang, atau berbahaya.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '6. Untuk terlibat dalam perilaku lain yang membatasi atau menghambat penggunaan atau kenikmatan Layanan oleh siapa pun, atau yang, sebagaimana ditentukan oleh kami, dapat membahayakan atau menyinggung Perusahaan atau pengguna Layanan atau membuat mereka bertanggung jawab.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Selain itu, Anda setuju untuk tidak:',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '1. Menggunakan Layanan dengan cara apa pun yang dapat melumpuhkan, membebani, merusak, atau mengganggu Layanan atau mengganggu penggunaan Layanan oleh pihak lain, termasuk kemampuan mereka untuk terlibat dalam aktivitas waktu nyata melalui Layanan.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '2. Menggunakan robot, spider, atau perangkat, proses, atau sarana otomatis lainnya untuk mengakses Layanan untuk tujuan apa pun, termasuk memantau atau menyalin materi apa pun di Layanan.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '3. Menggunakan proses manual apa pun untuk memantau atau menyalin materi apa pun di Layanan atau untuk tujuan tidak sah lainnya tanpa persetujuan tertulis sebelumnya dari kami.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '4. Menggunakan perangkat, perangkat lunak, atau rutinitas apa pun yang mengganggu kerja Layanan yang semestinya.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '5. Perkenalkan virus, trojan horse, worm, bom logika, atau materi lain yang berbahaya atau berbahaya secara teknologi.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              ' 6. Mencoba untuk mendapatkan akses tidak sah ke, mengganggu, merusak, atau mengganggu bagian mana pun dari Layanan, server tempat Layanan disimpan, atau server, komputer, atau database apa pun yang terhubung ke Layanan.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              ' 7. Layanan Serangan melalui serangan penolakan layanan atau serangan penolakan layanan terdistribusi.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              ' 8. Mengambil tindakan apa pun yang dapat merusak atau memalsukan peringkat Perusahaan.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              ' 9. Jika tidak, upaya untuk mengganggu kerja Layanan yang benar.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '6. Analisis',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Kami dapat menggunakan Penyedia Layanan pihak ketiga untuk memantau dan menganalisis penggunaan Layanan kami.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '7. Tidak Ada Gunanya Oleh Anak di Bawah Umur',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Layanan hanya ditujukan untuk akses dan penggunaan oleh individu yang berusia minimal delapan belas (18) tahun. Dengan mengakses atau menggunakan Layanan, Anda menjamin dan menyatakan bahwa Anda setidaknya berusia delapan belas (18) tahun dan dengan otoritas, hak, dan kapasitas penuh untuk masuk ke dalam perjanjian ini dan mematuhi semua syarat dan ketentuan Ketentuan. Jika Anda belum berusia minimal delapan belas (18) tahun, Anda dilarang mengakses dan menggunakan Layanan.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '8. Akun',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Saat Anda membuat akun dengan kami, Anda menjamin bahwa Anda berusia di atas 18 tahun, dan bahwa informasi yang Anda berikan kepada kami akurat, lengkap, dan terkini setiap saat. Informasi yang tidak akurat, tidak lengkap, atau usang dapat mengakibatkan penghentian segera akun Anda di Layanan.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Anda bertanggung jawab untuk menjaga kerahasiaan akun dan kata sandi Anda, termasuk namun tidak terbatas pada pembatasan akses ke komputer dan/atau akun Anda. Anda setuju untuk menerima tanggung jawab atas setiap dan semua aktivitas atau tindakan yang terjadi di bawah akun dan / atau kata sandi Anda, baik kata sandi Anda dengan Layanan kami atau layanan pihak ketiga. Anda harus segera memberi tahu kami setelah mengetahui adanya pelanggaran keamanan atau penggunaan akun Anda yang tidak sah.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Anda tidak boleh menggunakan nama pengguna sebagai nama orang atau entitas lain atau yang tidak tersedia secara sah untuk digunakan, nama atau merek dagang yang tunduk pada hak orang atau entitas lain selain Anda, tanpa otorisasi yang sesuai. Anda tidak boleh menggunakan nama pengguna sebagai nama pengguna apa pun yang menyinggung, vulgar, atau cabul.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Kami berhak untuk menolak layanan, menghentikan akun, menghapus atau mengedit konten, atau membatalkan pesanan atas kebijakan kami sendiri.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '9. Kekayaan Intelektual',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Layanan dan konten aslinya (tidak termasuk Konten yang disediakan oleh pengguna), fitur dan fungsi adalah dan akan tetap menjadi milik eksklusif PT Elmitra Benison Sejahtera dan pemberi lisensinya. Layanan dilindungi oleh hak cipta, merek dagang, dan undang-undang lain dari dan negara asing. Merek dagang kami tidak boleh digunakan sehubungan dengan produk atau layanan apa pun tanpa persetujuan tertulis sebelumnya dari PT Elmitra Benison Sejahtera.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '10. Kebijakan Hak Cipta',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Kami menghormati hak kekayaan intelektual orang lain. Merupakan kebijakan kami untuk menanggapi klaim apa pun bahwa Konten yang diposting di Layanan melanggar hak cipta atau hak kekayaan intelektual lainnya ("Pelanggaran") dari orang atau entitas mana pun.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Jika Anda adalah pemilik hak cipta, atau berwenang atas nama salah satu, dan Anda yakin bahwa karya berhak cipta telah disalin dengan cara yang merupakan pelanggaran hak cipta, silakan kirimkan klaim Anda melalui email ke customer.support@bernardi.id, dengan baris subjek: "Pelanggaran Hak Cipta" dan sertakan dalam klaim Anda deskripsi terperinci tentang dugaan Pelanggaran seperti yang dijelaskan di bawah ini,  di bawah "Pemberitahuan DMCA dan Prosedur untuk Klaim Pelanggaran Hak Cipta"',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Anda dapat dimintai pertanggungjawaban atas kerusakan (termasuk biaya dan biaya pengacara) atas pernyataan yang salah atau klaim dengan itikad buruk atas pelanggaran Konten apa pun yang ditemukan pada dan/atau melalui Layanan atas hak cipta Anda.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '11. Pemberitahuan DMCA dan Prosedur untuk Klaim Pelanggaran Hak Cipta',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Anda dapat mengirimkan pemberitahuan sesuai dengan Digital Millennium Copyright Act (DMCA) dengan memberikan informasi berikut kepada Agen Hak Cipta kami secara tertulis (lihat 17 U.S.C 512(c)(3) untuk detail lebih lanjut):',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '1. tanda tangan elektronik atau fisik dari orang yang berwenang untuk bertindak atas nama pemilik kepentingan hak cipta;',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '2. deskripsi karya berhak cipta yang Anda klaim telah dilanggar, termasuk URL (yaitu, alamat halaman web) dari lokasi di mana karya berhak cipta itu ada atau salinan karya berhak cipta;',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '3. identifikasi URL atau lokasi spesifik lainnya pada Layanan di mana materi yang Anda klaim melanggar berada;',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '4. alamat, nomor telepon, dan alamat email Anda;',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '5. pernyataan oleh Anda bahwa Anda memiliki keyakinan dengan itikad baik bahwa penggunaan yang disengketakan tidak diizinkan oleh pemilik hak cipta, agennya, atau hukum;',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x3),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '6. Pernyataan oleh Anda, yang dibuat di bawah sumpah, bahwa informasi di atas dalam pemberitahuan Anda akurat dan bahwa Anda adalah pemilik hak cipta atau berwenang untuk bertindak atas nama pemilik hak cipta.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Anda dapat menghubungi Agen Hak Cipta kami melalui email di customer.support@bernardi.id.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '12. Pelaporan Kesalahan dan Umpan Balik',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Anda dapat memberi kami baik secara langsung di customer.support@bernardi.id atau melalui situs dan alat pihak ketiga dengan informasi dan umpan balik mengenai kesalahan, saran untuk perbaikan, ide, masalah, keluhan, dan hal-hal lain yang terkait dengan Layanan kami ("Umpan Balik"). Anda mengakui dan menyetujui bahwa: (i) Anda tidak akan mempertahankan, memperoleh, atau menegaskan hak kekayaan intelektual atau hak, kepemilikan, atau kepentingan lain apa pun dalam atau terhadap Umpan Balik; (ii) Perusahaan mungkin memiliki ide pengembangan yang serupa dengan Umpan Balik; (iii) Umpan Balik tidak mengandung informasi rahasia atau informasi kepemilikan dari Anda atau pihak ketiga mana pun; dan (iv) Perusahaan tidak berkewajiban atas kerahasiaan sehubungan dengan Umpan Balik. Jika pengalihan kepemilikan atas Umpan Balik tidak dimungkinkan karena undang-undang wajib yang berlaku, Anda memberi Perusahaan dan afiliasinya hak eksklusif, dapat dipindahtangankan, tidak dapat dibatalkan, gratis, dapat disublisensikan, tidak terbatas, dan abadi untuk menggunakan (termasuk menyalin, memodifikasi, membuat karya turunan, menerbitkan, mendistribusikan, dan mengkomersialkan) Umpan Balik dengan cara apa pun dan untuk tujuan apa pun.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '13. Tautan Ke Situs Web Lain',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Layanan kami dapat berisi tautan ke situs web atau layanan pihak ketiga yang tidak dimiliki atau dikendalikan oleh PT Elmitra Benison Sejahtera.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'PT Elmitra Benison Sejahtera tidak memiliki kendali atas, dan tidak bertanggung jawab atas konten, kebijakan privasi, atau praktik situs web atau layanan pihak ketiga mana pun. Kami tidak menjamin penawaran dari entitas/individu ini atau situs web mereka.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'ANDA MENGAKUI DAN MENYETUJUI BAHWA PERUSAHAAN TIDAK AKAN BERTANGGUNG JAWAB ATAU BERKEWAJIBAN, SECARA LANGSUNG ATAU TIDAK LANGSUNG, ATAS KERUSAKAN ATAU KERUGIAN YANG DISEBABKAN ATAU DIDUGA DISEBABKAN OLEH ATAU SEHUBUNGAN DENGAN PENGGUNAAN ATAU KETERGANTUNGAN PADA KONTEN, BARANG, ATAU LAYANAN YANG TERSEDIA DI ATAU MELALUI SITUS WEB ATAU LAYANAN PIHAK KETIGA TERSEBUT.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'KAMI SANGAT MENYARANKAN ANDA UNTUK MEMBACA KETENTUAN LAYANAN DAN KEBIJAKAN PRIVASI DARI SITUS WEB ATAU LAYANAN PIHAK KETIGA YANG ANDA KUNJUNGI.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '14. Penolakan Garansi',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'LAYANAN INI DISEDIAKAN OLEH PERUSAHAAN ATAS DASAR "SEBAGAIMANA ADANYA" DAN "SEBAGAIMANA TERSEDIA". PERUSAHAAN TIDAK MEMBUAT PERNYATAAN ATAU JAMINAN DALAM BENTUK APA PUN, TERSURAT MAUPUN TERSIRAT, MENGENAI PENGOPERASIAN LAYANAN MEREKA, ATAU INFORMASI, KONTEN, ATAU MATERI YANG TERMASUK DI DALAMNYA. ANDA SECARA TEGAS SETUJU BAHWA PENGGUNAAN ANDA ATAS LAYANAN INI, KONTENNYA, DAN LAYANAN ATAU ITEM APA PUN YANG DIPEROLEH DARI KAMI ADALAH RISIKO ANDA SENDIRI.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'BAIK PERUSAHAAN MAUPUN SIAPA PUN YANG TERKAIT DENGAN PERUSAHAAN TIDAK MEMBUAT JAMINAN ATAU REPRESENTASI APA PUN SEHUBUNGAN DENGAN KELENGKAPAN, KEAMANAN, KEANDALAN, KUALITAS, KEAKURATAN, ATAU KETERSEDIAAN LAYANAN. TANPA MEMBATASI HAL TERSEBUT DI ATAS, BAIK PERUSAHAAN MAUPUN SIAPA PUN YANG TERKAIT DENGAN PERUSAHAAN TIDAK MENYATAKAN ATAU MENJAMIN BAHWA LAYANAN, KONTENNYA, ATAU LAYANAN ATAU ITEM APA PUN YANG DIPEROLEH MELALUI LAYANAN AKAN AKURAT, ANDAL, BEBAS KESALAHAN, ATAU TIDAK TERGANGGU, BAHWA CACAT AKAN DIPERBAIKI, BAHWA LAYANAN ATAU SERVER YANG MEMBUATNYA TERSEDIA BEBAS DARI VIRUS ATAU KOMPONEN BERBAHAYA LAINNYA ATAU BAHWA LAYANAN ATAU LAYANAN ATAU ITEM APA PUN YANG DIPEROLEH MELALUI LAYANAN AKAN MEMENUHI ANDA KEBUTUHAN ATAU HARAPAN.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'PERUSAHAAN DENGAN INI MENYANGKAL SEMUA JAMINAN DALAM BENTUK APA PUN, BAIK TERSURAT MAUPUN TERSIRAT, MENURUT UNDANG-UNDANG, ATAU LAINNYA, TERMASUK NAMUN TIDAK TERBATAS PADA JAMINAN APA PUN TENTANG KELAYAKAN UNTUK DIPERDAGANGKAN, NON-PELANGGARAN, DAN KESESUAIAN UNTUK TUJUAN TERTENTU.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'HAL TERSEBUT DI ATAS TIDAK MEMENGARUHI JAMINAN APA PUN YANG TIDAK DAPAT DIKECUALIKAN ATAU DIBATASI BERDASARKAN HUKUM YANG BERLAKU.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '15. Batasan Tanggung Jawab',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'KECUALI SEBAGAIMANA DILARANG OLEH HUKUM, ANDA AKAN MEMBEBASKAN KAMI DAN PEJABAT, DIREKTUR, KARYAWAN, DAN AGEN KAMI ATAS KERUSAKAN TIDAK LANGSUNG, HUKUMAN, KHUSUS, INSIDENTAL, ATAU KONSEKUENSIAL, BAGAIMANAPUN ITU MUNCUL (TERMASUK BIAYA PENGACARA DAN SEMUA BIAYA DAN PENGELUARAN TERKAIT LITIGASI DAN ARBITRASE, ATAU DI PERSIDANGAN ATAU BANDING, JIKA ADA, APAKAH LITIGASI ATAU ARBITRASE DILEMBAGAKAN ATAU TIDAK),  BAIK DALAM TINDAKAN KONTRAK, KELALAIAN, ATAU TINDAKAN MENYIKSA LAINNYA, ATAU YANG TIMBUL DARI ATAU SEHUBUNGAN DENGAN PERJANJIAN INI, TERMASUK NAMUN TIDAK TERBATAS PADA KLAIM APA PUN ATAS CEDERA PRIBADI ATAU KERUSAKAN PROPERTI, YANG TIMBUL DARI PERJANJIAN INI DAN PELANGGARAN APA PUN OLEH ANDA TERHADAP UNDANG-UNDANG, UNDANG-UNDANG, ATURAN, ATAU PERATURAN FEDERAL, NEGARA BAGIAN, ATAU LOKAL, BAHKAN JIKA PERUSAHAAN SEBELUMNYA TELAH DIBERI TAHU TENTANG KEMUNGKINAN KERUSAKAN TERSEBUT. KECUALI DILARANG OLEH HUKUM, JIKA ADA TANGGUNG JAWAB YANG DITEMUKAN DI PIHAK PERUSAHAAN, ITU AKAN TERBATAS PADA JUMLAH YANG DIBAYARKAN UNTUK PRODUK DAN / ATAU LAYANAN, DAN DALAM KEADAAN APA PUN TIDAK AKAN ADA KERUSAKAN KONSEKUENSIAL ATAU HUKUMAN. BEBERAPA NEGARA BAGIAN TIDAK MENGIZINKAN PENGECUALIAN ATAU PEMBATASAN KERUSAKAN HUKUMAN, INSIDENTAL, ATAU KONSEKUENSIAL, SEHINGGA PEMBATASAN ATAU PENGECUALIAN SEBELUMNYA MUNGKIN TIDAK BERLAKU UNTUK ANDA.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '16. Pengakhiran',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Kami dapat menghentikan atau menangguhkan akun Anda dan akses bar ke Layanan segera, tanpa pemberitahuan atau kewajiban sebelumnya, berdasarkan kebijakan kami sendiri, untuk alasan apa pun dan tanpa batasan, termasuk namun tidak terbatas pada pelanggaran Ketentuan.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Jika Anda ingin mengakhiri akun Anda, Anda dapat berhenti menggunakan Layanan.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Semua ketentuan Ketentuan yang menurut sifatnya harus tetap berlaku setelah pengakhiran akan tetap berlaku setelah pengakhiran, termasuk, namun tidak terbatas pada, ketentuan kepemilikan, penafian garansi, ganti rugi, dan batasan tanggung jawab.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '17. Hukum yang Mengatur',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Ketentuan ini akan diatur dan ditafsirkan sesuai dengan hukum Indonesia, yang mengatur hukum berlaku untuk perjanjian tanpa memperhatikan pertentangan ketentuan hukumnya.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Kegagalan kami untuk menegakkan hak atau ketentuan apa pun dari Ketentuan ini tidak akan dianggap sebagai pengabaian hak-hak tersebut. Jika ada ketentuan dari Ketentuan ini yang dianggap tidak sah atau tidak dapat dilaksanakan oleh pengadilan, ketentuan lainnya dari Ketentuan ini akan tetap berlaku. Ketentuan ini merupakan keseluruhan perjanjian antara kami mengenai Layanan kami dan menggantikan dan menggantikan perjanjian sebelumnya yang mungkin kami miliki di antara kami mengenai Layanan.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '18. Perubahan Pada Layanan',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Kami berhak untuk menarik atau mengubah Layanan kami, dan layanan atau materi apa pun yang kami sediakan melalui Layanan, atas kebijakan kami sendiri tanpa pemberitahuan. Kami tidak akan bertanggung jawab jika karena alasan apa pun semua atau sebagian dari Layanan tidak tersedia kapan saja atau untuk periode apa pun. Dari waktu ke waktu, kami dapat membatasi akses ke beberapa bagian Layanan, atau seluruh Layanan, kepada pengguna, termasuk pengguna terdaftar.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '19. Amandemen Persyaratan',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Kami dapat mengubah Ketentuan kapan saja dengan memposting ketentuan yang diubah di situs ini. Anda bertanggung jawab untuk meninjau Ketentuan ini secara berkala.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Penggunaan Anda yang berkelanjutan atas Platform setelah posting Ketentuan yang direvisi berarti Anda menerima dan menyetujui perubahan tersebut. Anda diharapkan untuk sering memeriksa halaman ini sehingga Anda mengetahui adanya perubahan, karena mereka mengikat Anda.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Dengan terus mengakses atau menggunakan Layanan kami setelah revisi berlaku, Anda setuju untuk terikat oleh persyaratan yang direvisi. Jika Anda tidak menyetujui persyaratan baru, Anda tidak lagi berwenang untuk menggunakan Layanan.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              '20. Pengabaian Dan Keterpisahan',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Tidak ada pengabaian oleh Perusahaan atas syarat atau ketentuan apa pun yang ditetapkan dalam Ketentuan yang akan dianggap sebagai pengabaian lebih lanjut atau berkelanjutan dari syarat atau ketentuan tersebut atau pengabaian syarat atau ketentuan lainnya, dan kegagalan Perusahaan untuk menegaskan hak atau ketentuan berdasarkan Ketentuan tidak akan dianggap sebagai pengabaian hak atau ketentuan tersebut.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Jika ada ketentuan Ketentuan yang dipegang oleh pengadilan atau pengadilan lain dari yurisdiksi yang kompeten menjadi tidak sah, ilegal atau tidak dapat dilaksanakan karena alasan apa pun, ketentuan tersebut harus dihilangkan atau dibatasi hingga batas minimum sehingga ketentuan ketentuan lainnya dari Ketentuan akan terus berlaku dan memiliki kekuatan hukum penuh.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '21. Pengakuan',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'DENGAN MENGGUNAKAN LAYANAN ATAU LAYANAN LAIN YANG DISEDIAKAN OLEH KAMI, ANDA MENGAKUI BAHWA ANDA TELAH MEMBACA KETENTUAN LAYANAN INI DAN SETUJU UNTUK TERIKAT OLEHNYA.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x1),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text: '22. Hubungi Kami',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: x2),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Color.fromARGB(255, 27, 27, 27)),
                                    children: const <TextSpan>[
                                      TextSpan(
                                          text:
                                              'Silakan kirim umpan balik Anda, komentar, permintaan untuk dukungan teknis melalui email: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal)),
                                      TextSpan(
                                          text: 'customer.support@bernardi.id.',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width * 0.87,
                        alignment: AlignmentDirectional.center,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: AutoSizeText("- Saya Mengerti dan Patuh -",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 248, 247, 247),
                                )))),
                    //          SizedBox(
                    //   height: 20,
                    // ),
                  ]),
            ),
          ),
        );
      });
}
