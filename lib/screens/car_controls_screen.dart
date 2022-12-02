import 'package:flutter/material.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/variables.dart';
import 'package:flutter/services.dart';
import 'package:gymnasiearbete_appstyrd_bil/widgets/steering.dart';

class CarControls extends StatefulWidget {
  const CarControls({Key? key}) : super(key: key);

  @override
  State<CarControls> createState() => _CarControlsState();
}

class _CarControlsState extends State<CarControls> {
  bool isLedOn = false;

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

            // Gas, broms och styrning
            Container(
              margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: carSteeringWidget,
            )
          ],
        ),
      ),
    );
  }
}
