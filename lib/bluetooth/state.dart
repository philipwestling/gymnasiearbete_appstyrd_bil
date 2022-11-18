import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

late DiscoveredDevice deviceOfInterest;

abstract class ReactiveState<T> {
  Stream<T> get state;
}

class BleStatusMonitor implements ReactiveState<BleStatus?> {
  final FlutterReactiveBle flutterReactiveBle;
  const BleStatusMonitor(this.flutterReactiveBle);

  @override
  Stream<BleStatus?> get state => flutterReactiveBle.statusStream;
}
