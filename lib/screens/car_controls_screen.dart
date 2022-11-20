import 'package:flutter/material.dart';

import 'package:gymnasiearbete_appstyrd_bil/bluetooth/variables.dart';
import 'dart:developer' as dev_tools show log;
import 'package:flutter/services.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/colors.dart';
import 'package:vibration/vibration.dart';

class CarControls extends StatefulWidget {
  const CarControls({Key? key}) : super(key: key);

  @override
  State<CarControls> createState() => _CarControlsState();
}

class _CarControlsState extends State<CarControls> {
  bool isLedOn = false;
  var sliderValue = 0.0;

  // TODO: TA BORT EFTER DEBUG FÄRDIG
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft],
    );

    super.initState();
  }

  void ledOn() {
    flutterReactiveBle.writeCharacteristicWithResponse(
      characteristic,
      // Hexadecimal
      value: [0x01],
    );
    isLedOn = !isLedOn;
  }

  void ledOff() {
    flutterReactiveBle.writeCharacteristicWithResponse(
      characteristic,
      // Hexadecimal
      value: [0x00],
    );
    isLedOn = !isLedOn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Ink(
              decoration: const ShapeDecoration(
                shape: CircleBorder(),
                color: Colors.lightBlue,
              ),
              child: IconButton(
                onPressed: () {
                  setState(
                    () {
                      if (!isLedOn) {
                        ledOn();
                      } else {
                        ledOff();
                      }
                    },
                  );
                },
                iconSize: 50,
                icon: isLedOn
                    ? const Icon(
                        Icons.lightbulb,
                        color: Colors.amber,
                        size: 38,
                      )
                    : const Icon(
                        Icons.lightbulb_outline_rounded,
                        color: Colors.amber,
                        size: 38,
                      ),
              ),
            ),
            isLedOn ? const Text("Led På") : const Text("Led Av"),
            Slider(
              value: sliderValue,
              onChanged: (newSliderValue) {
                setState(
                  () {
                    // TODO - Decimal till hexadecimal
                    sliderValue = newSliderValue;

                    dev_tools.log(
                      sliderValue.toInt().toRadixString(16),
                    );
                    var a = "0x${sliderValue.toInt().toRadixString(16)}";
                    flutterReactiveBle.writeCharacteristicWithResponse(
                        characteristic,
                        value: [int.parse(a)]);
                    dev_tools.log(int.parse(a).toString());
                  },
                );
              },
              max: 100,
              min: 0,
            ),
            Text("${sliderValue.toInt()}"),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    // Tar bort "skugga" som lägger sig runt png-ytan
                    highlightColor: transparentColor,
                    splashColor: transparentColor,
                    onTap: () {
                      dev_tools.log("Throttle pedal tap");
                      Vibration.vibrate(duration: 100);
                    },
                    child: Image.asset(
                      "lib/assets/images/throttle_pedal.png",
                      scale: 2,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
