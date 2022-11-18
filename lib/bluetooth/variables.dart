import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

final Uuid serviceUuid = Uuid.parse(
  "19B10000-E8F2-537E-4F6C-D104768A1214",
);

final Uuid characteristicUuid = Uuid.parse(
  "19B10001-E8F2-537E-4F6C-D104768A1214",
);

late DiscoveredDevice deviceOfInterest;

var foundBluetoothDevicesList = <String>[];

final flutterReactiveBle = FlutterReactiveBle();

late StreamSubscription<DiscoveredDevice> scanStream;

bool isScanning = false;
