import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymnasiearbete_appstyrd_bil/widgets/gears.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 180, 0, 0),
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
                SizedBox(
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
