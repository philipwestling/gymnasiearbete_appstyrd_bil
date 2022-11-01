import 'package:flutter/material.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/colors.dart';
import 'package:gymnasiearbete_appstyrd_bil/widgets/bluetooth_devices_list.dart';

class FindBluetoothDeviceScreen extends StatelessWidget {
  const FindBluetoothDeviceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("Hitta Bluetoothenheter"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            //TODO - bluetooth_devices_list.dart
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        splashColor: findBluetoothDeviceButtonColor,
        child: const Icon(
          Icons.search_rounded,
          size: 34,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
