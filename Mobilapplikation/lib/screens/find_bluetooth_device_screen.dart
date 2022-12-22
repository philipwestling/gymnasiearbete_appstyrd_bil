import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/setup.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/colors.dart';
import 'dart:developer' as dev_tools show log;
import 'package:flutter/services.dart';

import 'package:gymnasiearbete_appstyrd_bil/constants/routes.dart';

class FindBluetoothDeviceScreen extends StatefulWidget {
  const FindBluetoothDeviceScreen({Key? key}) : super(key: key);

  @override
  State<FindBluetoothDeviceScreen> createState() =>
      _FindBluetoothDeviceScreenState();
}

class _FindBluetoothDeviceScreenState extends State<FindBluetoothDeviceScreen> {
  bool isScanning = false;

  // Lägg till hittad Bluetoothenhet i en lista
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

  // Börja skanna efter Bluetoothenheter
  void bluetoothScan() async {
    if (isScanning == false) {
      dev_tools.log("Searching for bluetooth devices...");
      isScanning = true;
      scanStream = flutterReactiveBle.scanForDevices(withServices: []).listen(
        (foundDevice) {
          addToFoundBluetoothDevicesList(foundDevice.name);
          if (foundDevice.name == "Appstyrd Bil") {
            dev_tools.log("Found ${foundDevice.name}!");
            deviceOfInterest = foundDevice;
          }
        },
      );
    } else {
      await scanStream.cancel();
      foundBluetoothDevicesList.clear();
      dev_tools.log("Stop searching for bluetooth devices...");
      isScanning = false;
    }
  }

  void connectToDeviceOfInterest() async {
    await Future.delayed(const Duration(milliseconds: 200));
    await scanStream.cancel();
    isScanning = false;
    flutterReactiveBle
        .connectToAdvertisingDevice(
      id: deviceOfInterest.id,
      withServices: [],
      prescanDuration: const Duration(seconds: 2),
      connectionTimeout: const Duration(seconds: 2),
    )
        .listen(
      (event) async {
        switch (event.connectionState) {
          case DeviceConnectionState.connecting:
            {
              dev_tools.log("Connecting to ${deviceOfInterest.name}...");
              break;
            }
          case DeviceConnectionState.connected:
            {
              await flutterReactiveBle.clearGattCache(deviceOfInterest.id);
              dev_tools.log("Connected to ${deviceOfInterest.name}!");

              // Liggande skärm för bättre kontrollyta i "car_controls_screen"
              SystemChrome.setPreferredOrientations(
                [DeviceOrientation.landscapeLeft],
              );
              await Navigator.of(context)
                  .pushNamedAndRemoveUntil(carControlsRoute, (route) => false);
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
      // TODO - onError:
    );
  }

  showConnectDialog(BuildContext context, String deviceName) {
    const double jaNejSize = 18;
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Bluetooth anslutning"),
          content: Text("Vill du ansluta till $deviceName?"),
          actionsAlignment: MainAxisAlignment.spaceAround,
          insetPadding: const EdgeInsets.all(50),
          actions: [
            TextButton(
              onPressed: () {
                connectToDeviceOfInterest();
                Navigator.of(context).pop(true);
              },
              child: const Text(
                "Ja",
                style: TextStyle(
                  fontSize: jaNejSize,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text(
                "Nej",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: jaNejSize,
                ),
              ),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp],
    );
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
                          //TODO - ShowDialog
                          showConnectDialog(
                              context, foundBluetoothDevicesList[index]);
                        },
                      ),
                    );
                  }),
                  itemCount: foundBluetoothDevicesList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(4),
                ),
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
