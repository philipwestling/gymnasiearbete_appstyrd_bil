import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gymnasiearbete_appstyrd_bil/screens/bluetooth_deactivated_screen.dart';
import 'package:gymnasiearbete_appstyrd_bil/screens/find_bluetooth_device_screen.dart';
import 'package:gymnasiearbete_appstyrd_bil/screens/loading_screen.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev_tools show log;

class DeciderScreen extends StatelessWidget {
  const DeciderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<BleStatus?>(
        builder: (_, status, __) {
          dev_tools.log(status.toString());

          while (status == BleStatus.unknown) {
            return const LoadingScreen();
          }

          // TODO - Lägg till villkor för flera olika errors, t.ex "Unauthorized"
          if (status == BleStatus.ready) {
            return const FindBluetoothDeviceScreen();
          } else {
            return const BluetoothDeactivatedScreen();
          }
        },
      );
}
