import 'package:flutter/cupertino.dart';
import 'package:toggle_switch/toggle_switch.dart';

bool isReverse = false;
bool isInNeutral = true;

Widget gearsWidget(BuildContext context) {
  return ToggleSwitch(
    minWidth: 50,
    radiusStyle: true,
    initialLabelIndex: 1,
    totalSwitches: 3,
    isVertical: true,
    labels: const ["D", "N", "R"],
    onToggle: (index) {
      switch (index) {
        case 0:
          isReverse = false;
          isInNeutral = false;
          break;
        case 1:
          isReverse = false;
          isInNeutral = true;
          break;
        case 2:
          isReverse = true;
          isInNeutral = false;
          break;
      }
    },
  );
}
