import 'package:flutter/material.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/colors.dart';

Widget activateBluetoothButton(BuildContext context) {
  return ButtonTheme(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: const Color.fromARGB(255, 0, 130, 0),
      ),
      onPressed: () {
        //TODO - Aktivera Bluetooth på enheten
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            "Aktivera Bluetooth",
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            width: 5,
          ),
          Icon(
            Icons.bluetooth,
            color: bluetoothColor,
          )
        ],
      ),
    ),
  );
}
