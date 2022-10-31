import 'package:flutter/material.dart';
import 'package:gymnasiearbete_appstyrd_bil/screens/bluetooth_deactivated_screen.dart';
import 'package:gymnasiearbete_appstyrd_bil/screens/find_bluetooth_device_screen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Appstyrd Bil',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const BluetoothDeactivatedScreen(),
    ),
  );
}

class DeciderScreen extends StatelessWidget {
  const DeciderScreen({Key? key}) : super(key: key);

  //TODO - Kolla om Bluetooth är av eller på

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
