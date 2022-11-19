import 'dart:async';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/state.dart';

final Uuid serviceUuid = Uuid.parse(
  "19B10000-E8F2-537E-4F6C-D104768A1214",
);

final Uuid characteristicUuid = Uuid.parse(
  "19B10001-E8F2-537E-4F6C-D104768A1214",
);

late DiscoveredDevice deviceOfInterest;

var foundBluetoothDevicesList = <String>[];

final flutterReactiveBle = FlutterReactiveBle();

final bluetoothMonitor = BleStatusMonitor(flutterReactiveBle);

late StreamSubscription<DiscoveredDevice> scanStream;

final characteristic = QualifiedCharacteristic(
    characteristicId: Uuid.parse("19B10001-E8F2-537E-4F6C-D104768A1214"),
    serviceId: Uuid.parse("19B10000-E8F2-537E-4F6C-D104768A1214"),
    deviceId: deviceOfInterest.id);
