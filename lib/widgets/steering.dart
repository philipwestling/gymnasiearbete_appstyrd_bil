import 'package:flutter/material.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/variables.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/colors.dart';
import 'dart:developer' as dev_tools show log;

Widget carSteeringWidget = Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    // Vänster pil
    Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
      child: IconButton(
        onPressed: () {
          flutterReactiveBle.writeCharacteristicWithResponse(
            characteristic,
            value: [0x12],
          );
        },
        icon: const Icon(
          Icons.arrow_left,
        ),
      ),
    ),

    // Höger pil
    Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.red,
      ),
      margin: const EdgeInsets.fromLTRB(0, 0, 552, 0),
      child: IconButton(
        onPressed: () {
          flutterReactiveBle.writeCharacteristicWithResponse(
            characteristic,
            value: [0x13],
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
