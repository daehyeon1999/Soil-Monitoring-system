import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/garden_page_name.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/humidity.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/phLevel.dart';
import 'package:thesis/IOS/Gardens/Garden%20Page%20widgets/tempurature.dart';
import 'package:thesis/IOS/Gardens/history_page.dart';
import 'dart:math' as math;

import 'Garden Page widgets/moisture.dart';
import 'Garden Page widgets/npk_status.dart';

class Garden extends StatefulWidget {
  const Garden({Key? key}) : super(key: key);

  @override
  _GardenState createState() => _GardenState();
}

class _GardenState extends State<Garden> {
  //dump data
  bool isSettingPressed = false;
  String gardenName = "Garden";
  Map<String, double> dataMap = {"N": 30, "P": 30, "K": 30};
  double ph = 7;
  double moisture = 46;
  double temp = 31, humidity = 30;

  TextEditingController nameControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        backgroundColor: const Color(0xff669D6B),
        elevation: 0,

        /// Back button
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: SvgPicture.asset(
            'assets/back.svg',
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        /// My Gardens
        title: const Text("My Gardens"),
        titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            fontFamily: "Readex Pro"),
        centerTitle: false,
        titleSpacing: -10,

        /// History button, setting button
        actions: [
          /// History button
          IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.push(
                        context,
                        PageTransition(
                            duration: const Duration(milliseconds: 595),
                            child: HistoryPage(),
                            type: PageTransitionType.rightToLeft))
                    .then((value) {
                  setState(() {});
                });
              },
              icon: const Icon(
                Icons.insert_chart_outlined,
                color: Colors.white,
                size: 30,
              )),

          /// Setting button
          IconButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              setState(() {
                // if the icon is setting icon ans it is not pressed,
                if (isSettingPressed == false) {
                  // change the icon to check
                  isSettingPressed = true;
                } else {
                  setState(() {
                    if (nameControl.text != "") gardenName = nameControl.text;
                  });
                  // change the icon the setting
                  isSettingPressed = false;
                }
              });
            },
            icon: isSettingPressed == false
                ? SvgPicture.asset("assets/setting.svg")
                : SvgPicture.asset(
                    "assets/check.svg",
                    height: 20,
                  ),
          )
        ],
      ),
      backgroundColor: const Color(0xff669D6B),
      body: SafeArea(
          bottom: false,
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                /// Body
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  height: 500,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// Left Column
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// Name of the Garden
                          GardenName(
                              gardenName: gardenName,
                              isSettingPressed: isSettingPressed,
                              nameControl: nameControl),

                          /// NPK status
                          TranslationAnimatedWidget.tween(
                            duration: const Duration(seconds: 1),
                            enabled: true,
                            translationDisabled: const Offset(-500, 0),
                            translationEnabled: const Offset(0, 0),
                            curve: Curves.fastOutSlowIn,
                            child: OpacityAnimatedWidget.tween(
                              duration: const Duration(seconds: 1),
                              enabled: true,
                              opacityDisabled: 0,
                              opacityEnabled: 1,
                              child: NPKstatus(dataMap: dataMap),
                            ),
                          ),

                          //
                          const SizedBox(
                            height: 20,
                          ),

                          /// Temperature
                          TranslationAnimatedWidget.tween(
                            delay: const Duration(milliseconds: 700),
                            duration: const Duration(seconds: 1),
                            enabled: true,
                            translationDisabled: const Offset(-500, 0),
                            translationEnabled: const Offset(0, 0),
                            curve: Curves.fastOutSlowIn,
                            child: OpacityAnimatedWidget.tween(
                              duration: const Duration(seconds: 1),
                              enabled: true,
                              opacityDisabled: 0,
                              opacityEnabled: 1,
                              child: OpenContainer(
                                  transitionDuration:
                                      const Duration(milliseconds: 300),
                                  closedElevation: 5,
                                  // When the Container is closed
                                  onClosed: (data) {
                                    setState(() {});
                                  },
                                  clipBehavior: Clip.hardEdge,
                                  //Shape of the close Container
                                  closedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  closedBuilder: (_, closedBuilder) => Temp(
                                        temp: temp,
                                      ),
                                  openBuilder: (_, openBuilder) =>
                                      HistoryPage()),
                            ),
                          ),
                        ],
                      ),

                      // Right Column
                      Column(
                        children: [
                          /// Ph Level
                          TranslationAnimatedWidget.tween(
                            delay: const Duration(milliseconds: 300),
                            duration: const Duration(seconds: 1),
                            enabled: true,
                            translationDisabled: const Offset(500, 0),
                            translationEnabled: const Offset(0, 0),
                            curve: Curves.fastOutSlowIn,
                            child: OpacityAnimatedWidget.tween(
                              duration: const Duration(seconds: 1),
                              enabled: true,
                              opacityDisabled: 0,
                              opacityEnabled: 1,
                              child: OpenContainer(
                                  transitionDuration:
                                      const Duration(milliseconds: 300),
                                  closedElevation: 5,
                                  // When the Container is closed
                                  onClosed: (data) {
                                    setState(() {});
                                  },
                                  clipBehavior: Clip.hardEdge,
                                  //Shape of the close Container
                                  closedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  closedBuilder: (_, closedBuilder) =>
                                      Ph_Level(ph: ph),
                                  openBuilder: (_, openBuilder) =>
                                      HistoryPage()),
                            ),
                          ),

                          //
                          const SizedBox(
                            height: 20,
                          ),

                          /// Moisture
                          TranslationAnimatedWidget.tween(
                            delay: const Duration(milliseconds: 500),
                            duration: const Duration(seconds: 1),
                            enabled: true,
                            translationDisabled: const Offset(500, 0),
                            translationEnabled: const Offset(0, 0),
                            curve: Curves.fastOutSlowIn,
                            child: OpacityAnimatedWidget.tween(
                              duration: const Duration(seconds: 1),
                              enabled: true,
                              opacityDisabled: 0,
                              opacityEnabled: 1,
                              child: OpenContainer(
                                  transitionDuration:
                                      const Duration(milliseconds: 300),
                                  closedElevation: 5,
                                  // When the Container is closed
                                  onClosed: (data) {
                                    setState(() {});
                                  },
                                  clipBehavior: Clip.hardEdge,
                                  //Shape of the close Container
                                  closedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  closedBuilder: (_, closedBuilder) =>
                                      Moisture_Level(moisture: moisture),
                                  openBuilder: (_, openBuilder) =>
                                      HistoryPage()),
                            ),
                          ),

                          //
                          const SizedBox(
                            height: 20,
                          ),

                          /// Humidity
                          TranslationAnimatedWidget.tween(
                            delay: const Duration(milliseconds: 900),
                            duration: const Duration(seconds: 1),
                            enabled: true,
                            translationDisabled: const Offset(500, 0),
                            translationEnabled: const Offset(0, 0),
                            curve: Curves.fastOutSlowIn,
                            child: OpacityAnimatedWidget.tween(
                              duration: const Duration(seconds: 1),
                              enabled: true,
                              opacityDisabled: 0,
                              opacityEnabled: 1,
                              child: OpenContainer(
                                  transitionDuration:
                                      const Duration(milliseconds: 300),
                                  closedElevation: 5,
                                  // When the Container is closed
                                  onClosed: (data) {
                                    setState(() {});
                                  },
                                  clipBehavior: Clip.hardEdge,
                                  //Shape of the close Container
                                  closedShape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  closedBuilder: (_, closedBuilder) =>
                                      Humidity(humidity: humidity),
                                  openBuilder: (_, openBuilder) =>
                                      HistoryPage()),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                // Bottom
                Flexible(
                  fit: FlexFit.tight,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xfffefefe),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            spreadRadius: 5,
                            blurRadius: 30,
                            offset: const Offset(0, 10))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

// Random color
Color randomColor() {
  var g = math.Random.secure().nextInt(255);
  var b = math.Random.secure().nextInt(255);
  var r = math.Random.secure().nextInt(255);
  return Color.fromARGB(255, r, g, b);
}
