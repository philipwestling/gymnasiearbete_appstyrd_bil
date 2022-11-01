import 'package:flutter/material.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/state.dart';
import 'package:gymnasiearbete_appstyrd_bil/screens/bluetooth_deactivated_screen.dart';
import 'package:gymnasiearbete_appstyrd_bil/screens/find_bluetooth_device_screen.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final flutterReactiveBle = FlutterReactiveBle();
  final bluetoothMonitor = BleStatusMonitor(flutterReactiveBle);

  runApp(
    MultiProvider(
      providers: [
        Provider.value(
          value: bluetoothMonitor,
        ),
        StreamProvider(
          create: (_) => bluetoothMonitor.state,
          initialData: BleStatus.unknown,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Appstyrd Bil",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: DeciderScreen(),
      ),
    ),
  );
}

class DeciderScreen extends StatelessWidget {
  DeciderScreen({Key? key}) : super(key: key);

  //TODO - Kolla om Bluetooth är av eller på

  @override
  Widget build(BuildContext context) => Consumer<BleStatus?>(
        builder: (_, status, __) {
          print(FlutterReactiveBle().status);
          if (status == BleStatus.ready) {
            return const FindBluetoothDeviceScreen();
          } else {
            return const BluetoothDeactivatedScreen();
          }
        },
      );
}
