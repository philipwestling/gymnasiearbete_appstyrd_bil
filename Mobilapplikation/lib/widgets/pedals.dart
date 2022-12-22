import 'package:flutter/material.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/methods.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/colors.dart';
import 'package:gymnasiearbete_appstyrd_bil/widgets/gears.dart';
import 'dart:developer' as dev_tools show log;

Widget carPedalWidget(BuildContext context) {
  return Row(
    children: [
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
          if (isInNeutral == false) {
            sendToUnoWifi(isReverse ? 6 : 5);
          } else {
            return;
          }
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
