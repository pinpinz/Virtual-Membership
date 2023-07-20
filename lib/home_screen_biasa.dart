import 'dart:async';

import 'package:flutter/material.dart';
import 'package:member_ebs/menu_bar_page.dart';

class home_screen_biasa_ extends StatefulWidget {
  @override
  _home_screen_biasa_State createState() => _home_screen_biasa_State();
}
class _home_screen_biasa_State extends State<home_screen_biasa_> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
          ()=>Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder:
                                                          (context) => 
                                                          menu_bar_page_()
                                                         )
                                       )
         );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.white,
      decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/splash.jpg'),
                        fit: BoxFit.fill,                        
                        ),
                        // borderRadius: BorderRadius.all(Radius.circular(25)),color: Color.fromARGB(255, 179, 177, 177),
                        
                  ),
      height: MediaQuery.of(context).size.height,
    );
  }
}
