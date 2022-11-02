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
  late DiscoveredDevice deviceOfInterest;
  late StreamSubscription<DiscoveredDevice> scanStream;
  bool isScanning = false;

  void addToFoundBluetoothDevicesList(String foundDevice) {
    if (foundBluetoothDevicesList.contains(foundDevice)) {
      return;
    } else {
      setState(
        () {
          foundBluetoothDevicesList.add(foundDevice);
        },
      );
    }
  }

  void bluetoothScan() {
    if (isScanning == false) {
      dev_tools.log("Searching for bluetooth devices...");
      isScanning = true;
      scanStream = flutterReactiveBle.scanForDevices(
        withServices: [/*bluetooth_uuid*/],
      ).listen(
        (foundDevice) {
          addToFoundBluetoothDevicesList(foundDevice.name);
          if (foundDevice.name == "HC-06") {
            deviceOfInterest = foundDevice;
          }
        },
      );
    } else {
      scanStream.cancel();
      foundBluetoothDevicesList.length = 0;
      dev_tools.log("Stop searching for bluetooth devices...");
      isScanning = false;
    }

    //TODO - Kolla om isScanning är true eller false
  }

  void connectToDeviceOfInterest() {
    isScanning = false;
    flutterReactiveBle
        .connectToAdvertisingDevice(
      id: deviceOfInterest.id,
      withServices: serviceUuid,
      prescanDuration: const Duration(seconds: 10),
      connectionTimeout: const Duration(seconds: 5),
    )
        .listen(
      (event) {
        switch (event.connectionState) {
          case DeviceConnectionState.connecting:
            {
              dev_tools.log("Connecting to ${deviceOfInterest.name}");
              break;
            }
          case DeviceConnectionState.connected:
            {
              dev_tools.log("Connected to ${deviceOfInterest.name}");
              break;
            }
          case DeviceConnectionState.disconnecting:
            {
              dev_tools.log("Disconnecting from ${deviceOfInterest.name}");
              break;
            }
          case DeviceConnectionState.disconnected:
            {
              dev_tools.log("Disconnected from ${deviceOfInterest.name}");
              break;
            }
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
          setState(() {
            bluetoothScan();
          });
        },
        splashColor: findBluetoothDeviceButtonColor,
        child: isScanning
            ? const Icon(
                Icons.cancel,
                size: 34,
              )
            : const Icon(
                Icons.search_rounded,
                size: 34,
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
