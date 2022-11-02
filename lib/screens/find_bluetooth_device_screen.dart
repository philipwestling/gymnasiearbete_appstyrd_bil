import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/bluetooth_uuid.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/colors.dart';
import 'dart:developer' as dev_tools show log;

class FindBluetoothDeviceScreen extends StatefulWidget {
  const FindBluetoothDeviceScreen({Key? key}) : super(key: key);

  @override
  State<FindBluetoothDeviceScreen> createState() =>
      _FindBluetoothDeviceScreenState();
}

class _FindBluetoothDeviceScreenState extends State<FindBluetoothDeviceScreen> {
  var foundBluetoothDevicesList = <String>[];
  final flutterReactiveBle = FlutterReactiveBle();
  late StreamSubscription<DiscoveredDevice> bluetoothScanStream;
  late DiscoveredDevice deviceOfInterest;

  void addToFoundBluetoothDevicesList(String foundDevice) {
    if (foundBluetoothDevicesList.contains(foundDevice) ||
        foundBluetoothDevicesList.contains("")) {
      return;
    } else {
      setState(() {
        foundBluetoothDevicesList.add(foundDevice);
      });
    }
  }

  void bluetoothScan() {
    flutterReactiveBle.scanForDevices(
      withServices: [/*bluetooth_uuid*/],
    ).listen(
      (foundDevice) {
        dev_tools.log(
          foundDevice.name,
        );
        addToFoundBluetoothDevicesList(foundDevice.name);
        if (foundDevice.name == "HC-06") {
          deviceOfInterest = foundDevice;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text("Hitta Bluetoothenheter"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 70),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: ((
                    context,
                    index,
                  ) {
                    return Card(
                      child: ListTile(
                        title: Text(foundBluetoothDevicesList[index]),
                        onTap: () {
                          // ShowDialog
                        },
                      ),
                    );
                  }),
                  itemCount: foundBluetoothDevicesList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(4),
                ),

                //TODO - bluetooth_devices_list.dart
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dev_tools.log("Searching for bluetooth devices...");
          setState(() {
            bluetoothScan();
          });
        },
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
