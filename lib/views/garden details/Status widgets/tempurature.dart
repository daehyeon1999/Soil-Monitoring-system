// ignore_for_file: must_be_immutable

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

/// Colors for the gradient text
List<Color> getColor(temp) {
  if (temp < 25) {
    return const [Color(0xff2196EB), Color(0xff5482C0)];
  } else if (temp < 50) {
    return const [Color(0xff5482C0), Color(0xff8F6B8D)];
  } else if (temp < 75) {
    return const [Color(0xff8F6B8D), Color(0xffCC5359)];
  } else {
    return const [Color(0xffCC5359), Color(0xffF44336)];
  }
}

class Temp extends StatelessWidget {
  double temp, width;
  Temp({Key? key, required this.temp, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //180
      width: width,
      height: 125,
      child: Card(
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Temperature text
            const Text("Temperature",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            const SizedBox(
              height: 5,
            ),
            // Opacity animation
            OpacityAnimatedWidget(
              delay: const Duration(milliseconds: 500),
              curve: Curves.ease,
              duration: const Duration(milliseconds: 500),
              enabled: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Gradient Text
                  GradientText(
                    "$temp",
                    colors: getColor(temp),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const Text("°C",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold))
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),

            /// Linear gauge
            SizedBox(
              width: 160,
              child: SfLinearGauge(
                showTicks: false,
                animationDuration: 500,
                animateRange: true,
                animateAxis: true,
                // Gauge division
                barPointers: [
                  LinearBarPointer(
                    value: temp,
                    color: Colors.red,
                  )
                ],

                /// Mark Pointer
                markerPointers: [
                  LinearShapePointer(
                    value: temp,
                    color: Colors.redAccent,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
