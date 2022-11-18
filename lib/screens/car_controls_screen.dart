import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/state.dart';
import 'dart:developer' as dev_tools show log;

class CarControls extends StatefulWidget {
  const CarControls({Key? key}) : super(key: key);

  @override
  State<CarControls> createState() => _CarControlsState();
}

class _CarControlsState extends State<CarControls> {
  var flag = 0;
  final frb = FlutterReactiveBle();
  final characteristic = QualifiedCharacteristic(
      characteristicId: Uuid.parse("19B10001-E8F2-537E-4F6C-D104768A1214"),
      serviceId: Uuid.parse("19B10000-E8F2-537E-4F6C-D104768A1214"),
      deviceId: deviceOfInterest.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Ink(
          decoration: const ShapeDecoration(
            shape: CircleBorder(),
            color: Colors.lightBlue,
          ),
          child: IconButton(
            onPressed: () {
              setState(() {
                //TODO - LED
                if (flag == 0) {
                  frb.writeCharacteristicWithResponse(
                    characteristic,
                    // Hexadecimal
                    value: [0x01],
                  );
                  flag = 1;
                } else {
                  frb.writeCharacteristicWithResponse(
                    characteristic,
                    // Hexadecimal
                    value: [0x00],
                  );
                  flag = 0;
                }
              });
            },
            iconSize: 50,
            icon: const Icon(
              Icons.lightbulb_outline_rounded,
              color: Colors.amber,
              size: 38,
            ),
          ),
        ),
      ),
    );
  }
}
