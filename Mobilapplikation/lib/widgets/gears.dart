import 'package:flutter/cupertino.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/methods.dart';
import 'package:toggle_switch/toggle_switch.dart';

bool isReverse = false;
bool isInNeutral = true;

Widget gearsWidget(BuildContext context) {
  return ToggleSwitch(
    cornerRadius: 40,
    minWidth: 60,
    minHeight: 60,
    radiusStyle: true,
    initialLabelIndex: 1,
    totalSwitches: 3,
    isVertical: true,
    labels: const ["D", "N", "R"],
    fontSize: 20,
    onToggle: (index) {
      switch (index) {
        case 0:
          isReverse = false;
          isInNeutral = false;
          sendToUnoWifi(11);
          break;
        case 1:
          isReverse = false;
          isInNeutral = true;
          sendToUnoWifi(11);
          break;
        case 2:
          isReverse = true;
          isInNeutral = false;
          sendToUnoWifi(10);
          break;
      }
    },
  );
}
