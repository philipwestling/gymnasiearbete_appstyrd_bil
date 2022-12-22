import 'package:flutter/material.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/setup.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/menu_action.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/routes.dart';

bool shouldDisconnect = false;

Widget menuButtonRow(BuildContext context) {
  return PopupMenuButton<MenuAction>(
    onSelected: ((value) async {
      switch (value) {
        case MenuAction.disconnect:
          shouldDisconnect = await showLogOutDialog(context);

          if (shouldDisconnect) {
            await scanStream.cancel();
            foundBluetoothDevicesList.clear();
            await bluetoothMonitor.flutterReactiveBle.deinitialize();
            Navigator.of(context)
                .pushNamedAndRemoveUntil(findDevicesRoute, (_) => false);
          }
          break;
      }
    }),
    itemBuilder: ((context) {
      return const [
        PopupMenuItem<MenuAction>(
          value: MenuAction.disconnect,
          child: Text("Avbryt Bluetoothanslutning"),
        ),
      ];
    }),
  );
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Avsluta bluetoothanslutning"),
        content: Text(
            "Vill du avsluta bluetoothanslutningen med ${deviceOfInterest.name}?"),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text(
              'Ja',
              style: TextStyle(color: Colors.green),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text(
              'Nej',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      );
    },
  ).then((value) => value ?? false);
}
