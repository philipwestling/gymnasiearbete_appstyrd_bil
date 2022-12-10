import 'package:flutter/material.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/variables.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/colors.dart';
import 'dart:developer' as dev_tools show log;

Widget carSteeringWidget(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      // Vänster pil
      Container(
        margin: const EdgeInsets.only(right: 50),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
        child: IconButton(
          onPressed: () {
            flutterReactiveBle.writeCharacteristicWithResponse(
              characteristic,
              value: [0x1],
            );
          },
          icon: const Icon(
            Icons.arrow_left,
          ),
        ),
      ),

      // Höger pil
      Container(
        margin: const EdgeInsets.only(right: 510),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
        child: IconButton(
          onPressed: () {
            flutterReactiveBle.writeCharacteristicWithResponse(
              characteristic,
              value: [0x2],
            );
          },
          icon: const Icon(
            Icons.arrow_right,
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
          onTap: () {
            dev_tools.log("Brake pedal tap");
            flutterReactiveBle.writeCharacteristicWithResponse(
              characteristic,
              value: [0x10],
            );
          },
          child: Image.asset(
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

      //Gaspedal
      Container(
        padding: const EdgeInsets.only(right: 10),
        child: InkWell(
          // Tar bort "skugga" som lägger sig runt png-ytan
          highlightColor: transparentColor,
          splashColor: transparentColor,
          onTap: () {
            dev_tools.log("Throttle pedal tap");
            flutterReactiveBle.writeCharacteristicWithResponse(
              characteristic,
              value: [0x11],
            );
          },
          child: Image.asset(
            "lib/assets/images/throttle_pedal.png",
            scale: 2,
          ),
        ),
      ),
    ],
  );
}
