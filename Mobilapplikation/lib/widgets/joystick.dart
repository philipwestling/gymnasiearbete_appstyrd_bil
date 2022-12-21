import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:gymnasiearbete_appstyrd_bil/bluetooth/methods.dart';
import 'package:num_remap/num_remap.dart';

Widget carSteeringWidget(BuildContext context) {
  double leftOrRight;
  double mappedLeftOrRight;
  return Row(
    children: [
      Joystick(
        mode: JoystickMode.horizontal,
        period: const Duration(milliseconds: 200),
        listener: ((details) {
          leftOrRight = double.parse(details.x.toStringAsFixed(2));

          mappedLeftOrRight = leftOrRight.remap(1, -1, 80, 160);
          sendToUnoWifi(mappedLeftOrRight.toInt());

          /*if (leftOrRight > 0) {
            sendToUnoWifi(3);
          } else if (leftOrRight < 0) {
            sendToUnoWifi(1);
          }*/
        }),
      ),
    ],
  );
}
