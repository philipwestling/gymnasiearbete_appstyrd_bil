import 'package:flutter/material.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/state.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/colors.dart';
import 'package:gymnasiearbete_appstyrd_bil/screens/bluetooth_deactivated_screen.dart';
import 'package:gymnasiearbete_appstyrd_bil/screens/find_bluetooth_device_screen.dart';
import 'package:gymnasiearbete_appstyrd_bil/screens/loading_screen.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev_tools show log;
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final flutterReactiveBle = FlutterReactiveBle();
  final bluetoothMonitor = BleStatusMonitor(flutterReactiveBle);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

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
          primarySwatch: mainColor,
        ),
        home: DeciderScreen(),
      ),
    ),
  );
}

class DeciderScreen extends StatelessWidget {
  const DeciderScreen({Key? key}) : super(key: key);

  //TODO - Kolla om Bluetooth är av eller på

  @override
  Widget build(BuildContext context) => Consumer<BleStatus?>(
        builder: (_, status, __) {
          dev_tools.log(status.toString());

          while (status == BleStatus.unknown) {
            return const LoadingScreen();
          }

          if (status == BleStatus.ready) {
            return const FindBluetoothDeviceScreen();
          } else {
            return const BluetoothDeactivatedScreen();
          }
        },
      );
}
