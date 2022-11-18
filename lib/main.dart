import 'package:flutter/material.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/state.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/colors.dart';
import 'package:gymnasiearbete_appstyrd_bil/screens/car_controls_screen.dart';
import 'package:gymnasiearbete_appstyrd_bil/screens/decider_screen.dart';
import 'package:gymnasiearbete_appstyrd_bil/screens/find_bluetooth_device_screen.dart';
import 'package:gymnasiearbete_appstyrd_bil/constants/routes.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

void main() {
  //
  WidgetsFlutterBinding.ensureInitialized();

  // Gömmer Android "Navigation Bar"
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  final flutterReactiveBle = FlutterReactiveBle();
  final bluetoothMonitor = BleStatusMonitor(flutterReactiveBle);

  runApp(
    MultiProvider(
      providers: [
        Provider.value(
          value: bluetoothMonitor,
        ),
        StreamProvider(
          create: (_) {
            return bluetoothMonitor.state;
          },
          initialData: BleStatus.unknown,
        ),
      ],
      child: MaterialApp(
        routes: {
          carControlsRoute: (context) => const CarControls(),
          findDevicesRoute: (context) => const FindBluetoothDeviceScreen(),
        },
        debugShowCheckedModeBanner: false,
        title: "Gymnasiearbete appstyrd bil",
        theme: ThemeData(
          primarySwatch: mainColor,
        ),
        home: const DeciderScreen(),
      ),
    ),
  );
}
