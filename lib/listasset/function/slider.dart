import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:member_ebs/menu_utama/page_account/account_page.dart';
import 'package:member_ebs/main.dart';

class sliderpage extends StatefulWidget {
  const sliderpage({Key? key}) : super(key: key);

  @override
  sliderState createState() => sliderState();
}

class sliderState extends State<sliderpage> {
  List<Slide> slides = [];
  late Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "Welcome To Bernardi",
        styleTitle: TextStyle(
            color: Color.fromARGB(255, 58, 12, 163),
            fontSize: 32,
            fontFamily: 'roboto',
            fontWeight: FontWeight.bold),
        description:
            "You're always welcome here. I could not have a more welcome visitor, said Bilibin as he came out to meet Prince Andrew. You're welcome to use the pool any time you want. In spite of the continual struggle for custody, he had felt more welcome at the Medena home than he had with his step-father's family",
        styleDescription: TextStyle(
            color: Color.fromARGB(255, 58, 12, 163),
            fontSize: 18,
            fontFamily: 'Roboto'),
        pathImage: 'assets/images/123.gif',
        backgroundColor: const Color(0xfff5a623),
      ),
    );
    slides.add(
      Slide(
        title: "Membership",
        styleTitle: TextStyle(
            color: Color.fromARGB(255, 181, 23, 159),
            fontSize: 32,
            fontFamily: 'roboto',
            fontWeight: FontWeight.bold),
        description:
            "A membership site is a hub where members can access training content and an exclusive community for a recurring fee. This area is protected by a login, so only paying members can access your content.",
        styleDescription: TextStyle(
            color: Color.fromARGB(255, 181, 23, 159),
            fontSize: 18,
            fontFamily: 'Roboto'),
        pathImage: 'assets/images/122.gif',
        backgroundColor: Colors.white,
      ),
    );
    slides.add(
      Slide(
          title: "Loyalty Card",
          styleTitle:
              TextStyle(color: Color.fromARGB(255, 58, 12, 163), fontSize: 24),
          description:
              "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
          styleDescription:
              TextStyle(color: Color.fromARGB(255, 58, 12, 163), fontSize: 20),
          pathImage: 'assets/images/125.gif',
          backgroundColor: Color.fromARGB(97, 153, 50, 204)),
    );
  }

  Widget renderNextBtn() {
    return const Icon(
      Icons.navigate_next,
      color: Color.fromARGB(255, 247, 37, 135),
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return const Icon(
      Icons.done,
      color: Color.fromARGB(255, 247, 37, 135),
    );
  }

  Widget renderSkipBtn() {
    return const Icon(
      Icons.skip_next,
      color: Color.fromARGB(255, 247, 37, 135),
    );
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(const StadiumBorder()),
      backgroundColor:
          MaterialStateProperty.all<Color>(Color.fromARGB(52, 255, 133, 218)),
      overlayColor: MaterialStateProperty.all<Color>(const Color(0x33ffcc5c)),
    );
  }

  void onDonePress() {
    // Do what you want
    Navigator.pop(context);
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
    log("onTabChangeCompleted, index: $index");
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      // Skip button
      renderSkipBtn: renderSkipBtn(),
      skipButtonStyle: myButtonStyle(),

      // Next button
      renderNextBtn: renderNextBtn(),
      nextButtonStyle: myButtonStyle(),

      // Done button
      renderDoneBtn: renderDoneBtn(),
      onDonePress: onDonePress,
      doneButtonStyle: myButtonStyle(),

      // Dot indicator
      colorDot: Color.fromARGB(143, 113, 9, 182),
      sizeDot: 13.0,
      typeDotAnimation: DotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      slides: slides,
      backgroundColorAllSlides: Colors.white,
      refFuncGoToTab: (refFunc) {
        goToTab = refFunc;
      },

      // Behavior
      scrollPhysics: const BouncingScrollPhysics(),

      // Show or hide status bar
      hideStatusBar: true,

      // On tab change completed
      onTabChangeCompleted: onTabChangeCompleted,
    );
  }
}
