import 'package:flutter/material.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/variables.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/colors.dart';
import 'dart:developer' as dev_tools show log;

Widget carSteeringWidget(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      // Sväng vänster
      Container(
        margin: const EdgeInsets.only(right: 52),
        child: InkWell(
          // Tar bort "skugga" som lägger sig runt png-ytan
          highlightColor: transparentColor,
          splashColor: transparentColor,
          onTap: () async {
            dev_tools.log("Sväng vänster");
            await flutterReactiveBle.writeCharacteristicWithResponse(
              characteristic,
              value: [0x01],
            );
          },
          child: Image.asset(
            // https://www.pngall.com/steering-wheel-png/download/51522
            "lib/assets/images/steering_wheel_left.png",
            scale: 6,
          ),
        ),
      ),

      // Sväng höger
      Container(
        margin: const EdgeInsets.only(right: 340),
        child: InkWell(
          // Tar bort "skugga" som lägger sig runt png-ytan
          highlightColor: transparentColor,
          splashColor: transparentColor,
          onTap: () async {
            dev_tools.log("Sväng höger");
            await flutterReactiveBle.writeCharacteristicWithResponse(
              characteristic,
              value: [0x02],
            );
          },
          child: Image.asset(
            // https://www.pngall.com/steering-wheel-png/download/51522
            "lib/assets/images/steering_wheel_right.png",
            scale: 6,
          ),
        ),
      ),

      // Bromspedal
      Container(
        padding: const EdgeInsets.only(right: 10),
        child: InkWell(
          // Tar bort "skugga" som lägger sig runt png-ytan
          highlightColor: transparentColor,
          splashColor: transparentColor,
          onTap: () async {
            dev_tools.log("Bromspedal");
            await flutterReactiveBle.writeCharacteristicWithResponse(
              characteristic,
              value: [0x03],
            );
          },
          child: Image.asset(
            // https://pixabay.com/vectors/pedals-car-machine-gas-throttle-4519485/
            "lib/assets/images/brake_pedal.png",
            scale: 2,
          ),
        ),
      ),
      const SizedBox(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
        ),
      ),

      // Gaspedal
      Container(
        padding: const EdgeInsets.only(right: 10),
        child: InkWell(
          // Tar bort "skugga" som lägger sig runt png-ytan
          highlightColor: transparentColor,
          splashColor: transparentColor,
          onTap: () async {
            dev_tools.log("Gaspedal");
            await flutterReactiveBle.writeCharacteristicWithResponse(
              characteristic,
              value: [0x04],
            );
          },
          child: Image.asset(
            // https://pixabay.com/vectors/pedals-car-machine-gas-throttle-4519485/
            "lib/assets/images/throttle_pedal.png",
            scale: 2,
          ),
        ),
      ),
    ],
  );
}
