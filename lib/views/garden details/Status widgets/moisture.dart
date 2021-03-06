// ignore_for_file: must_be_immutable

import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MoistureLevel extends StatefulWidget {
  double moisture, width;
  MoistureLevel({Key? key, required this.moisture, required this.width})
      : super(key: key);

  @override
  _MoistureLevelState createState() => _MoistureLevelState();
}

class _MoistureLevelState extends State<MoistureLevel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //180
      width: widget.width,
      height: 130,
      child: Card(
        elevation: 10,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          /// Moisture Text
          const Text("Moisture",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),

          /// Opacity animation
          OpacityAnimatedWidget(
            delay: const Duration(milliseconds: 500),
            curve: Curves.ease,
            duration: const Duration(milliseconds: 500),
            enabled: true,
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              /// value
              Text(
                "${widget.moisture}",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "%",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent),
              )
            ]),
          ),
          SizedBox(
            width: 160,

            /// Moisture Gauge
            child: SfLinearGauge(
              showTicks: false,
              animationDuration: 500,
              animateRange: true,

              /// the value where the pointer pointing
              barPointers: [
                LinearBarPointer(
                  value: widget.moisture,
                  color: Colors.blueAccent,
                )
              ],

              /// pointer
              markerPointers: [
                LinearShapePointer(
                  value: widget.moisture,
                  color: Colors.blueAccent,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
