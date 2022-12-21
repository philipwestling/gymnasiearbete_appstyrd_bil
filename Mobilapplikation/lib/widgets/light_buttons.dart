import 'package:flutter/material.dart';

Widget lightButtons(BuildContext context) {
  bool isHighbeamActivated = false;
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      IconButton(
        onPressed: () {},
        // https://www.flaticon.com/free-icon/turn-signal_3674908?term=turn+signal&page=1&position=39&origin=search&related_id=3674908
        icon: Image.asset("lib/assets/images/turn_signal_left.png"),
        iconSize: 40,
      ),
      IconButton(
        onPressed: () {},
        // https://www.flaticon.com/free-icon/turn-signal_3674908?term=turn+signal&page=1&position=39&origin=search&related_id=3674908
        icon: Image.asset("lib/assets/images/turn_signal_right.png"),
        iconSize: 40,
      ),
      IconButton(
        onPressed: () {
          isHighbeamActivated = !isHighbeamActivated;
        },
        // https://www.flaticon.com/free-icon/high-beam_95138
        icon: isHighbeamActivated
            ? Image.asset("lib/assets/images/high_beam_activated.png")
            : Image.asset("lib/assets/images/high_beam_deactivated.png"),
        iconSize: 40,
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.settings),
        color: Colors.blueGrey,
        iconSize: 30,
      ),
    ],
  );
}
