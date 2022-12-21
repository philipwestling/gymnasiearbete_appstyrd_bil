import 'package:flutter/material.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/methods.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/colors.dart';
import 'dart:developer' as dev_tools show log;

import 'package:toggle_switch/toggle_switch.dart';

Widget carPedalWidget(BuildContext context) {
  bool isReverse = false;
  return Row(
    children: [
      ToggleSwitch(
        minWidth: 50,
        radiusStyle: true,
        initialLabelIndex: 1,
        totalSwitches: 3,
        isVertical: true,
        labels: const ["D", "N", "R"],
        onToggle: (index) {
          switch (index) {
            case 0:
              isReverse = false;
              break;
            case 1:
              isReverse = false;
              break;
            case 2:
              isReverse = true;
              break;
          }
        },
      ),
      // Bromspedal
      InkWell(
        // Tar bort "skugga" som lägger sig runt png-ytan
        highlightColor: transparentColor,
        splashColor: transparentColor,
        onTap: () async {
          dev_tools.log("Bromspedal");
          sendToUnoWifi(4);
        },
        child: Image.asset(
          // https://pixabay.com/vectors/pedals-car-machine-gas-throttle-4519485/
          "lib/assets/images/brake_pedal.png",
          scale: 2,
        ),
      ),

      // Utrymme mellan gas och broms
      const SizedBox(
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 30, 0),
        ),
      ),

      // Gaspedal
      InkWell(
        // Tar bort "skugga" som lägger sig runt png-ytan
        highlightColor: transparentColor,
        splashColor: transparentColor,
        onTap: () async {
          dev_tools.log("Gaspedal");
          // ignore: dead_code
          sendToUnoWifi(isReverse ? 6 : 5);
        },
        child: Image.asset(
          // https://pixabay.com/vectors/pedals-car-machine-gas-throttle-4519485/
          "lib/assets/images/throttle_pedal.png",
          scale: 2,
        ),
      ),
    ],
  );
}
