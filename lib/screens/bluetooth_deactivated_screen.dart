import 'package:flutter/material.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/colors.dart';
import 'package:gymnasiearbete_appstyrd_bil/widgets/activate_bluetooth_button.dart';

class BluetoothDeactivatedScreen extends StatefulWidget {
  const BluetoothDeactivatedScreen({Key? key}) : super(key: key);

  @override
  State<BluetoothDeactivatedScreen> createState() =>
      _BluetoothDeactivatedScreenState();
}

class _BluetoothDeactivatedScreenState
    extends State<BluetoothDeactivatedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              child: const Icon(
                Icons.bluetooth_disabled_outlined,
                size: 160,
                color: bluetoothColor,
              ),
            ),
            const Text(
              "Bluetooth är för tillfället avaktiverat på enheten",
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              child: activateBluetoothButton(context),
            ),
          ],
        ),
      ),
    );
  }
}
