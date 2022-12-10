import 'package:flutter/material.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/variables.dart';
import 'package:flutter/services.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/colors.dart';
import 'package:gymnasiearbete_appstyrd_bil/widgets/steering.dart';
import 'dart:developer' as dev_tools show log;

class CarControls extends StatefulWidget {
  const CarControls({Key? key}) : super(key: key);

  @override
  State<CarControls> createState() => _CarControlsState();
}

class _CarControlsState extends State<CarControls> {
  bool isHighBeamOn = false;

  // TODO: TA BORT EFTER DEBUG FÄRDIG
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft],
    );

    super.initState();
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
                  setState(() {
                    flutterReactiveBle.writeCharacteristicWithResponse(
                        characteristic,
                        value: [0x3]);
                    isHighBeamOn = !isHighBeamOn;
                  });
                },
                iconSize: 50,
                icon: isHighBeamOn
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
            isHighBeamOn ? const Text("Helljus På") : const Text("Helljus Av"),

            // Gas, broms och styrning
            Container(
              margin: const EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: carSteeringWidget(context),
            )
          ],
        ),
      ),
    );
  }
}
