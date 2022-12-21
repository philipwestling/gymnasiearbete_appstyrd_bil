import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/methods.dart';
import 'package:gymnasiearbete_appstyrd_bil/widgets/gears.dart';
import 'package:gymnasiearbete_appstyrd_bil/widgets/light_buttons.dart';
import 'package:gymnasiearbete_appstyrd_bil/widgets/pedals.dart';
import 'package:gymnasiearbete_appstyrd_bil/widgets/joystick.dart';
import 'dart:developer' as dev_tools show log;

class CarControls extends StatefulWidget {
  const CarControls({Key? key}) : super(key: key);

  @override
  State<CarControls> createState() => _CarControlsState();
}

class _CarControlsState extends State<CarControls> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft],
    );
    super.initState();
  }

  bool isHighbeamActivated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        shadowColor: Colors.white,
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async {
                  sendToUnoWifi(8);
                },
                // https://www.flaticon.com/free-icon/turn-signal_3674908?term=turn+signal&page=1&position=39&origin=search&related_id=3674908
                icon: Image.asset("lib/assets/images/turn_signal_left.png"),
                iconSize: 40,
              ),
              IconButton(
                onPressed: () async {
                  sendToUnoWifi(9);
                },
                // https://www.flaticon.com/free-icon/turn-signal_3674908?term=turn+signal&page=1&position=39&origin=search&related_id=3674908
                icon: Image.asset("lib/assets/images/turn_signal_right.png"),
                iconSize: 40,
              ),
              IconButton(
                onPressed: () async {
                  setState(() {
                    isHighbeamActivated = !isHighbeamActivated;
                  });
                  sendToUnoWifi(7);
                },
                // https://www.flaticon.com/free-icon/high-beam_95138
                icon: isHighbeamActivated
                    ? Image.asset("lib/assets/images/high_beam_activated2.png")
                    : Image.asset(
                        "lib/assets/images/high_beam_deactivated.png"),
                iconSize: 40,
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.settings),
                color: Colors.blueGrey,
                iconSize: 30,
              ),
            ],
          )
        ],
      ),
      backgroundColor: Color.fromARGB(250, 255, 255, 255),
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 110, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gas, broms och styrning
            Row(
              children: [
                carSteeringWidget(context),
                const SizedBox(
                  width: 400,
                ),
                carPedalWidget(context),
                const SizedBox(
                  width: 10,
                ),
                gearsWidget(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
